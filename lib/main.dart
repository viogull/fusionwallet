import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
<<<<<<< HEAD
import 'package:fusion_wallet/ui/theme/fusion_theme.dart';
import 'package:provider/provider.dart';


import 'localizations.dart';
import 'ui/pages/auth/intro_page.dart';

=======
import 'package:fusion_wallet/ui/pages/bottom_home_page.dart';
import 'package:fusion_wallet/ui/theme/fusion_theme.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import 'localizations.dart';
import 'ui/providers/bottom_navigation_provider.dart';
>>>>>>> abed716601f1a6b78c958802f47add5957bcc7a4

void main() => runApp(MyApp());
final logger = Logger();

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

<<<<<<< HEAD

=======
>>>>>>> abed716601f1a6b78c958802f47add5957bcc7a4
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: FusionTheme.light,
<<<<<<< HEAD
        //Provider.of<ThemesNotifier>(context).currentThemeData,
       //title:  AppLocalizations.of(context).appName(),
        home: IntroPage(),
=======
        home: HomePage(),
>>>>>>> abed716601f1a6b78c958802f47add5957bcc7a4
        localizationsDelegates: [
          const AppLocalizationsDelegate(),
          GlobalCupertinoLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('en', ''),
<<<<<<< HEAD
          //const Locale('ru', ''),
        ]
    );
=======
          const Locale('ru', ''),
        ]);
>>>>>>> abed716601f1a6b78c958802f47add5957bcc7a4
  }

}

<<<<<<< HEAD

class MyHomePage extends StatefulWidget  {

  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.
=======
class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
>>>>>>> abed716601f1a6b78c958802f47add5957bcc7a4

  static const String navId = '/home';

  final String title;


  @override
<<<<<<< HEAD
  _MyHomePageState createState() => _MyHomePageState();


=======
  _HomePageState createState() => _HomePageState();
>>>>>>> abed716601f1a6b78c958802f47add5957bcc7a4
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
<<<<<<< HEAD
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('widget.title'),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
=======
      body: _buildHomepageBody(this.provider),
>>>>>>> abed716601f1a6b78c958802f47add5957bcc7a4
    );
  }

  Widget _buildHomepageBody(ChangeNotifierProvider provider) {
    return provider;
  }
}
