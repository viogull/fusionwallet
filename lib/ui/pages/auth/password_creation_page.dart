import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fusion_wallet/localizations.dart';
import 'package:fusion_wallet/ui/components/custom/passcode/circle.dart';
import 'package:fusion_wallet/ui/components/custom/passcode/keyboard.dart';
import 'package:fusion_wallet/ui/components/custom/passcode/passcode_screen.dart';
import 'package:fusion_wallet/ui/pages/auth/intro_page.dart';

class PasswordCreationPage extends StatefulWidget {
  static const String navId = '/PasswordCreationPage';
  PasswordCreationPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  State<StatefulWidget> createState() => _PasswordCreationPageState();
}

class _PasswordCreationPageState extends State<PasswordCreationPage> {
  final StreamController<bool> _verificationNotifier =
      StreamController<bool>.broadcast();

  bool isAuthenticated = false;

  @override
  Widget build(BuildContext context,
      {bool opaque,
      CircleUIConfig circleUIConfig,
      KeyboardUIConfig keyboardUIConfig}) {
    final ThemeData theme = Theme.of(context);

    final background = SvgPicture.asset(
      ('assets/images/backgrounds/bg_primary.svg'),
      fit: BoxFit.fill,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
    );

    opaque = true;
    return Scaffold(
        body: Container(
            child: Stack(
      children: <Widget>[
        background,
        Container(
          child: Stack(
            children: <Widget>[
              MyCustomAppBar(
                height: 60,
              ),
              SizedBox(
                height: 30,
              ),
              PasscodeScreen(
                title: AppLocalizations.of(context).labelChoosePassSubtitle(),
                circleUIConfig: circleUIConfig,
                keyboardUIConfig: keyboardUIConfig,
                passwordEnteredCallback: _onPasscodeEntered,
                cancelLocalizedText: 'Cancel',
                deleteLocalizedText: 'Delete',
                shouldTriggerVerification: _verificationNotifier.stream,
                // backgroundColor: Colors.black.withOpacity(0.8),
                cancelCallback: onPasscodeCancelled,
              ),
            ],
          ),
        ),
      ],
    )));
  }

  _onPasscodeEntered(String enteredPasscode) {
    bool isValid = '123456' == enteredPasscode;
    _verificationNotifier.add(isValid);
    if (isValid) {
      setState(() {
        this.isAuthenticated = isValid;
      });
    }
  }

  onPasscodeCancelled() {}

  @override
  void dispose() {
    _verificationNotifier.close();
    super.dispose();
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
    return Column(children: [
      Container(
//          padding: EdgeInsets.only(left: 24.0, right: 24.0,),
        child: Padding(
          padding: EdgeInsets.all(1),
          child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              centerTitle: true,
              leading: IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, IntroPage.navId);
                },
                icon: LimitedBox(
                    maxWidth: 24,
                    maxHeight: 24,
                    child: SvgPicture.asset('assets/images/icons/ic_next.svg')),
              ),
              title: Text(
                //"Choose Password"
                AppLocalizations.of(context).toolbarChoosePassTitle(),
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              )),
        ),
      )
    ]);

    // Navigator.pushNamed(context , PasswordCreationPage.nav_id);
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
