import 'package:flutter/material.dart';
//import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:fusion_wallet/ui/theme/fusion_theme.dart';
void main() => runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RecaverAccountPage(),
    )
);



class RecaverAccountPage extends StatefulWidget {
  @override
  _RecaverAccountPage createState() => new _RecaverAccountPage();
}


class _RecaverAccountPage extends State<RecaverAccountPage> {

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

    final logo = SvgPicture.network(
      ('https://www.svgrepo.com/show/2046/dog.svg'),
      placeholderBuilder: (context) => CircularProgressIndicator(),
      height: 200.0,
    );

    final text = Container(
      margin:  EdgeInsets.symmetric(
          vertical: 10.0, horizontal: 10.0),
      child: Text("Account Name"),
    );

    final accountName =  Container(
      height:  30.0,
      child: Center(
        child:   TextField(


          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Please name your account',

          ),
        ),

      ),

    );

    final scanQR =  Container(
      height: 200.0,
      decoration:  BoxDecoration(
        borderRadius: BorderRadius.circular(5),
          border:  Border.all(color: Colors.black)
      ),

      child:  SizedBox.expand(
        child:  TextFormField(
            maxLines: 10,
            style: new TextStyle(
                fontSize: 16.0,
                // height: 2.0,
                //color: Colors.black
            ),
            decoration: const InputDecoration(
              hintText: "Enter Passphrase or Scan QR",
                suffixIcon: IconButton(
                    icon: Icon(Icons.code),

                  )),
            ),




              ),
              //contentPadding: const EdgeInsets.symmetric(vertical: 60.0),


    );




    final button = Container(
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
            "VERIFY",
            style: TextStyle(color: (isDark)? FusionTheme.dark.colorScheme.onPrimary: FusionTheme.light.colorScheme.onPrimary  ),),
        ),
      ),
    );




    return SafeArea(
     child: Scaffold(
      backgroundColor: Colors.white,
      appBar: MyCustomAppBar(
        height: 80,

      ),

      body: Center(

        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0,),
          children: <Widget>[
            logo,
            SizedBox(height: 10.0),
            text,
            accountName,
            SizedBox(height: 10.0),
            scanQR,
            SizedBox(height: 10.0),
            button,
//            SizedBox(height: 0.0),

//            SizedBox(height: 0.0),





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
    return Column(
      children: [
        Container(
          child: Padding(
            padding: EdgeInsets.fromLTRB(25.0, 20.0, 25.0, 0.0),
            child: AppBar(
//              actions: [
//                IconButton(
//                  icon: Icon(Icons.arrow_back),
//                  onPressed: () => null,
//                ),
//              ],
              title:  Text("Recover from Seed",),
            )

          ),
        ),
      ],
    );
  }


  @override
  Size get preferredSize => Size.fromHeight(height);
}