import 'package:flutter/material.dart';
//import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fusion_wallet/ui/theme/fusion_theme.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';


void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AccountCreationName(),
    ));

class AccountCreationName extends StatefulWidget {
  @override
  _AccountCreationNameState createState() => new _AccountCreationNameState();
}

class _AccountCreationNameState extends State<AccountCreationName> {
  final String assetName = 'assets/image_that_does_not_exist.svg';
  bool _rememberMeFlag = false;
  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
//    final logo = Hero(
//      tag: 'hero',
//      child: Center(
////        backgroundColor: Colors.transparent,
//
//        child: SvgPicture.asset(assetName),
//      ),
//    );

    final logo = SvgPicture.asset(
      ('assets/images/icons/next.svg'),
      placeholderBuilder: (context) => CircularProgressIndicator(),
      height: 200.0,
    );

    final text = Container(
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      child: Text("Account Name", style: TextStyle(color: (isDark)? FusionTheme.dark.colorScheme.onPrimary: FusionTheme.light.colorScheme.onPrimary  ),),
    );

    final email = Container(
      height: 30.0,
      child: Center(
        child: TextField(
          obscureText: true,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Please, name your account',
            labelStyle: TextStyle(color: (isDark)? FusionTheme.dark.colorScheme.onPrimary: FusionTheme.light.colorScheme.onPrimary),

          ),
        ),
      ),
    );

    final loginButton = Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Color.fromRGBO(187, 134, 252, 1),
      ),
      height: 50,

      child: PlatformButton(
        android: (_) => FusionTheme.buttonAndroidTheme,
        ios: (_) => FusionTheme.buttonIOSTheme,
        onPressed: () {},
        child: Center(
          child: Text(
            "NEXT",
            style: TextStyle(color: (isDark)? FusionTheme.dark.colorScheme.onPrimary: FusionTheme.light.colorScheme.onPrimary  ),),
        ),
      ),
    );

    final checkBox = Container(
        margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                GestureDetector(
                  child: Row(
                    children: <Widget>[
                      Checkbox(
                        value: _rememberMeFlag,
                        onChanged: (value) => setState(() {
                          _rememberMeFlag = !_rememberMeFlag;
                        }),
                      ),
                      GestureDetector(
                        child: Text(
                          "I agree with terms&conditions",
                          style: TextStyle(color: (isDark)? FusionTheme.dark.colorScheme.onPrimary: FusionTheme.light.colorScheme.onPrimary  ),
                        ),
                        onTap: () {},
//                        onTap: () =>
//                            setState(() {
//                              _rememberMeFlag = !_rememberMeFlag;
//                            }),
                      )
                    ],
                  ),
                  onTap: () => setState(() {
                    _rememberMeFlag = !_rememberMeFlag;
                  }),
                ),
              ],
            ),
          ],
        ));

    return SafeArea(
      top: false,
      right: false,
      bottom: false,
      left: false,
      child:
      Scaffold(
        //backgroundColor: Colors.white,

        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: <Widget>[
//          Align(
//            alignment: Alignment.topCenter,
//            child:
//          ),
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image:
                        AssetImage("assets/images/backgrounds/bg_primary.png"),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Column(
                  //shrinkWrap: true,

                  children: <Widget>[
                    MyCustomAppBar(
                      height: 80,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 24.0, right: 24.0,),
                      child: Column(
                        children: <Widget>[
                          logo,
                          //SizedBox(height: 10.0),
                          text,
                          email,
//            SizedBox(height: 0.0),
                          checkBox,
//            SizedBox(height: 0.0),
                          loginButton,
                        ],
                      ),

                    ),

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyCustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  final bool defaultAppBar;

  const MyCustomAppBar({
    Key key,
    @required this.height,
    this.defaultAppBar = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      children: [
        Container(
          child: Padding(
              padding: EdgeInsets.fromLTRB(25.0, 20.0, 25.0, 0.0),
              child: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back, color: Theme.of(context).primaryColor,),
                ),
//              actions: [
//                IconButton(
//                  icon: Icon(Icons.arrow_back),
//                  onPressed: () => null,
//                ),
//              ],
                title: Text(
                  "Recover from Seed",
                  style: TextStyle(color: (isDark)? FusionTheme.dark.colorScheme.onPrimary: FusionTheme.light.colorScheme.onPrimary  ),
                ),
              )),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}

//  Widget build(BuildContext context) {
//
//
//    return Scaffold(
//      appBar: AppBar (
//        title: Text('New Account'),
//      ),
//    body: Container(
//      height: MediaQuery.of(context).size.height ,
//      width: MediaQuery.of(context).size.width,
//      child:
//          Container(
//      child :  Stack(
//        children: <Widget> [
//
//          Container(
//            child: Center(
//              child: Image.asset('assets/images/backgrounds/bg_greeting.png'),
//            ),
//
//          ),
//          SizedBox(height: 50,),
//          Text ('Account Name:', textAlign: TextAlign.left)  ,
//
//           SizedBox(height: 50,),
//           Container(
////             height: 800,
////               width: 300,
//               child: Center(
//                 child:   TextField(
//                   obscureText: true,
//                   decoration: InputDecoration(
//                     border: OutlineInputBorder(),
//                     labelText: 'Please, name your account',
//
//                   ),
//                 ),
//
//               ),
//
//           ),
//
//        ]
////       Center(
////
////            child: Image.asset('assets/images/icons/ic_man.svg'),
////          ),
//
//          ),
//
//
//          ),
//
//
//
//
//    ),
//    );
//  }
