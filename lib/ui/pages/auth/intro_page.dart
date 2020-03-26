import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fusion_wallet/localizations.dart';
import 'package:fusion_wallet/ui/components/custom/fusion_button.dart';
import 'package:fusion_wallet/ui/pages/auth/account_creation_page.dart';
import 'package:fusion_wallet/ui/pages/auth/password_creation_page.dart';
import 'package:fusion_wallet/ui/pages/auth/recover_account_page.dart';
import 'package:fusion_wallet/ui/theme/fusion_theme.dart';

 void main() => runApp(
     MaterialApp(
       debugShowCheckedModeBanner: false,
       home: IntroPage(),
     )
 );

class IntroPage extends StatelessWidget {
  static const String nav_id = '/IntroPage';
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);


    final background = SvgPicture.asset(
      ('assets/images/backgrounds/bg_primary.svg'),
      fit: BoxFit.fill,
      //alignment: Alignment(0.0,0.0),
      height: MediaQuery.of(context).size.height,
//      width: MediaQuery.of(context).size.width,
    );

    final background2 = Image.asset(
      ('assets/images/backgrounds/bg_greeting.png'),
     fit: BoxFit.fitHeight,
     height: MediaQuery.of(context).size.height / 1.35 ,
      width: MediaQuery.of(context).size.width,
    );

    final logo = SvgPicture.asset(
      ('assets/images/icons/ic_logo.svg'),
      fit: BoxFit.fill,
      height: 100.0,
      //width: MediaQuery.of(context).size.width,
    );



    final someText1 = Container(
//      alignment: Alignment.topCenter,
      child: Text("Some greeting text",
        style: TextStyle(color: (theme.brightness == Brightness.dark) ?
        FusionTheme.dark.colorScheme.onPrimary : FusionTheme.light.colorScheme
            .onPrimary),
      ),
    );

    final someText2 = Container(
//      alignment: Alignment.topCenter,
      child: Text("Some greeting text",
        style: TextStyle(color: (theme.brightness == Brightness.dark) ?
        FusionTheme.dark.colorScheme.onPrimary : FusionTheme.light.colorScheme
            .onPrimary),
      ),
    );


    final buttonCreateAccount = Container(

      height: 50,
      width: MediaQuery.of(context).size.width,
      child: FusionButton(

          AppLocalizations.of(context).buttonCreateAccount(),
              () {
                Navigator.pushNamed(context , PasswordCreationPage.nav_id);
          } ,
      ),
    );

    final labelAlreadyHaveAccount = Container(
//      alignment: Alignment.topCenter,
      child: Text(AppLocalizations.of(context).labelAlreadyHaveAccount(),
        style: TextStyle(color: (theme.brightness == Brightness.dark) ?
        FusionTheme.dark.colorScheme.onPrimary : FusionTheme.light.colorScheme
            .onPrimary),
      ),
    );

    final buttonRecoverFromPassphrase = Container(
      height: 50,
      width: MediaQuery.of(context).size.width,
      child: FusionButton(
          AppLocalizations.of(context).buttonRecoverFromPassphrase(),
              () {
                Navigator.pushNamed(context , RecaverAccountPage.nav_id);
          }
      ),
    );



      return Scaffold(
               body: Container(
                 //margin: EdgeInsets.fromLTRB(00.0, 0.0, 0.0, 0.0),

                // alignment: Alignment(-1.0, -1.0),
                 //constraints: BoxConstraints.expand(),
//                 constraints: BoxConstraints.expand(width: MediaQuery.of(context).size.height, height: MediaQuery.of(context).size.width),
                 //height: MediaQuery.of(context).size.height,
                    child: Stack(
                      children: <Widget>[
                        background,
                        background2,
                        Container(
                          padding: EdgeInsets.only(left: 24.0, right: 24.0,),
                          child: Column(
                            children: <Widget>[
                              SizedBox(height: MediaQuery.of(context).size.height / 6.5),
                              logo,
                              SizedBox(height: MediaQuery.of(context).size.height / 18.5),
                              someText2,
                              SizedBox(height: MediaQuery.of(context).size.height / 20.5),
                              someText1,
                              SizedBox(height:250.0),
                              buttonCreateAccount,
                              SizedBox(height:30.0),
                              labelAlreadyHaveAccount,
                              SizedBox(height:30.0),
                              buttonRecoverFromPassphrase,
                            ],
                ),

              ),


            ],
          ),
               ),
      );
  }
}