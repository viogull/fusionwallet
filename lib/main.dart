import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:fusion_wallet/ui/blocs/theme_bloc.dart';
import 'package:fusion_wallet/ui/pages/auth/biometric_features_page.dart';
import 'package:fusion_wallet/ui/pages/auth/passphrase/passphrase_creation_page.dart';
import 'package:fusion_wallet/ui/pages/auth/passphrase/scan_qr_page.dart';
import 'package:fusion_wallet/ui/pages/auth/passphrase/share_qr_page.dart';
import 'package:fusion_wallet/ui/pages/bottom_home_page.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import 'file:///C:/repos/newveer/fusion_wallet/lib/ui/pages/app_widgets.dart';

import 'localizations.dart';
import 'ui/pages/auth/account_creation_page.dart';
import 'ui/pages/auth/intro_page.dart';
import 'ui/pages/auth/password_creation_page.dart';
import 'ui/pages/auth/recover_account_page.dart';
import 'ui/pages/auth/terms_conditions_page.dart';
import 'ui/providers/bottom_navigation_provider.dart';
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
      theme: themeState.themeData.copyWith(
          buttonTheme: ButtonThemeData(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: BorderSide(color: Colors.black)),
      )),
      home: HomePage(),
      localizationsDelegates: [
        const AppLocalizationsDelegate(),
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [const Locale('en', ''), const Locale('ru', '')],
      locale: const Locale('ru', ''),
      initialRoute: HomePage.navId,
      routes: <String, WidgetBuilder>{
        HomePage.navId: (context) => HomePage(),
        PassphraseShareQrPage.navId: (context) => PassphraseShareQrPage(),
        AppWidgetsPage.navId: (context) => AppWidgetsPage(),
        BiometricAuthPage.navId: (context) => BiometricAuthPage(),
        ScanQrPage.navId: (context) => ScanQrPage(),
        PassphraseCreationPage.navId: (context) => PassphraseCreationPage(),
        IntroPage.navId: (BuildContext context) => IntroPage(),
        AccountCreationNamePage.navId: (BuildContext context) =>
            AccountCreationNamePage(),
        RecoverAccountPage.navId: (BuildContext context) =>
            RecoverAccountPage(),
        TermsConditionsPage.navId: (BuildContext context) =>
            TermsConditionsPage(),
        PasswordCreationPage.navId: (BuildContext context) =>
            PasswordCreationPage(),
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
