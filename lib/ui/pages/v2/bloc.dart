import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fusion_wallet/core/abstract/preferences.dart';
import 'package:fusion_wallet/core/models.dart';
import 'package:fusion_wallet/main.dart';
import 'package:hive/hive.dart';

import 'event.dart';
import 'state.dart';

class AuthenticationBloc
    extends Bloc<AccountCreationEvent, AccountCreationState> {
  AuthenticationBloc() : super(null) {
    preferences = _box.getAt(0);
  }

  Preferences preferences;
  Account _account = Account();
  Box<Preferences> _box = Hive.box(preferencesBox);

  AccountCreationState get initialState => AccountInitialState();

  @override
  Stream<AccountCreationState> mapEventToState(
    AccountCreationEvent event,
  ) async* {
    debugPrint("New event incoming -> $event");

    if (event is AccountLockEvent) {
      yield AccountLockedState();
    }
    if (event is AccountStartRecoverEvent) {
      yield AccountRecoveryState();
    } else if (event is AccountCreateWalletEvent) {
      yield CreatePincodeState();
    } else if (event is PincodeCreatedEvent) {
      _account.pin = event.pin;
      yield BiometricsConfigureState();
    } else if (event is BiometricConfiguredEvent) {
      preferences.biometricEnabled = event.enableBiometrics;

      yield PassphraseCreationState();
    } else if (event is PassphraseVerifiedEvent) {
      _account.address = event.address;
      _account.seed = event.seed;
      _account.publicKey = event.publicKey;
      _account.privateKey = event.privateKey;
      _account.mnemonic = event.mnemonic;

      yield AccountNamingState();
    } else if (event is AccountNameCreatedEvent) {
      _account.name = event.name;
      preferences.name = event.name;
      if (_account.isInBox) {
        _account.save();
        preferences.save();
      } else {
        Box<Account> accs = Hive.box(accountsBox);
        accs.add(_account);
      }

      yield AccountUnlockedState();
    } else if (event is AccountUnlockEvent) {
      yield AccountUnlockedState();
    } else if (event is AccountLockEvent) {
      yield AccountLockedState();
    }
//    } else if (event is AuthenticationLoggedIn) {
//      yield* _mapAuthenticationLoggedInToState();
//    } else if (event is AuthenticationLoggedOut) {
//      yield* _mapAuthenticationLoggedOutToState();
//    }
  }
}
