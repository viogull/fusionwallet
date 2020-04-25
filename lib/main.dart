import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:fusion_wallet/ui/blocs/theme_bloc.dart';
import 'package:fusion_wallet/ui/pages/app_widgets.dart';
import 'package:fusion_wallet/ui/pages/auth/biometric_features_page.dart';
import 'package:fusion_wallet/ui/pages/auth/passphrase/passphrase_creation_page.dart';
import 'package:fusion_wallet/ui/pages/auth/passphrase/scan_qr_page.dart';
import 'package:fusion_wallet/ui/pages/auth/passphrase/share_qr_page.dart';
import 'package:fusion_wallet/ui/pages/bottom_home_page.dart';
import 'package:fusion_wallet/ui/pages/exchange/convert_funds_page.dart';
import 'package:fusion_wallet/ui/pages/exchange/rate_exhange_page.dart';
import 'package:fusion_wallet/ui/pages/information/add_contact_page.dart';
import 'package:fusion_wallet/ui/pages/information/transanction_history_page.dart';
import 'package:fusion_wallet/ui/pages/popups/edit_account_name_page.dart';
import 'package:fusion_wallet/ui/pages/popups/popups_history_page.dart';
import 'package:fusion_wallet/ui/pages/primary/contacts_page.dart';
import 'package:fusion_wallet/ui/pages/primary/history_page.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';


import 'localizations.dart';
import 'ui/pages/auth/account_creation_page.dart';
import 'ui/pages/auth/intro_page.dart';
import 'ui/pages/auth/password_creation_page.dart';
import 'ui/pages/auth/recover_account_page.dart';
import 'ui/pages/auth/terms_conditions_page.dart';
import 'ui/providers/bottom_navigation_provider.dart';
import 'ui/theme/fusion_theme.dart';
import 'ui/theme/theme_state.dart';

void main() => runApp(MyApp());
final logger = Logger();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => ThemeBloc(),
        child: BlocBuilder<ThemeBloc, ThemeState>(builder: _buildAppWithTheme));
  }

  Widget _buildAppWithTheme(BuildContext context, ThemeState themeState) {
    debugPrint('Building App with theme ${themeState.themeData.brightness}');
    return MaterialApp(
      theme: FusionTheme.dark.copyWith(
          buttonTheme: ButtonThemeData(
        shape: RoundedRectangleBorder(
            borderRadius: FusionTheme.borderRadius,
            side: BorderSide(color: FusionTheme.dark.colorScheme.background)),
      )),
      darkTheme: FusionTheme.dark,

      home: HomePage(),
      //HomePage(),
      localizationsDelegates: [
        const AppLocalizationsDelegate(),
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [const Locale('en', ''), const Locale('ru', '')],
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
        ConvertExchangePage.navId: (context) => ConvertExchangePage(),
        RateExchangePage.navId: (context) => RateExchangePage(),
//        PopupEditAccountName.navId: (context) => PopupEditAccountName(),

    },
    );
  }
}

class HomePage extends StatefulWidget {
  static const String navId = '/home';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
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
    logger.d('HomePage[BottomTabsPage, IdentifcationPage] start building.');
    return Scaffold(
      body: _buildHomepageBody(this.provider),
    );
  }

  Widget _buildHomepageBody(ChangeNotifierProvider provider) {
    return provider;
  }
}
