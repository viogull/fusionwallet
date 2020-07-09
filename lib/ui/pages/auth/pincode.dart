import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fusion_wallet/ui/components/custom/fusion_scaffold.dart';
import 'package:fusion_wallet/ui/pages/v2/bloc.dart';
import 'package:fusion_wallet/ui/pages/v2/event.dart';

import '../../../localizations.dart';

class PasswordCreationPage extends StatefulWidget {
  final bool isCreating;
  static const String navId = '/pincode/create';

  PasswordCreationPage({this.isCreating = false});

  @override
  _PasswordCreationPageState createState() =>
      _PasswordCreationPageState(isCreating);
}

class _PasswordCreationPageState extends State<PasswordCreationPage> {
  bool isAuthenticated = false;
  bool isVerified = false;
  bool passCreate = false;

  _PasswordCreationPageState(bool isCreating) {
    this.passCreate = isCreating;
  }
  @override
  void initState() {
    super.initState();
    if (isAuthenticated) {
      //Navigator.of(context).pushNamed(BiometricAuthPage.navId);

    }
  }

  String pincode;

  String _otp = "";
  var _otpSymbols = [
    "\u{25CB}",
    "\u{25CB}",
    "\u{25CB}",
    "\u{25CB}",
    "\u{25CB}",
    "\u{25CB}"
  ];

  void _handleKeypadClick(String val, BuildContext context) {
    setState(() {
      if (_otp.length < 6) {
        _otp = _otp + val;
        for (int i = 0; i < _otp.length; i++) _otpSymbols[i] = "\u{25CF}";
      }
    });
    if (_otp.length == 6) {
      if (pincode != null && pincode == _otp) {
        BlocProvider.of<AuthenticationBloc>(context).add(
          PincodeCreatedEvent(pin: pincode),
        );
      } else {
        setState(() {
          this.pincode = _otp;
          this._otp = "";
          this._otpSymbols = [
            "\u{25CB}",
            "\u{25CB}",
            "\u{25CB}",
            "\u{25CB}",
            "\u{25CB}",
            "\u{25CB}"
          ];
        });
      }
    }
    print(_otp);
    if (_otp.length < 6) {
      passCreate = false;
    }
  }

  void _handleKeypadDel() {
    setState(() {
      if (_otp.length > 0) {
        _otp = _otp.substring(0, _otp.length - 1);
        for (int i = _otp.length; i < 6; i++) _otpSymbols[i] = "\u{25CB}";
      }
    });
    if (_otp.length < 6) passCreate = false;

    // print(_otp);
  }

  void _clean() {
    setState(() {
      if (_otp.length > 0) {
        _otp = _otp.substring(0, _otp.length - 1);
        for (int i = _otp.length; i < 6; i++) _otpSymbols[i] = "\u{25CB}";
      }
    });
    if (_otp.length < 6) passCreate = false;

    // print(_otp);
  }

//  void _handleSubmit() {
//    if (_otp.length == 6)
//    _scaffoldKey.currentState.showSnackBar(SnackBar(
//      content: Text('Entered OTP is $_otp'),
//    ));
//    else
//      print(_otp);
////      _scaffoldKey.currentState.showSnackBar(SnackBar(
////        content: Text('OTP has to be of 6 digits'),
////          backgroundColor: Colors.red,
////      ));
//  }

  @override
  Widget build(BuildContext context) {
    passCreate = ModalRoute.of(context).settings.arguments as bool;
    final textLabel =
//    if(_otp.length == 6 )
//      passCreate ?
        Stack(children: <Widget>[
      (pincode == null
          ? Container(
              height: 70,
              margin: const EdgeInsets.only(top: 30),
              child: Text(
                AppLocalizations.of(context).pinCreateTitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ))
          : Container(
              height: 70,
              margin: const EdgeInsets.only(top: 30),
              child: Text(
                AppLocalizations.of(context).labelChoosePassVerifySubtitle(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              )))
    ]);

    final pinCodeView = Padding(
      padding: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Text(
            _otpSymbols[0],
            style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w200,
                color: Theme.of(context).colorScheme.secondaryVariant),
          ),
          Text(
            _otpSymbols[1],
            style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w200,
                color: Theme.of(context).colorScheme.secondaryVariant),
          ),
          Text(
            _otpSymbols[2],
            style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w200,
                color: Theme.of(context).colorScheme.secondaryVariant),
          ),
          Text(
            _otpSymbols[3],
            style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w200,
                color: Theme.of(context).colorScheme.secondaryVariant),
          ),
          Text(
            _otpSymbols[4],
            style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w200,
                color: Theme.of(context).colorScheme.secondaryVariant),
          ),
          Text(
            _otpSymbols[5],
            style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w200,
                color: Theme.of(context).colorScheme.secondaryVariant),
          )
        ],
      ),
    );

    final keyboard = Container(
      padding: EdgeInsets.only(bottom: 32),
      alignment: Alignment.bottomCenter,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  KeyboardNumber(
                    n: 1,
                    onPressed: () {
                      // pinIndexSetup("0");
                      _handleKeypadClick('1', context);
                    },
                  ),
                  KeyboardNumber(
                    n: 2,
                    onPressed: () {
                      // pinIndexSetup("0");
                      _handleKeypadClick('2', context);
                    },
                  ),
                  KeyboardNumber(
                    n: 3,
                    onPressed: () {
                      // pinIndexSetup("0");
                      _handleKeypadClick('3', context);
                    },
                  ),
                ]),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  KeyboardNumber(
                    n: 4,
                    onPressed: () {
                      // pinIndexSetup("0");
                      _handleKeypadClick('4', context);
                    },
                  ),
                  KeyboardNumber(
                    n: 5,
                    onPressed: () {
                      // pinIndexSetup("0");
                      _handleKeypadClick('5', context);
                    },
                  ),
                  KeyboardNumber(
                    n: 6,
                    onPressed: () {
                      // pinIndexSetup("0");
                      _handleKeypadClick('6', context);
                    },
                  ),
                ]),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  KeyboardNumber(
                    n: 7,
                    onPressed: () {
                      // pinIndexSetup("0");
                      _handleKeypadClick('7', context);
                    },
                  ),
                  KeyboardNumber(
                    n: 8,
                    onPressed: () {
                      // pinIndexSetup("0");
                      _handleKeypadClick('8', context);
                    },
                  ),
                  KeyboardNumber(
                    n: 9,
                    onPressed: () {
                      // pinIndexSetup("0");
                      _handleKeypadClick('9', context);
                    },
                  ),
                ]),
            Container(
              margin: const EdgeInsets.only(bottom: 10.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    SizedBox(
                      width: 90,
                    ),
                    KeyboardNumber(
                      n: 0,
                      onPressed: () {
                        // pinIndexSetup("0");
                        _handleKeypadClick('0', context);
                      },
                    ),
//                        FlatButton(
//                          onPressed: () {
//                            _handleKeypadClick('0');
//                          },
////                          child: Text('0',
////                              style: TextStyle(
////                                  fontSize: 40,
////                                  color: Colors.black,
////                                  fontWeight: FontWeight.w400)),
//                        ),
                    FlatButton(
                      onPressed: () {
                        _handleKeypadDel();
                      },
                      child: Text('\u{232b}',
                          style: TextStyle(
                              fontSize: 40,
                              color: Theme.of(context)
                                  .colorScheme
                                  .secondaryVariant,
                              fontWeight: FontWeight.w400)),
                    ),
                  ]),
            ),
          ]),
    );

    return FusionScaffold(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Flexible(
              flex: 1,
              child: textLabel,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            Flexible(
              flex: 1,
              child: pinCodeView,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            Flexible(
              flex: 3,
              child: keyboard,
            ),
          ],
        ),
      ),
    );
  }

  void savePincode(String code) {
    debugPrint('Code $code');
  }
}

class KeyboardNumber extends StatelessWidget {
  final int n;
  final Function() onPressed;
  KeyboardNumber({this.n, this.onPressed});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50.0,
      height: 50.0,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              blurRadius: 5.0, // has the effect of softening the shadow
              spreadRadius: 2.0, // has the effect of extending the shadow
              offset: Offset(
                0.0, // horizontal, move right 10
                10.0, // vertical, move down 10
              ),
            )
          ],
          borderRadius: BorderRadius.circular(10),
          shape: BoxShape.rectangle,
          color: Theme.of(context).colorScheme.background),
      alignment: Alignment.center,
      child: MaterialButton(
        padding: EdgeInsets.all(8.0),
        onPressed: onPressed,
        elevation: 50,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        height: 90.0,
        child: Text(
          "$n",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24 * MediaQuery.of(context).textScaleFactor,
            color: Theme.of(context).colorScheme.onSurface,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

//import 'dart:async';
//
//import 'package:flutter/material.dart';
//import 'package:flutter_svg/flutter_svg.dart';
//import 'package:fusion_wallet/localizations.dart';
//import 'package:fusion_wallet/ui/components/custom/passcode/circle.dart';
//import 'package:fusion_wallet/ui/components/custom/passcode/keyboard.dart';
//import 'package:fusion_wallet/ui/components/custom/passcode/passcode_screen.dart';
//import 'package:fusion_wallet/ui/pages/auth/biometrics.dart';
//
//class PasswordCreationPage extends StatefulWidget {
//  static const String navId = '/PasswordCreationPage';
//  PasswordCreationPage({Key key, this.title}) : super(key: key);
//  final String title;
//
//  @override
//  State<StatefulWidget> createState() => _PasswordCreationPageState();
//}
//
//class _PasswordCreationPageState extends State<PasswordCreationPage> {
//  final StreamController<bool> _verificationNotifier =
//      StreamController<bool>.broadcast();
//
//  bool isAuthenticated = false;
//  bool isVerified = false;
//
//  @override
//  void initState() {
//    super.initState();
//    if (isAuthenticated) {
//      Navigator.of(context).pushNamed(BiometricAuthPage.navId);
//    }
//  }
//
//  @override
//  Widget build(BuildContext context,
//      {bool opaque,
//      CircleUIConfig circleUIConfig,
//      KeyboardUIConfig keyboardUIConfig}) {
//    final ThemeData theme = Theme.of(context);
//
//    final background = SvgPicture.asset(
//      ('assets/images/backgrounds/bg_primary.svg'),
//      fit: BoxFit.fill,
//      height: MediaQuery.of(context).size.height,
//      width: MediaQuery.of(context).size.width,
//    );
//
//    opaque = true;
//    return Scaffold(
//        body: Container(
//            child: Stack(
//      children: <Widget>[
//        background,
//        Container(
//          child: Stack(
//            children: <Widget>[
//              AppBar(
//                title: Text(
//                    AppLocalizations.of(context).toolbarRecoverFromSeedTitle()),
//                backgroundColor: Colors.transparent,
//                centerTitle: true,
//                elevation: 0,
//                iconTheme: IconThemeData(
//                  color: Theme.of(context).colorScheme.primary,
//                  size: 0,
//                ),
//              ),
////
//              PasscodeScreen(
//                title: (isVerified
//                    ? AppLocalizations.of(context)
//                        .labelChoosePassVerifySubtitle()
//                    : AppLocalizations.of(context).labelChoosePassSubtitle()),
//                circleUIConfig: circleUIConfig,
//                keyboardUIConfig: keyboardUIConfig,
//                passwordEnteredCallback: _onPasscodeEntered,
//                cancelLocalizedText: 'Cancel',
//                deleteLocalizedText: 'Delete',
//                shouldTriggerVerification: _verificationNotifier.stream,
//                // backgroundColor: Colors.black.withOpacity(0.8),
//                cancelCallback: onPasscodeCancelled,
//              ),
//            ],
//          ),
//        ),
//      ],
//    )));
//  }
//
//  _onPasscodeEntered(String enteredPasscode) {
//    bool isValid = '123456' == enteredPasscode;
//    _verificationNotifier.add(isValid);
//    if (isValid) {
//      setState(() {
//        this.isAuthenticated = isValid;
//      });
//    }
//  }
//
//  onPasscodeCancelled() {}
//
//  @override
//  void dispose() {
//    _verificationNotifier.close();
//    super.dispose();
//  }
//}
