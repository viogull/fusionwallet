












import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:http/http.dart';
import 'package:logger/logger.dart';
import 'package:root_checker/root_checker.dart';

import 'service_locator.dart';
import 'ui/pages/auth/intro_page.dart';
import 'ui/pages/auth/password_creation_page.dart';
import 'utils/shared_prefs.dart';
import 'utils/vault.dart';

class Splash extends StatefulWidget {


  static const navId = "/splash";

  @override
  _SplashState createState() => _SplashState();
}


class _SplashState extends State<Splash> with WidgetsBindingObserver {
  bool _hasCheckedLoggedIn;
  bool _retried;




  bool seedIsEncrypted(String seed) {
    if(seed == null) {
      return false;
    } 
    try {
      // TODO Check if input seed is encrypted
      return true;
    } catch (e) {
      debugPrint(e);
      return false;
    }
  }

  Future checkLoggedIn() async {
    // Update session key
    await injector.get<Vault>().updateSessionKey();
    // Check if device is rooted or jailbroken, show user a warning informing them of the risks if so
    if (!(await injector.get<SharedPrefsUtil>().getHasSeenRootWarning()) &&
        (await RootChecker.isDeviceRooted)) {
  /*     AppDialogs.showConfirmDialog(
          context,
          CaseChange.toUpperCase(AppLocalizations.of(context).warning, context),
          AppLocalizations.of(context).rootWarning,
          AppLocalizations.of(context).iUnderstandTheRisks.toUpperCase(),
          () async {
            await injector.get<SharedPrefsUtil>().setHasSeenRootWarning();
            checkLoggedIn();
          },
          cancelText: AppLocalizations.of(context).exit.toUpperCase(),
          cancelAction: () {
            if (Platform.isIOS) {
              exit(0);
            } else {
              SystemChannels.platform.invokeMethod('SystemNavigator.pop');
            }
          });
      return; */
    }
    if (!_hasCheckedLoggedIn) {
      _hasCheckedLoggedIn = true;
    } else {
      return;
    }
    try {
      // iOS key store is persistent, so if this is first launch then we will clear the keystore
      bool firstLaunch = await injector.get<SharedPrefsUtil>().getFirstLaunch();
      if (firstLaunch) {
        debugPrint('Detected first start. Deleting datas if exists');
        await injector.get<Vault>().deleteAll();
      }
      await injector.get<SharedPrefsUtil>().setFirstLaunch();
      // See if logged in already
      bool isLoggedIn = false;
      bool isEncrypted = false;
      var seed = await injector.get<Vault>().getSeed();
      var pin = await injector.get<Vault>().getPin();
      // If we have a seed set, but not a pin - or vice versa
      // Then delete the seed and pin from device and start over.
      // This would mean user did not complete the intro screen completely.
      debugPrint('Seed ${seed}, pin ${pin}');

      if (seed != null && pin != null) {
        isLoggedIn = true;
        isEncrypted = seedIsEncrypted(seed);
      } else if (seed != null && pin == null) {
        await injector.get<Vault>().deleteSeed();
      } else if (pin != null && seed == null) {
        await injector.get<Vault>().deletePin();
      }

      if (isLoggedIn) {
        if (isEncrypted) {
          Navigator.of(context).pushReplacementNamed('/password_lock_screen');
        } else if (await injector.get<SharedPrefsUtil>().getLock() ||
            await injector.get<SharedPrefsUtil>().shouldLock()) {
          Navigator.of(context).pushReplacementNamed(PasswordCreationPage.navId);
        } else {
          // TODO login_account(seed, context)
          PriceConversion conversion =
              await injector.get<SharedPrefsUtil>().getPriceConversion();
          Navigator.of(context)
              .pushReplacementNamed('/home', arguments: conversion);
        }
      } else {
        Navigator.of(context).pushReplacementNamed(IntroPage.navId);
      }
    } catch (e) {
      /// Fallback secure storage
      /// A very small percentage of users are encountering issues writing to the
      /// Android keyStore using the flutter_secure_storage plugin.
      ///
      /// Instead of telling them they are out of luck, this is an automatic "fallback"
      /// It will generate a 64-byte secret using the native android "bottlerocketstudios" Vault
      /// This secret is used to encrypt sensitive data and save it in SharedPreferences
      if (Platform.isAndroid && e.toString().contains("flutter_secure")) {
        if (!(await injector.get<SharedPrefsUtil>().useLegacyStorage())) {
          await injector.get<SharedPrefsUtil>().setUseLegacyStorage();
          checkLoggedIn();
        }
      } else {
        await injector.get<Vault>().deleteAll();
        await injector.get<SharedPrefsUtil>().deleteAll();
        if (!_retried) {
          _retried = true;
          _hasCheckedLoggedIn = false;
          checkLoggedIn();
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _hasCheckedLoggedIn = false;
    _retried = false;
    if (SchedulerBinding.instance.schedulerPhase ==
        SchedulerPhase.persistentCallbacks) {
      SchedulerBinding.instance.addPostFrameCallback((_) => checkLoggedIn());
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Account for user changing locale when leaving the app
    switch (state) {
      case AppLifecycleState.paused:
        super.didChangeAppLifecycleState(state);
        break;
      case AppLifecycleState.resumed:
       // setLanguage();
        super.didChangeAppLifecycleState(state);
        break;
      default:
        super.didChangeAppLifecycleState(state);
        break;
    }
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
    );    
  }
}