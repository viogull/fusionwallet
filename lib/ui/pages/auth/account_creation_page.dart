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
            color: (theme.brightness == Brightness.dark)
                ? FusionTheme.dark.colorScheme.onPrimary
                : FusionTheme.light.colorScheme.onPrimary),
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
            color: (theme.brightness == Brightness.dark)
                ? FusionTheme.dark.colorScheme.onPrimary
                : FusionTheme.light.colorScheme.onPrimary,
          ),
          // obscureText: true,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: AppLocalizations.of(context).inputAccountNameHintText(),
            labelStyle: TextStyle(
                color: (theme.brightness == Brightness.dark)
                    ? FusionTheme.dark.colorScheme.onPrimary
                    : FusionTheme.light.colorScheme.onPrimary),
          ),
        ),
      ),
    );

    final loginButton = Container(
      height: 50,
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
                          checkColor: theme.primaryColor,
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
                              color: (theme.brightness == Brightness.dark)
                                  ? FusionTheme.dark.colorScheme.onPrimary
                                  : FusionTheme.light.colorScheme.onPrimary),
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
              child: ListView(
                children: <Widget>[
                  MyCustomAppBar(
                    height: 80,
                  ),
                  SizedBox(height: 70.0),
                  logo,
                  SizedBox(height: 35.0),
                  text,
                  SizedBox(height: 15.0),
                  email,
                  SizedBox(height: 35.0),
                  checkBox,
                  SizedBox(height: 70.0),
                  loginButton,
                ],
              ),
            ),
          ],
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
    final ThemeData theme = Theme.of(context);
    return Column(
      children: [
        Container(
          child: Padding(
              padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
              child: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: SvgPicture.asset(
                    'assets/images/icons/ic_next.svg',
                    height: 25.0,
                  ),
                ),
                title: Text(
                  AppLocalizations.of(context).buttonCreateAccount(),
                  style: TextStyle(
                      color: (theme.brightness == Brightness.dark)
                          ? FusionTheme.dark.colorScheme.onPrimary
                          : FusionTheme.light.colorScheme.onPrimary),
                ),
              )),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
