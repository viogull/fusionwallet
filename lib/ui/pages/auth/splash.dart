import 'dart:io';

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:hive/hive.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:root_checker/root_checker.dart';

import './../../../core/models.dart';
import '../../../inject.dart';
import '../../../main.dart';
import '../../../utils/shared_prefs.dart';
import '../../../utils/vault.dart';
import '../../components/custom/fusion_scaffold.dart';
import '../pages.dart';
import 'access_ui.dart';
import 'ui.dart';

class Splash extends StatefulWidget {
  static const navId = "/splash";

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> with WidgetsBindingObserver {
  
  
  final logger = injector.get<Logger>();
  
  
  bool _hasCheckedLoggedIn;
  bool _retried;

  bool seedIsEncrypted(String seed) {
    if (seed == null) {
      return false;
    }
    try {
      return true;
    } catch (e) {
      logger.d(e);
      return false;
    }
  }

  Future checkLoggedIn() async {
    // Update session key

    injector.get<Vault>().updateSessionKey();
    // Check if device is rooted or jailbroken, show user a warning informing them of the risks if so
    if (!(await injector.get<SharedPrefsUtil>().getHasSeenRootWarning()) &&
        (await RootChecker.isDeviceRooted)) {}
    if (!_hasCheckedLoggedIn) {
      _hasCheckedLoggedIn = true;
    } else {
      return;
    }
    try {
      bool firstLaunch = await injector.get<SharedPrefsUtil>().getFirstLaunch();
      if (firstLaunch) {
        logger.d('Detected first start. Deleting datas if exists');
        await injector.get<Vault>().deleteAll();
      }
      await injector.get<SharedPrefsUtil>().setFirstLaunch();

      Box<Account> box = Hive.box(accountsBox);
      if (box.length < 1) {
        logger.d(
            'No Account Exists: ${box.length}. Navigating to intro page.');
        Navigator.of(context).pushReplacementNamed(AuthUi.navId);
      } else {
        Account lastAccount = box.getAt(box.length - 1);

        logger.d(
            'Accounts exists. Seed: ${lastAccount.pin}. Trying fetch access state');

        final accessRequest = await MinterRest().checkAccess(lastAccount);

        if (!accessRequest) {
          List<AdminNotification> notifications = await injector.get<MinterRest>().fetchNotifications();
          if(notifications.isNotEmpty) {
            logger.d("Saving ${notifications.length} to storage");
            Hive.box(notificationsBox).addAll(notifications);
          }
          Navigator.of(context).pushReplacementNamed(LockUi.navId,
              arguments:
                  LockscreenArgs(pin: lastAccount.pin, biometricEnabled: true));
        } else {
          Navigator.of(context).pushReplacementNamed(AccessLockedUi.navId);
        }
      }
    } catch (e) {
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
    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData dynamicLink) async {
      final Uri deepLink = dynamicLink?.link;

      if (deepLink != null) {
        logger.d("Received deeplink " + dynamicLink.link.toString());
        
        const reference = "https://fusiongroup.page.link/ref";
        final referalInviter = dynamicLink.link.resolve(reference).toString();
        logger.d("Link params: ${referalInviter}, address -> ${dynamicLink.link.toString()}");
        logger.d("From: ${referalInviter}");

        if(dynamicLink.link.toString().contains("https://fusion-push.cash/push") ) {
          logger.w("Detected PUSH deeplink. Opening Applier.");

         Future.delayed(Duration(milliseconds: 500), () {
           logger.d("Showing Push Receive Windows");
           showCupertinoModalBottomSheet(context: context, builder: (context, controller) {
             return ApplyPushDeeplink(url: dynamicLink.link.toString());
           });
         });
        } else if(dynamicLink.link.toString().contains('https://fusiongroup.page.link/promo/')) {
          logger.w("Detected promo referal deeplink");
        }
        Navigator.pushNamed(context, deepLink.path);
      }
    }, onError: (OnLinkErrorException e) async {
      print('onLinkError');
      print(e.message);
    });


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
    return new FusionScaffold(
        child: Center(
          child: (_hasCheckedLoggedIn) ? Column(
      children: [
          Flexible(
            flex: 8,
            child: Center(
              child:  Image.asset(
                "assets/images/icon.png",
                width: 98,
                height: 98,
                fit: BoxFit.contain,
              )
            ),
          )
      ],
    ): PlatformCircularProgressIndicator()
        ));
  }
}
