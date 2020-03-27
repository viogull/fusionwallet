import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fusion_wallet/localizations.dart';
import 'package:fusion_wallet/ui/components/custom/fusion_button.dart';
import 'package:fusion_wallet/ui/pages/auth/terms_conditions_page.dart';
import 'package:fusion_wallet/ui/theme/fusion_theme.dart';

class AccountCreationNamePage extends StatefulWidget {
  static const String navId = '/AccountCreationName';
  @override
  _AccountCreationNamePageState createState() =>
      new _AccountCreationNamePageState();
}

class _AccountCreationNamePageState extends State<AccountCreationNamePage> {
  bool _rememberMeFlag = false;
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    final background = SvgPicture.asset(
      ('assets/images/backgrounds/bg_primary.svg'),
      fit: BoxFit.fill,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
    );

    final logo = SvgPicture.asset(
      ('assets/images/icons/ic_man.svg'),
      placeholderBuilder: (context) => CircularProgressIndicator(),
      height: 200.0,
    );

    final text = Container(
      alignment: Alignment.topLeft,
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      child: Text(
        AppLocalizations.of(context).inputAccountNameHelperText(),
        style: TextStyle(
          color: (theme.colorScheme.onSurface),
        ),
      ),
    );

    final email = Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: theme.primaryColor),
      ),
      height: 30.0,
      child: Center(
        child: TextField(
          style: TextStyle(
            color: (theme.colorScheme.onSurface),
          ),
          // obscureText: true,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: AppLocalizations.of(context).inputAccountNameHintText(),
            labelStyle: TextStyle(
              color: (theme.colorScheme.onSurface),
            ),
          ),
        ),
      ),
    );

    final loginButton = Container(
      height: 50,
      width: MediaQuery.of(context).size.width,
      child: FusionButton(AppLocalizations.of(context).buttonNext(), () {}),
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
                      Transform.scale(
                        scale: 1.8,
                        child: Checkbox(
                          checkColor: theme.colorScheme.onPrimary,
                          value: _rememberMeFlag,
                          onChanged: (value) => setState(() {
                            _rememberMeFlag = !_rememberMeFlag;
                          }),
                        ),
                      ),
                      SizedBox(width: 15.0),
                      GestureDetector(
                        child: Text(
                          AppLocalizations.of(context)
                              .checkboxTermsConditions(),
                          style: TextStyle(
                            color: (theme.colorScheme.onSurface),
                          ),
                        ),
                        onTap: () {
                          Navigator.pushNamed(
                              context, TermsConditionsPage.navId);
                        },
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

    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: <Widget>[
            background,
            Container(
              padding: EdgeInsets.only(
                left: 24.0,
                right: 24.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  AppBar(
                    title: Text(AppLocalizations.of(context).toolbarRecoverFromSeedTitle()),
                    backgroundColor: Colors.transparent,
                    centerTitle: true ,
                    elevation: 0,
                    iconTheme: IconThemeData(
                        color: Theme.of(context).colorScheme.primary
                    ),
                  ),

                  //LimitedBox (maxHeight: 60,),
                  SizedBox(height: 5 ,),
                  Flexible(
                    flex: 7,
                    child: logo,
                  ),
//                  SizedBox(height: 10 ,),
                 // LimitedBox(maxHeight: 30,),
                  Flexible(
                    flex: 2 ,
                    child: text,
                  ),


                  Flexible(
                    flex: 4,
                    child: email,
                  ),
                  SizedBox(height: 15 ,),
                 // LimitedBox(maxHeight:30 ,),
                  Flexible(
                    flex: 2 ,
                    child: checkBox,
                  ),
                  SizedBox(height: 10 ,),
                  //LimitedBox(maxHeight: 50,),
                  Flexible(
                    flex: 5 ,
                    child: loginButton,
                  ),
                  SizedBox(height: 5.0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

