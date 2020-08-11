import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fusion_wallet/core/state_container.dart';
import 'package:fusion_wallet/localizations.dart';
import 'package:fusion_wallet/main.dart';
import 'package:fusion_wallet/ui/components/custom/fusion_button.dart';
import 'package:fusion_wallet/ui/pages/bottom_home_page.dart';
import 'package:fusion_wallet/ui/pages/v2/bloc.dart';
import 'package:fusion_wallet/ui/pages/v2/event.dart';
import 'package:fusion_wallet/ui/theme.dart';
import 'package:local_auth/local_auth.dart';

class BiometricAuthPage extends StatefulWidget {
  static const navId = "/auth/biometric";

  @override
  State<StatefulWidget> createState() {
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
    logger.d('Checking biometrics availability');
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
    if (_availableBiometrics.isEmpty) return;
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
    } on Exception catch (e) {}
    if (!mounted) return;

    final String message = authenticated ? 'Authorized' : 'Not Authorized';
    setState(() {
      _authorized = message;
    });
    StateContainer.of(context).setBiometric(true);
    if (_isAuthenticating) {
      Navigator.pushNamed(context, HomePage.navId);
    }
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
    final isDarkMode = StateContainer.of(context).darkModeEnabled;
    return Scaffold(
        body: Stack(children: <Widget>[
      Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SvgPicture.asset(
          isDarkMode
              ? "assets/images/backgrounds/bg_primary.svg"
              : "assets/images/backgrounds/bg_primary_light.svg",
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          fit: BoxFit.fill,
        ),
      ),
      Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Flexible(
              flex: 4,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        AppLocalizations.of(context)
                            .labelEnableBiometricTitle(),
                        style: Theme.of(context).textTheme.headline6,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        AppLocalizations.of(context)
                            .labelEnableBiometricSubtitle(),
                        style: Theme.of(context).textTheme.subtitle1,
                        textAlign: TextAlign.center,
                      ),
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
              flex: 5,
              child: Center(
                child: Card(
                  borderOnForeground: false,
                  elevation: 16,
                  color: Theme.of(context).colorScheme.surface,
                  shape: RoundedRectangleBorder(
                    borderRadius: FusionTheme.borderRadius,
                  ),
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
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
                                color: Theme.of(context).colorScheme.primary,
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
                                      child:
                                          PlatformCircularProgressIndicator()),
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 4,
              child: Center(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.only(
                    left: 24.0,
                    right: 24.0,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: FusionButton(
                          text: AppLocalizations.of(context).labelYes(),
                          onPressed: () async {
                            await _authenticate();
                            BlocProvider.of<AuthenticationBloc>(context).add(

                                BiometricConfiguredEvent(
                                    enableBiometrics: true));
                          },
                        ),
                      ),
                      SizedBox(height: 15, width: 0),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: FusionButton(
                          text: AppLocalizations.of(context).labelNo(),
                          onPressed: () async {
                            BlocProvider.of<AuthenticationBloc>(context).add(
                                BiometricConfiguredEvent(
                                    enableBiometrics: false));
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    ]));
  }
}
