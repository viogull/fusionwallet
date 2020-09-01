import 'package:auto_size_text/auto_size_text.dart';
import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';

import '../../../inject.dart';
import '../../../localizations.dart';
import '../../../main.dart';
import '../../widgets.dart';
import '../pages.dart';

class LockscreenArgs {
  final String pin;
  final bool biometricEnabled;

  const LockscreenArgs({@required this.pin, @required this.biometricEnabled});
}

typedef OnUnlockCallback = Function();

class LockUi extends StatefulWidget {
  final AuthenticationBloc bloc;

  final log = injector.get<Logger>();

  LockUi({this.bloc});

  static const navId = "/lockscreen";

  @override
  _LockUiState createState() => _LockUiState();
}

class _LockUiState extends State<LockUi> with TickerProviderStateMixin {
  AnimationController _lockAnimController;
  String _expected;
  final _auth = LocalAuthentication();

  @override
  void initState() {
    widget.log.d("CanCheckBiometric() -> ");
    _lockAnimController = AnimationController(vsync: this);

    super.initState();
  }

  Widget _buildLockAnimation() => Container(
        width: 64,
        height: 64,
        child: Container(),
      );

  Future<bool> _isBiometricAvailable() async {
    bool isAvailable = false;
    try {
      isAvailable = await _auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      widget.log.e(e);
    }

    if (!mounted) return isAvailable;

    isAvailable
        ? widget.log.d('Biometric is available!')
        : widget.log.d('Biometric is unavailable.');

    return isAvailable;
  }

  Future<void> _getListOfBiometricTypes() async {
    List<BiometricType> listOfBiometrics;
    try {
      listOfBiometrics = await _auth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      widget.log.e(e);
    }

    if (!mounted) return;

    print(listOfBiometrics);
  }

  Future<void> _authenticateUser(BuildContext context) async {
    bool isAuthenticated = false;
    try {
      isAuthenticated = await _auth.authenticateWithBiometrics(
        localizedReason:
            AppLocalizations.of(context).authenticateToViewTransaction(),
        useErrorDialogs: true,
        stickyAuth: true,
      );
    } on PlatformException catch (e) {
      widget.log.e(e);
    }

    if (!mounted) return;

    isAuthenticated
        ? widget.log.d(AppLocalizations.of(context).userAuthorized())
        : widget.log.d(AppLocalizations.of(context).userNotAuthorized());

    if (isAuthenticated) {
      //injector.get<HapticUtil>().fingerprintSucess();
      Navigator.of(context).pushReplacementNamed(HomePage.navId);
    }
    Navigator.of(context).pushReplacementNamed(HomePage.navId);
  }

  @override
  Widget build(BuildContext context) {
    final pin =
        (ModalRoute.of(context).settings.arguments as LockscreenArgs).pin;

    return Center(
        child: FusionScaffold(
      child: Container(
          height: MediaQuery.of(context).size.height,
          child: StateContainer.of(context).biometricEnabled
              ? buildBiometricUnlockUi(context)
              : buildPinUnlockUi(context, pin)),
    ));
  }

  @override
  void dispose() {
    _lockAnimController.dispose();
    super.dispose();
  }

  Widget buildBiometricUnlockUi(BuildContext context) => Center(
          child: GestureDetector(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: _buildLockAnimation(),
        ),
        onTap: () async {
          if (await _isBiometricAvailable()) {
            await _getListOfBiometricTypes();
            await _authenticateUser(context);
          }
        },
      ));

  Widget buildPinUnlockUi(BuildContext context, String pin) => LockUiPincode(
        expected: pin,
      );
}

class LockUiPincode extends StatefulWidget {
  final String expected;

  const LockUiPincode({this.expected});

  @override
  _LockUiPincodeState createState() => _LockUiPincodeState();
}

class _LockUiPincodeState extends State<LockUiPincode> {
  bool isAuthenticated = false;
  bool passCreate = true;

  @override
  void initState() {
    super.initState();
    if (isAuthenticated) {
      Navigator.of(context).pushReplacementNamed(HomePage.navId);
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
      debugPrint(
          "PinLength is max, expected ${widget.expected}, entered $_otp");
      if (_otp == widget.expected) {
        FlashHelper.successBar(context,
            message: AppLocalizations.of(context).authSuccess());

        Future.delayed(Duration(milliseconds: 500), () {
          Navigator.of(context).pushReplacementNamed(HomePage.navId);
        });
      } else {
        Future.delayed(Duration(milliseconds: 200), () {
          FlashHelper.errorBar(context,
              message: AppLocalizations.of(context).pinInvalid);
        });
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

  @override
  Widget build(BuildContext context) {
    final textLabel = Stack(children: <Widget>[
      Container(
          height: 70,
          margin: const EdgeInsets.only(top: 8),
          child: AutoSizeText(
            AppLocalizations.of(context).labelUnlockSubtitle(),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w400,
            ),
          ))
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
                color: Theme.of(context).colorScheme.secondary),
          ),
          Text(
            _otpSymbols[1],
            style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w200,
                color: Theme.of(context).colorScheme.secondary),
          ),
          Text(
            _otpSymbols[2],
            style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w200,
                color: Theme.of(context).colorScheme.secondary),
          ),
          Text(
            _otpSymbols[3],
            style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w200,
                color: Theme.of(context).colorScheme.secondary),
          ),
          Text(
            _otpSymbols[4],
            style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w200,
                color: Theme.of(context).colorScheme.secondary),
          ),
          Text(
            _otpSymbols[5],
            style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w200,
                color: Theme.of(context).colorScheme.secondary),
          )
        ],
      ),
    );

    final keyboard = Container(
      padding: EdgeInsets.only(bottom: 16),
      alignment: Alignment.bottomCenter,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
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
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
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
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
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
            ),
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
      title: AppLocalizations.of(context).labelUnlockTitle(),
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
          Flexible(
            flex: 2,
            child: pinCodeView,
          ),
          Flexible(
            flex: 7,
            child: keyboard,
          ),
        ],
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
        padding: EdgeInsets.all(1.0),
        onPressed: () {
          injector.get<HapticUtil>().selection();
          onPressed.call();
        },
        elevation: 50,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        height: 90.0,
        child: AutoSizeText(
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
