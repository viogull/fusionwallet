import 'dart:async';

import 'package:device_preview/device_preview.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:fusion_wallet/core/abstract/erc20_wallet.dart';
import 'package:fusion_wallet/ui/pages/erc20_ui.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:provider/provider.dart';

import 'core/abstract/admin_notification.dart';
import 'core/abstract/contact.dart';
import 'core/abstract/preferences.dart';
import 'core/minter_rest.dart';
import 'core/models.dart';
import 'core/state_container.dart';
import 'inject.dart';
import 'localizations.dart';
import 'ui/components/custom/passcode/passcode_screen.dart';
import 'ui/pages/accounts.dart';
import 'ui/pages/additional/add_account_ui.dart';
import 'ui/pages/auth/access_ui.dart';
import 'ui/pages/auth/account_name.dart';
import 'ui/pages/auth/biometrics.dart';
import 'ui/pages/auth/conditions.dart';
import 'ui/pages/auth/intro.dart';
import 'ui/pages/auth/passphrase.dart';
import 'ui/pages/auth/share_passphrase.dart';
import 'ui/pages/auth/pincode.dart';
import 'ui/pages/auth/recover.dart';
import 'ui/pages/auth/splash.dart';
import 'ui/pages/auth/ui.dart';
import 'ui/pages/primary.dart';
import 'ui/pages/convert.dart';
import 'ui/pages/rates.dart';
import 'ui/pages/info/faq.dart';
import 'ui/pages/info/feedback.dart';
import 'ui/pages/auth/lockscreen.dart';
import 'ui/pages/pages.dart';
import 'ui/pages/popups/popups_history_page.dart';

import 'ui/pages/history.dart';
import 'ui/pages/settings.dart';
import 'ui/pages/transactions/rewards.dart';
import 'ui/theme.dart';

const String preferencesBox = 'prefsBox';
const String accountsBox = 'accountsBox';
const String contactsBox = 'contactsBox';
const String notificationsBox = 'notificationsBox';
const String additionalAccountsBox = 'additionals';
const String erc20walletsBox = 'erc20walletsBox';

final wallet = Wallet();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  setupServiceLocator();

  injector.get<MinterRest>().loadInterceptors();

  await Hive.initFlutter();

  Hive.registerAdapter<Account>(AccountAdapter());
  Hive.registerAdapter<Contact>(ContactAdapter());
  Hive.registerAdapter<Preferences>(PreferencesAdapter());
  Hive.registerAdapter<AdminNotification>(AdminNotificationAdapter());
  Hive.registerAdapter<Erc20Wallet>(Erc20WalletAdapter());



  final accsBox = await Hive.openBox<Account>(accountsBox);
  await Hive.openBox<Account>(additionalAccountsBox);
  final ercWallets = await Hive.openBox<Erc20Wallet>(erc20walletsBox);
  try {
    await Hive.openBox<Contact>(contactsBox);
    final prefs = await Hive.openBox<Preferences>(preferencesBox);
    var _prefsSingle =
        prefs.values.isEmpty ? Preferences() : prefs.values.first;

    if (_prefsSingle.isInBox == false) prefs.add(_prefsSingle);

    await Hive.openBox<AdminNotification>(notificationsBox);

    logger.d("Checking availability of ERC20 Wallets. Exists: ${ercWallets.isNotEmpty}");

    OneSignal.shared.setLogLevel(OSLogLevel.debug, OSLogLevel.none);

    OneSignal.shared.init("64051c9d-c06c-419d-b1a3-10196218dda3", iOSSettings: {
      OSiOSSettings.autoPrompt: false,
      OSiOSSettings.inAppLaunchUrl: true
    });

    OneSignal.shared
        .setInFocusDisplayType(OSNotificationDisplayType.notification);

    runApp(DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => new StateContainer(
          child: new App(), accounts: accsBox, preferences: _prefsSingle),
    ));
  } on Exception catch (exception) {
    logger.d("Error on start");
  }
}

class App extends StatefulWidget {
  @override
  AppState createState() => AppState();
}

class AppState extends State<App> {
  @override
  void initState() {
    //  Instabug.start('d1b6a52e4472dc8189e4acc091569f17', [InvocationEvent.shake]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
        theme: FusionTheme.light,
        darkTheme: FusionTheme.dark,
        themeMode: StateContainer.of(context).darkModeEnabled
            ? ThemeMode.dark
            : ThemeMode.light,
        localizationsDelegates: [
          const AppLocalizationsDelegate(),
          GlobalCupertinoLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        locale: StateContainer.of(context).locale,
        builder: DevicePreview.appBuilder,
        supportedLocales: AppLocalizations.Locales,
        initialRoute: Splash.navId,
        routes: <String, WidgetBuilder>{
          Splash.navId: (context) => Splash(),
          LockUi.navId: (context) => LockUi(),
          AccessLockedUi.navId: (context) => AccessLockedUi(),
          HomePage.navId: (context) => HomePage(),
          ViewPassphraseDialog.navId: (context) => ViewPassphraseDialog(
                data: null,
              ),
          BiometricAuthPage.navId: (context) => BiometricAuthPage(),
          PassphraseCreationPage.navId: (context) => PassphraseCreationPage(),
          IntroPage.navId: (BuildContext context) => IntroPage(),
          AccountCreationNameForm.navId: (context) => AccountCreationNameForm(),
          RecoverAccountPage.navId: (context) => RecoverAccountPage(),
          TermsConditions.navId: (context) => TermsConditions(),
          PasswordCreationPage.navId: (context) => PasswordCreationPage(),
          History.navId: (context) => History(),
          PopupHistoryPage.navId: (context) => PopupHistoryPage(),
          ContactsPage.navId: (context) => ContactsPage(),
          AccountsPage.navId: (context) => AccountsPage(),
          SendFundsPage.navId: (context) => SendFundsPage(),
          RequestFundsPage.navId: (context) => RequestFundsPage(),
          DelegateFundsPage.navId: (context) => DelegateFundsPage(),
          UboundFundsPage.navId: (context) => UboundFundsPage(),
          PushFundsPage.navId: (context) => PushFundsPage(),
          SettingsPage.navId: (context) => SettingsPage(),
          RewardInformationPage.navId: (context) => RewardInformationPage(),
          ConvertPage.navId: (context) => ConvertPage(),
          RateExchangePage.navId: (context) => RateExchangePage(),
          SendFeedbackPage.navId: (context) => SendFeedbackPage(),
          FaqPage.navId: (context) => FaqPage(),
          PasscodeScreen.navId: (context) => PasswordCreationPage(),
          AuthUi.navId: (context) => AuthUi(),
          Erc20WalletUi.navId: (context) => Erc20WalletUi(),
          AddAccountUi.navId: (context) => AddAccountUi()
        },
      );
}

class HomePage extends StatefulWidget {
  static const String navId = '/home';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  var provider = ChangeNotifierProvider<BottomNavigationProvider>(
    child: BottomHomePage(),
    create: (context) => BottomNavigationProvider(),
  );

  Timer _timerLink;

  @override
  void initState() {
    super.initState();

    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData dynamicLink) async {
      final Uri deepLink = dynamicLink?.link;

      if (deepLink != null) {
        logger.d("Received deeplink " + dynamicLink.link.toString());
        if (dynamicLink.link
            .toString()
            .contains("https://fusion-push.cash/push/")) {
          logger.d("Detected PUSH deeplink");

          Timer.run(() {
            showCupertinoModalBottomSheet(
                context: context,
                builder: (BuildContext context, ScrollController controller) {
                  return ApplyPushDeeplink(url: dynamicLink.link.toString());
                });
          });
        } else {
          // https://fusiongroup.page.link/ref
          final Uri deep = dynamicLink.link;
          final ref = deep.queryParameters["from"];
          logger.d("Referal inviter : ${ref}");
          injector.get<Vault>().saveLastReferalInviter(ref);
          StateContainer.of(context).updateInviter(ref);
          Navigator.pushNamed(context, deepLink.path);
        }
      }
    }, onError: (OnLinkErrorException e) async {
      print('onLinkError');
      print(e.message);
    });
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _timerLink = new Timer(const Duration(milliseconds: 1000), () {
        _retrieveDynamicLink();
      });
    }
  }

  Future<void> _retrieveDynamicLink() async {
    final PendingDynamicLinkData data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    final Uri deepLink = data?.link;
    if (deepLink != null) {
      Navigator.pushNamed(context, deepLink.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(child: this.provider);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    if (_timerLink != null) {
      _timerLink.cancel();
    }
    super.dispose();
  }
}
