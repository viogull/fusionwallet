import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:fusion_wallet/ui/theme/fusion_theme.dart';

 void main() => runApp(
     MaterialApp(
       debugShowCheckedModeBanner: false,
       home: IntroPage(),
     )
 );

class IntroPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height ,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: <Widget>[

            Container(

//              decoration: BoxDecoration(
//                  image: DecorationImage(
//                      image: AssetImage('assets/images/backgrounds/bg_greeting.png'),
//                      fit: BoxFit.fill
//                  )
//              ),

                child:  Stack(
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height /1.6  ,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/images/backgrounds/bg_primary.png"),
                            fit: BoxFit.fill
                        )
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 200),
                    child: Center(
                      child: Text("LOGO", style: TextStyle(fontSize: 40, color: (isDark)? FusionTheme.dark.colorScheme.onPrimary: FusionTheme.light.colorScheme.onPrimary  ),),
                    ),
                  ),
                  Container(
                    //	margin: EdgeInsets.only(top: 10),
                    child: Center(
                      child: Text("Some greeting text", style: TextStyle(color: (isDark)? FusionTheme.dark.colorScheme.onPrimary: FusionTheme.light.colorScheme.onPrimary  ),),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 90),
                    child: Center(
                      child: Text("Some greeting text", style: TextStyle(color: (isDark)? FusionTheme.dark.colorScheme.onPrimary: FusionTheme.light.colorScheme.onPrimary  ),),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(30.0),
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              color: Color.fromRGBO(143, 148, 251, 2),
                              blurRadius: 20.0,
                              offset: Offset(0, 10)
                          )
                        ]
                    ),
                    child: Column(
                      children: <Widget>[

                      ],
                    ),
                  ),
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Color.fromRGBO(143, 148, 251, 2),
                    ),
                      child: PlatformButton(

                        android: (_) => FusionTheme.buttonAndroidTheme,
                        ios: (_) => FusionTheme.buttonIOSTheme,
                        onPressed: () {} ,
                    child: Center(
                        child:  Text("CREATE ACCOUNT",
                          style: TextStyle(color: (isDark)? FusionTheme.dark.colorScheme.onPrimary: FusionTheme.light.colorScheme.onPrimary  ),),
                  ),

                    ),
                  ),
                  SizedBox(height: 20,),

                  Text("Already have an account?", style: TextStyle(color: Colors.black ),),
                  SizedBox(height: 20,),
                  Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Color.fromRGBO(187, 134, 252, 1),
                       ),
                      height: 50,
                      child:  PlatformButton(
                        android: (_) => FusionTheme.buttonAndroidTheme,
                        ios: (_) => FusionTheme.buttonIOSTheme,
                          onPressed: () {},
                          child: Center(
                            child: Text(
                          "RECOVERY FROM PASSPHRASE",
                          style: TextStyle(color: (isDark)? FusionTheme.dark.colorScheme.onPrimary: FusionTheme.light.colorScheme.onPrimary  ),),
                        ),
                      ),
                  ),


                ],
              ),
            )
          ],
        ),

      ),

    );
  }
}