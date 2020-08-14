import 'dart:async';

import 'package:alice/alice.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:logger/logger.dart';
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
import 'ui/pages/auth/access_ui.dart';
import 'ui/pages/auth/account_name.dart';
import 'ui/pages/auth/biometrics.dart';
import 'ui/pages/auth/bloc/ui.dart';
import 'ui/pages/auth/conditions.dart';
import 'ui/pages/auth/intro.dart';
import 'ui/pages/auth/passphrase/passphrase.dart';
import 'ui/pages/auth/passphrase/share.dart';
import 'ui/pages/auth/pincode.dart';
import 'ui/pages/auth/recover.dart';
import 'ui/pages/auth/splash.dart';
import 'ui/pages/bottom_home.dart';
import 'ui/pages/exchange/convert_funds_page.dart';
import 'ui/pages/exchange/rate_exhange_page.dart';
import 'ui/pages/information/faq_page.dart';
import 'ui/pages/information/send_feedback_page.dart';
import 'ui/pages/lockscreen/lockscreen.dart';
import 'ui/pages/popups/popups_history_page.dart';
import 'ui/pages/primary/accounts/delegate.dart';
import 'ui/pages/primary/accounts/push_funds_page.dart';
import 'ui/pages/primary/accounts/request_funds_page.dart';
import 'ui/pages/primary/accounts/rewards_info_page.dart';
import 'ui/pages/primary/accounts/send_funds_page.dart';
import 'ui/pages/primary/accounts/unbound.dart';
import 'ui/pages/primary/contacts/contacts.dart';
import 'ui/pages/primary/history_page.dart';
import 'ui/pages/primary/settings.dart';
import 'ui/theme.dart';
import 'utils/vault.dart';

const String preferencesBox = 'prefsBox';
const String accountsBox = 'accountsBox';
const String contactsBox = 'contactsBox';
const String notificationsBox = 'notificationsBox';

final wallet = Wallet();

void main() async {
// or

  WidgetsFlutterBinding.ensureInitialized();

  setupServiceLocator();

  injector.get<MinterRest>().loadInterceptors();

  await Hive.initFlutter();

  Hive.registerAdapter<Account>(AccountAdapter());
  Hive.registerAdapter<Contact>(ContactAdapter());
  Hive.registerAdapter<Preferences>(PreferencesAdapter());
  Hive.registerAdapter<AdminNotification>(AdminNotificationAdapter());

  var accsBox = await Hive.openBox<Account>(accountsBox);

  await Hive.openBox<Contact>(contactsBox);
  final prefs = await Hive.openBox<Preferences>(preferencesBox);
  var prefsSingleton =
      prefs.values.isEmpty ? Preferences() : prefs.values.first;

  if (prefsSingleton.isInBox == false)
    prefs.add(prefsSingleton);


  await Hive.openBox<AdminNotification>(notificationsBox);

  OneSignal.shared.setLogLevel(OSLogLevel.debug, OSLogLevel.none);

  OneSignal.shared.init("64051c9d-c06c-419d-b1a3-10196218dda3", iOSSettings: {
    OSiOSSettings.autoPrompt: false,
    OSiOSSettings.inAppLaunchUrl: true
  });
  OneSignal.shared
      .setInFocusDisplayType(OSNotificationDisplayType.notification);

  runApp(new StateContainer(
    child: new App(),
    accounts: accsBox,
    preferences: prefsSingleton,
    alice: injector.get<Alice>()
  ));
}

class App extends StatefulWidget {
  @override
  AppState createState() => AppState();
}

class AppState extends State<App> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
        navigatorKey: injector.get<Alice>().getNavigatorKey(),
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
          HistoryPage.navId: (context) => HistoryPage(),
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
          ConvertExchangePage.navId: (context) => ConvertExchangePage(),
          RateExchangePage.navId: (context) => RateExchangePage(),
          SendFeedbackPage.navId: (context) => SendFeedbackPage(),
          FaqPage.navId: (context) => FaqPage(),
          PasscodeScreen.navId: (context) => PasswordCreationPage(),
          AuthUi.navId: (context) => AuthUi()
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
    injector.get<Vault>().getAccounts().then((accounts) {
      
    }
    ).catchError( (onError) {
      injector.get<Logger>().e("Error on loading account");
    });
    setState(() {
      
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
    final PendingDynamicLinkData data = await FirebaseDynamicLinks.instance.getInitialLink();
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
