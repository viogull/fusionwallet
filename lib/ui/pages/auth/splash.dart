import 'dart:io';

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:fusion_wallet/core/minter_rest.dart';
import 'package:fusion_wallet/core/models.dart';
import 'package:fusion_wallet/core/models/admin_notifications_response.dart';
import 'package:fusion_wallet/core/state_container.dart';
import 'package:fusion_wallet/main.dart';
import 'package:hive/hive.dart';
import 'package:root_checker/root_checker.dart';

import '../../../inject.dart';
import '../../../utils/shared_prefs.dart';
import '../../../utils/vault.dart';
import '../../components/custom/fusion_scaffold.dart';
import '../pages.dart';
import 'access_ui.dart';

class Splash extends StatefulWidget {
  static const navId = "/splash";

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> with WidgetsBindingObserver {
  bool _hasCheckedLoggedIn;
  bool _retried;


  final logger = injector.get<Logger>();

  bool seedIsEncrypted(String seed) {
    if (seed == null) {
      return false;
    }
    try {
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
        (await RootChecker.isDeviceRooted)) {}
    if (!_hasCheckedLoggedIn) {
      _hasCheckedLoggedIn = true;
    } else {
      return;
    }
    try {
      bool firstLaunch = await injector.get<SharedPrefsUtil>().getFirstLaunch();
      if (firstLaunch) {
        debugPrint('Detected first start. Deleting datas if exists');
        await injector.get<Vault>().deleteAll();
      }
      await injector.get<SharedPrefsUtil>().setFirstLaunch();

      Box<Account> box = Hive.box(accountsBox);
      if (box.length < 1 ) {
        debugPrint(
            'No Account Exists: ${box.length}. Navigating to intro page.');
        Navigator.of(context).pushReplacementNamed(AuthUi.navId);
      } else {
        Account lastAccount = box.getAt(box.length - 1);
        if(lastAccount.pin == null) {
          logger.d("Corrupted account. Deleting all");
         await injector.get<Vault>().deleteAll();
          Navigator.of(context).pushReplacementNamed(AuthUi.navId);

        }
        debugPrint(
            'Accounts exists. Seed: ${lastAccount.pin}. Trying fetch access state');


        final accessRequest = await MinterRest().checkAccess(lastAccount);

        if (!accessRequest) {
          if(lastAccount.pin != null) {
            injector.get<MinterRest>().fetchNotifications().then((value) => {
            Hive.box<AdminNotification>(notificationsBox)
                .addAll((value as AdminNotificationsResponse).notifications )
            }
            );
            Navigator.of(context).pushReplacementNamed(LockUi.navId,
                arguments:
                LockscreenArgs(pin: lastAccount.pin, biometricEnabled: true));
          } else {
            Navigator.of(context).pushReplacementNamed(AuthUi.navId);

          }
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
        // https://fusiongroup.page.link/ref
        final Uri deep = dynamicLink.link;
        final ref = deep.queryParameters["from"];
        logger.d("Referal inviter : ${ref}");
        injector.get<Vault>().saveLastReferalInviter(ref);
        StateContainer.of(context).updateInviter(ref);
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
