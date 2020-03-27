import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fusion_wallet/localizations.dart';
import 'package:fusion_wallet/ui/components/custom/fusion_button.dart';
import 'package:fusion_wallet/ui/pages/auth/recover_account_page.dart';
import 'package:fusion_wallet/ui/theme/fusion_theme.dart';

import 'password_creation_page.dart';

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

    final someText1 = Flexible(
//      alignment: Alignment.topCenter,
      flex: 1,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          "Some greeting text",
          style: TextStyle(
              color: (theme.brightness == Brightness.dark)
                  ? FusionTheme.dark.colorScheme.onPrimary
                  : FusionTheme.light.colorScheme.onPrimary),
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
        //height: MediaQuery.of(context).size.height,
        child: Stack(
          children: <Widget>[
            background,
            background2,
            Container(
              padding: EdgeInsets.only(
                left: 24.0,
                right: 24.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Flexible(
                          flex: 4,
                          child: SvgPicture.asset(
                            ('assets/images/icons/ic_logo.svg'),
                            fit: BoxFit.fill,
                            //width: MediaQuery.of(context).size.width,
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Some greeting text",
                              style: TextStyle(
                                  color: (theme.brightness == Brightness.dark)
                                      ? FusionTheme.dark.colorScheme.onPrimary
                                      : FusionTheme
                                          .light.colorScheme.onPrimary),
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: someText1,
                          ),
                        ),
                      ],
                    ),
                    flex: 6,
                  ),
                  Flexible(
                    flex: 6,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Flexible(
                          flex: 4,
                          child: Container(),
                        ),
                        Flexible(
                          flex: 2,
                          child: Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width,
                            child: FusionButton(
                              AppLocalizations.of(context)
                                  .buttonCreateAccount(),
                              () {
                                Navigator.pushNamed(
                                    context, PasswordCreationPage.navId);
                              },
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              AppLocalizations.of(context)
                                  .labelAlreadyHaveAccount(),
                              style: TextStyle(
                                  color: (theme.brightness == Brightness.dark)
                                      ? FusionTheme.dark.colorScheme.onSurface
                                      : FusionTheme
                                          .light.colorScheme.onSurface),
                            ),
                          ),
                        ),
                        Flexible(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 24),
                              child: buttonRecoverFromPassphrase,
                            )),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
