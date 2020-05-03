import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fusion_wallet/localizations.dart';
import 'package:fusion_wallet/ui/components/custom/fusion_button.dart';
import 'package:fusion_wallet/ui/pages/auth/password_creation_page.dart';
import 'package:fusion_wallet/ui/pages/auth/recover_account_page.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: IntroPage(),
    ));

class IntroPage extends StatelessWidget {
  static const String navId = '/IntroPage';
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
      height: MediaQuery.of(context).size.height / 1.35,
      width: MediaQuery.of(context).size.width,
    );

    final logo = SvgPicture.asset(
      ('assets/images/icons/ic_logo.svg'),
      fit: BoxFit.fill,
      height: 100.0,
      //width: MediaQuery.of(context).size.width,
    );

    final someText1 = Container(
      height: 20,
//      alignment: Alignment.topCenter,
      child: Text(
        "Some greeting text",
        style: TextStyle(
          color: (theme.colorScheme.onPrimary),
        ),
      ),
    );

    final someText2 = Container(
//      alignment: Alignment.topCenter,
      height: 20,
      child: Text(
        "Some greeting text",
        style: TextStyle(
          color: (theme.colorScheme.onPrimary),
        ),
      ),
    );

    final buttonCreateAccount = Container(
      height: 50,
      width: MediaQuery.of(context).size.width,
      child: FusionButton(
        AppLocalizations.of(context).buttonCreateAccount(),
        () {
          Navigator.pushNamed(context, PasswordCreationPage.navId);
        },
      ),
    );

    final labelAlreadyHaveAccount = Container(
      height: 20,
//      alignment: Alignment.topCenter,
      child: Text(
        AppLocalizations.of(context).labelAlreadyHaveAccount(),
        style: TextStyle(
          color: (theme.colorScheme.onSurface),
        ),
      ),
    );

    final buttonRecoverFromPassphrase = Container(
      height: 50,
      width: MediaQuery.of(context).size.width,
      child: FusionButton(
          AppLocalizations.of(context).buttonRecoverFromPassphrase(), () {
        Navigator.pushNamed(context, RecoverAccountPage.navId);
      }),
    );

    return Scaffold(
      body: Container(
        //margin: EdgeInsets.fromLTRB(00.0, 0.0, 0.0, 0.0),

        // alignment: Alignment(-1.0, -1.0),
        //constraints: BoxConstraints.expand(),
//                 constraints: BoxConstraints.expand(width: MediaQuery.of(context).size.height, height: MediaQuery.of(context).size.width),
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: <Widget>[
            background,
            background2,
            Container(
              height: MediaQuery.of(context).size.height,
              padding: EdgeInsets.only(
                left: 24.0,
                right: 24.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedBox(height: 60),
                  LimitedBox(maxHeight: 90),
                  Flexible(
                    child: logo,
                    flex: 6,
                  ),
                  SizedBox(height: 20),
                  Flexible(
                    child: someText2,
                    flex: 2,
                  ),
                  SizedBox(height: 20),
                  Flexible(
                    flex: 4,
                    child: someText1,
                  ),
                  SizedBox(height: 180),
                  LimitedBox(maxHeight: 230),
                  Flexible(
                    child: buttonCreateAccount,
                    flex: 5,
                  ),
                  SizedBox(height: 5),
                  Flexible(
                    child: labelAlreadyHaveAccount,
                    flex: 2,
                  ),
                  SizedBox(height: 5),
                  Flexible(flex: 5, child: buttonRecoverFromPassphrase),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
