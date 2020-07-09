import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:fusion_wallet/ui/pages/v2/ui.dart';

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:provider/provider.dart';

import 'core/models.dart';
import 'localizations.dart';
import 'inject.dart';
import 'ui/pages/auth/splash.dart';
import 'core/state_container.dart';
import 'theme/fusion_theme.dart';
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
import 'ui/pages/accounts_page.dart';
import 'ui/pages/primary/accounts/delegate_funds_page.dart';
import 'ui/pages/primary/accounts/push_funds_page.dart';
import 'ui/pages/primary/accounts/request_funds_page.dart';
import 'ui/pages/primary/accounts/rewards_info_page.dart';
import 'ui/pages/primary/accounts/send_funds_page.dart';
import 'ui/pages/primary/accounts/unbound_funds_page.dart';

import 'ui/pages/primary/contacts/contacts_page.dart';
import 'ui/pages/primary/contacts/add_contact.dart';
import 'ui/pages/primary/contacts/contacts.dart';
import 'ui/pages/primary/history_page.dart';
import 'ui/pages/primary/settings_page.dart';
import 'ui/providers/bottom_navigation_provider.dart';

const String preferencesBox = 'prefsBox';
const String accountsBox = 'accountsBox';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupServiceLocator();
  await Hive.initFlutter();
  Hive.registerAdapter<Account>(AccountAdapter());
  Hive.registerAdapter<Contact>(ContactAdapter());
  var accsBox = await Hive.openBox<Account>(accountsBox);
  runApp(new StateContainer(
    child: new App(),
    accounts: accsBox,
  ));
}

class App extends StatelessWidget {
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
        supportedLocales: AppLocalizations.Locales,
        initialRoute: Splash.navId,
        routes: <String, WidgetBuilder>{
          Splash.navId: (context) => Splash(),
          LockUi.navId: (context) => LockUi(),
          HomePage.navId: (context) => HomePage(),
          ViewPassphraseDialog.navId: (context) => ViewPassphraseDialog(
                data: null,
              ),
          BiometricAuthPage.navId: (context) => BiometricAuthPage(),
          PassphraseCreationPage.navId: (context) => PassphraseCreationPage(),
          IntroPage.navId: (BuildContext context) => IntroPage(),
          AccountCreationNamePage.navId: (context) => AccountCreationNamePage(),
          RecoverAccountPage.navId: (context) => RecoverAccountPage(),
          TermsConditionsPage.navId: (context) => TermsConditionsPage(),
          PasswordCreationPage.navId: (context) => PasswordCreationPage(),
          HistoryPage.navId: (context) => HistoryPage(),
          PopupHistoryPage.navId: (context) => PopupHistoryPage(),
          ContactsPage.navId: (context) => ContactsPage(),
          AddContactPage.navId: (context) => AddContactPage(),
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
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  var provider = ChangeNotifierProvider<BottomNavigationProvider>(
    child: BottomHomePage(),
    create: (context) => BottomNavigationProvider(),
  );

  @override
  Widget build(BuildContext context) {
    return Material(child: this.provider);
  }
}
