import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:fusion_wallet/service_locator.dart';
import 'package:fusion_wallet/state_container.dart';
import 'package:fusion_wallet/ui/pages/app_widgets.dart';
import 'package:fusion_wallet/ui/pages/auth/biometric_features_page.dart';
import 'package:fusion_wallet/ui/pages/auth/passphrase/passphrase_creation_page.dart';
import 'package:fusion_wallet/ui/pages/auth/passphrase/scan_qr_page.dart';
import 'package:fusion_wallet/ui/pages/auth/passphrase/share_qr_page.dart';
import 'package:fusion_wallet/ui/pages/bottom_home_page.dart';
import 'package:fusion_wallet/ui/pages/exchange/convert_funds_page.dart';
import 'package:fusion_wallet/ui/pages/exchange/rate_exhange_page.dart';
import 'package:fusion_wallet/ui/pages/information/add_contact_page.dart';
import 'package:fusion_wallet/ui/pages/information/faq_page.dart';
import 'package:fusion_wallet/ui/pages/information/send_feedback_page.dart';
import 'package:fusion_wallet/ui/pages/popups/popups_history_page.dart';
import 'package:fusion_wallet/ui/pages/primary/accounts/accounts_page.dart';
import 'package:fusion_wallet/ui/pages/primary/accounts/delegate_funds_page.dart';
import 'package:fusion_wallet/ui/pages/primary/accounts/push_funds_page.dart';
import 'package:fusion_wallet/ui/pages/primary/accounts/request_funds_page.dart';
import 'package:fusion_wallet/ui/pages/primary/accounts/rewards_info_page.dart';
import 'package:fusion_wallet/ui/pages/primary/accounts/send_funds_page.dart';
import 'package:fusion_wallet/ui/pages/primary/accounts/unbound_funds_page.dart';
import 'package:fusion_wallet/ui/pages/primary/contacts_page.dart';
import 'package:fusion_wallet/ui/pages/primary/history_page.dart';
import 'package:fusion_wallet/ui/pages/primary/settings_page.dart';
import 'package:fusion_wallet/ui/pages/primary/share_qr_address_page.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'localizations.dart';
import 'ui/pages/auth/account_creation_page.dart';
import 'ui/pages/auth/intro_page.dart';
import 'ui/pages/auth/password_creation_page.dart';
import 'ui/pages/auth/recover_account_page.dart';
import 'ui/pages/auth/terms_conditions_page.dart';
import 'ui/providers/bottom_navigation_provider.dart';
import 'ui/theme/fusion_theme.dart';

const preferencesBox = 'prefsBox';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupServiceLocator();
  await Hive.initFlutter();
  Hive.openBox(preferencesBox).then((box) {
    runApp(new StateContainer(
      child: new App(),
      preferences: box,
    ));
  });
}

class App extends StatelessWidget {
  Widget build(BuildContext context) => MaterialApp(
        theme: FusionTheme.light,
        darkTheme: FusionTheme.dark,
        themeMode: StateContainer.of(context).themeMode,
        localizationsDelegates: [
          const AppLocalizationsDelegate(),
          GlobalCupertinoLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        locale: StateContainer.of(context).locale,
        supportedLocales: AppLocalizations.Locales,
        initialRoute: HomePage.navId,
        routes: <String, WidgetBuilder>{
          HomePage.navId: (context) => HomePage(),
          PassphraseShareQrPage.navId: (context) => PassphraseShareQrPage(),
          AppWidgetsPage.navId: (context) => AppWidgetsPage(),
          BiometricAuthPage.navId: (context) => BiometricAuthPage(),
          ScanQrPage.navId: (context) => ScanQrPage(),
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
          ShareQrPage.navId: (context) => ShareQrPage()
//        PopupEditAccountName.navId: (context) => PopupEditAccountName(),
        },
      );
}

class HomePage extends StatefulWidget {
  static const String navId = '/home';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  }

  var provider = ChangeNotifierProvider<BottomNavigationProvider>(
    child: BottomHomePage(),
    create: (context) => BottomNavigationProvider(),
  );

  @override
  Widget build(BuildContext context) {
    return Material(
      child: _buildHomepageBody(this.provider),
    );
  }

  Widget _buildHomepageBody(ChangeNotifierProvider provider) {
    return provider;
  }
}
