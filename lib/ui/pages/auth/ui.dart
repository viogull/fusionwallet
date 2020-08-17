import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fusion_wallet/main.dart';
import 'package:fusion_wallet/ui/pages/auth/account_name.dart';
import 'package:fusion_wallet/ui/pages/auth/biometrics.dart';
import 'package:fusion_wallet/ui/pages/auth/intro.dart';
import 'package:fusion_wallet/ui/pages/auth/passphrase/passphrase.dart';
import 'package:fusion_wallet/ui/pages/auth/pincode.dart';
import 'package:fusion_wallet/ui/pages/auth/recover.dart';
import 'package:fusion_wallet/ui/pages/pages.dart';

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
            debugPrint("Current State -> $state");
            if (state is AccountInitialState) {
              return IntroPage();
            }
            if (state is CreatePincodeState) {
              return PasswordCreationPage(isCreating: true,);
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
              return AccountCreationNameForm();
            }
            if (state is AccountLockedState) {
              return LockUi();
            }
            if (state is AccountUnlockedState) {
              return HomePage();
            } else
              return IntroPage();
          },
        ));
  }
}
