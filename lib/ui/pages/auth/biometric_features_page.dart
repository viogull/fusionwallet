import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fusion_wallet/localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_auth/local_auth.dart';

class BiometricAuthPage extends StatefulWidget {
  static const navId = "/auth/biometric";

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _BiometricAuthPageState();
  }
}

class _BiometricAuthPageState extends State<BiometricAuthPage> {
  final LocalAuthentication auth = LocalAuthentication();
  bool _canCheckBiometrics;
  List<BiometricType> _availableBiometrics;
  String _authorized = 'Not Authorized';
  bool _isAuthenticating = false;

  Future<void> _checkBiometrics() async {
    bool canCheckBiometrics;
    try {
      canCheckBiometrics = await auth.canCheckBiometrics;
    } on Exception catch (e) {
      print(e);
    }
    if (!mounted) return;

    setState(() {
      _canCheckBiometrics = canCheckBiometrics;
    });
  }

  Future<void> _getAvailableBiometrics() async {
    List<BiometricType> availableBiometrics;
    try {
      availableBiometrics = await auth.getAvailableBiometrics();
    } on Exception catch (e) {
      print(e);
    }
    if (!mounted) return;

    setState(() {
      _availableBiometrics = availableBiometrics;
    });
  }

  Future<void> _authenticate() async {
    bool authenticated = false;
    try {
      setState(() {
        _isAuthenticating = true;
        _authorized = 'Authenticating';
      });
      authenticated = await auth.authenticateWithBiometrics(
          localizedReason: 'Scan your fingerprint to authenticate',
          useErrorDialogs: true,
          stickyAuth: true);
      setState(() {
        _isAuthenticating = false;
        _authorized = 'Authenticating';
      });
    } on Exception catch (e) {
      print(e);
    }
    if (!mounted) return;

    final String message = authenticated ? 'Authorized' : 'Not Authorized';
    setState(() {
      _authorized = message;
    });
  }

  void _cancelAuthentication() {
    auth.stopAuthentication();
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getAvailableBiometrics();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: Text(
          AppLocalizations.of(context).settingsItemBiometricFeature(),
          style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
        ),
        android: (_) => MaterialAppBarData(
            centerTitle: true,
            elevation: 0,
            automaticallyImplyLeading: true,
            iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
            backgroundColor: Colors.transparent),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.85,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Flexible(
              flex: 2,
              child: Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      AppLocalizations.of(context).labelEnableBiometricTitle(),
                      style: GoogleFonts.latoTextTheme().headline6,
                    ),
                    Text(
                      AppLocalizations.of(context)
                          .labelEnableBiometricSubtitle(),
                      style: GoogleFonts.latoTextTheme().subtitle1,
                    ),
                  ],
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: Container(),
            ),
            Flexible(
              flex: 4,
              child: Card(
                elevation: 16,
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                child: LimitedBox(
                  maxWidth: MediaQuery.of(context).size.width * 0.7,
                  maxHeight: 150,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          width: 75,
                          height: 75,
                          child: SvgPicture.asset(
                              "assets/images/icons/ic_faceid.svg",
                              semanticsLabel: 'Face ID',
                              color: Theme.of(context).primaryColor,
                              placeholderBuilder: (BuildContext context) =>
                                  Container(
                                      padding: const EdgeInsets.all(30.0),
                                      child:
                                          PlatformCircularProgressIndicator())),
                        ),
                        SizedBox(
                          width: 75,
                          height: 75,
                          child: SvgPicture.asset(
                            "assets/images/icons/ic_touchid.svg",
                            semanticsLabel: 'Touch ID',
                            placeholderBuilder: (BuildContext context) =>
                                Container(
                                    padding: const EdgeInsets.all(30.0),
                                    child: PlatformCircularProgressIndicator()),
                            color: Theme.of(context).primaryColor,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 2,
              child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
                  child: Column(
                    children: <Widget>[
                      PlatformButton(
                        child: Text(AppLocalizations.of(context).labelYes()),
                        color: Theme.of(context).primaryColor,
                        onPressed: () async {
                          _checkBiometrics();
                          _authenticate();
                        },
                      ),
                      PlatformButton(
                        child: Text(AppLocalizations.of(context).labelNo()),
                        color: Theme.of(context).primaryColor,
                        onPressed: () {},
                      ),
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }
}
