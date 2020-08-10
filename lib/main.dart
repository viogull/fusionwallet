import 'package:alice/alice.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:fusion_wallet/core/abstract/preferences.dart';
import 'package:fusion_wallet/ui/pages/routes.dart';
import 'package:fusion_wallet/ui/pages/v2/ui.dart';

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import 'package:provider/provider.dart';

import 'core/abstract/contact.dart';
import 'core/minter_rest.dart';
import 'core/models.dart';
import 'localizations.dart';
import 'inject.dart';
import 'ui/pages/auth/access_ui.dart';
import 'ui/pages/auth/splash.dart';
import 'core/state_container.dart';
import 'ui/pages/lockscreen/lockscreen.dart';
import 'ui/theme.dart';
import 'ui/components/custom/passcode/passcode_screen.dart';
import 'ui/pages/auth/account_name.dart';
import 'ui/pages/auth/biometrics.dart';
import 'ui/pages/auth/intro.dart';
import 'ui/pages/auth/passphrase/passphrase.dart';
import 'ui/pages/auth/passphrase/share_qr_page.dart';
import 'ui/pages/auth/pincode.dart';
import 'ui/pages/auth/recover_account_page.dart';
import 'ui/pages/auth/terms_and_conditions.dart';
import 'ui/pages/bottom_home_page.dart';
import 'ui/pages/exchange/convert_funds_page.dart';
import 'ui/pages/exchange/rate_exhange_page.dart';
import 'ui/pages/information/faq_page.dart';
import 'ui/pages/information/send_feedback_page.dart';
import 'ui/pages/popups/popups_history_page.dart';
import 'ui/pages/accounts.dart';
import 'ui/pages/primary/accounts/delegate_funds_page.dart';
import 'ui/pages/primary/accounts/push_funds_page.dart';
import 'ui/pages/primary/accounts/request_funds_page.dart';
import 'ui/pages/primary/accounts/rewards_info_page.dart';
import 'ui/pages/primary/accounts/send_funds_page.dart';
import 'ui/pages/primary/accounts/unbound_funds_page.dart';

import 'ui/pages/primary/contacts/contacts_page.dart';

import 'ui/pages/primary/history_page.dart';
import 'ui/pages/primary/settings_page.dart';

const String preferencesBox = 'prefsBox';
const String accountsBox = 'accountsBox';
const String contactsBox = 'contactsBox';

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

  var accsBox = await Hive.openBox<Account>(accountsBox);

  await Hive.openBox<Contact>(contactsBox);
  final prefs = await Hive.openBox<Preferences>(preferencesBox);
  var prefsSingleton =
      prefs.values.isEmpty ? Preferences() : prefs.values.first;

  if (prefsSingleton.isInBox == false) prefs.add(prefsSingleton);
  OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

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
          TermsConditionsPage.navId: (context) => TermsConditionsPage(),
          PasswordCreationPage.navId: (context) => PasswordCreationPage(),
          HistoryPage.navId: (context) => HistoryPage(),
          PopupHistoryPage.navId: (context) => PopupHistoryPage(),
          ContactsPage.navId: (context) => ContactsPage(),
          AccountsPage.navId: (context) => AccountsPage(),
          SendFundsPage.navId: (context) => SendFundsPage(),
          RequestFundsPage.navId: (context) => RequestFundsPage(),
          DelegateFundsPage.navId: (context) => DelegateFundsPage(),
          UnboundFundsPage.navId: (context) => UnboundFundsPage(),
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

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  void initDynamicLinks(BuildContext context) async {}

  @override
  Widget build(BuildContext context) {
    return Material(child: this.provider);
  }
}
