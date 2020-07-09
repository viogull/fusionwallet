import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fusion_wallet/main.dart';
import 'package:fusion_wallet/ui/pages/auth/splash.dart';
import 'package:fusion_wallet/ui/pages/auth/account_name.dart';
import 'package:fusion_wallet/ui/pages/auth/biometrics.dart';
import 'package:fusion_wallet/ui/pages/auth/intro.dart';
import 'package:fusion_wallet/ui/pages/auth/passphrase/passphrase.dart';
import 'package:fusion_wallet/ui/pages/auth/pincode.dart';
import 'package:fusion_wallet/ui/pages/auth/recover_account_page.dart';

import 'bloc.dart';
import 'state.dart';

class AuthUi extends StatelessWidget {
  AuthUi({
    Key key,
  }) : super(key: key);
  static const navId = "/auth/v2";
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => AuthenticationBloc(),
        child: BlocBuilder<AuthenticationBloc, AccountCreationState>(
          builder: (context, state) {
            if (state is AccountInitialState) {
              return IntroPage();
            }
            if (state is CreatePincodeState) {
              return PasswordCreationPage();
            }
            if (state is BiometricsConfigureState) {
              return BiometricAuthPage();
            }
            if (state is AccountRecoveryState) {
              return RecoverAccountPage();
            }
            if (state is PassphraseCreationState) {
              return PassphraseCreationPage();
            }
            if (state is AccountNamingState) {
              return AccountCreationNamePage();
            }
            if (state is AccountLockedState) {
              return Splash();
            }
            if (state is AccountUnlockedState) {
              return HomePage();
            }
          },
        ));
  }
}
