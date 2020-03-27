import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fusion_wallet/localizations.dart';
import 'package:fusion_wallet/ui/components/custom/passcode/circle.dart';
import 'package:fusion_wallet/ui/components/custom/passcode/keyboard.dart';
import 'package:fusion_wallet/ui/components/custom/passcode/passcode_screen.dart';
import 'package:fusion_wallet/ui/pages/auth/biometric_features_page.dart';
import 'package:fusion_wallet/ui/pages/auth/intro_page.dart';
import 'package:fusion_wallet/ui/theme/fusion_theme.dart';

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
  bool isVerified = false;

  @override
  void initState() {
    super.initState();
        if (isAuthenticated) {
          Navigator.of(context).pushNamed(BiometricAuthPage.navId);
        }
  }

  @override
  Widget build(BuildContext context,
      {bool opaque,
      CircleUIConfig circleUIConfig,
      KeyboardUIConfig keyboardUIConfig
      }) {
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
                        AppBar(
                          title: Text(AppLocalizations.of(context).toolbarRecoverFromSeedTitle()),
                          backgroundColor: Colors.transparent,
                          centerTitle: true ,
                          elevation: 0,
                          iconTheme: IconThemeData(
                              color: Theme.of(context).colorScheme.primary,
                            size: 0,
                          ),
                        ),
//
                        PasscodeScreen(

                title: (isVerified ? AppLocalizations.of(context).labelChoosePassVerifySubtitle(): AppLocalizations.of(context).labelChoosePassSubtitle()),
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
    if (isValid)  {
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


