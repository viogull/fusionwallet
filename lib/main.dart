import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:fusion_wallet/ui/pages/auth/account_creation_page.dart';
import 'package:fusion_wallet/ui/pages/auth/intro_page.dart';
import 'package:fusion_wallet/ui/pages/auth/password_creation_page.dart';
import 'package:fusion_wallet/ui/pages/auth/recover_account_page.dart';
import 'package:fusion_wallet/ui/pages/auth/terms_conditions_page.dart';
import 'package:fusion_wallet/ui/pages/bottom_home_page.dart';
import 'package:fusion_wallet/ui/theme/fusion_theme.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import 'localizations.dart';
import 'ui/providers/bottom_navigation_provider.dart';

void main() => runApp(MyApp());
final logger = Logger();

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: FusionTheme.light.copyWith(buttonTheme: ButtonThemeData(

          shape: RoundedRectangleBorder(
              borderRadius:  BorderRadius.circular(10.0),
              side: BorderSide(color: Colors.black)),
        ) ),
        initialRoute: IntroPage.nav_id,
        routes: {
          IntroPage.nav_id: (BuildContext context) => IntroPage(),
          AccountCreationName.nav_id: (BuildContext context) => AccountCreationName(),
          RecaverAccountPage.nav_id: (BuildContext context) => RecaverAccountPage(),
          TermsConditions.nav_id: (BuildContext context) => TermsConditions(),
          PasswordCreationPage.nav_id: (BuildContext context) => PasswordCreationPage(),

        },
        localizationsDelegates: [
          const AppLocalizationsDelegate(),
          GlobalCupertinoLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        locale: const Locale('en', ''),
        supportedLocales: [
          const Locale('en', ''),
          const Locale('ru', ''),
        ]

    );

  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  static const String navId = '/home';

  final String title;

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
    // This method is rerun every time s etState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      body: _buildHomepageBody(this.provider),
    );
  }

  Widget _buildHomepageBody(ChangeNotifierProvider provider) {
    return provider;
  }
}
