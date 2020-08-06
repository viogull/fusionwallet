import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fusion_wallet/core/abstract/preferences.dart';
import 'package:fusion_wallet/core/minter_rest.dart';
import 'package:fusion_wallet/core/models.dart';
import 'package:fusion_wallet/core/models/create_profile_request.dart';
import 'package:fusion_wallet/main.dart';
import 'package:hive/hive.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import 'event.dart';
import 'state.dart';

class AuthenticationBloc
    extends Bloc<AccountCreationEvent, AccountCreationState> {
  AuthenticationBloc() : super(null) {
    preferences = _box.getAt(0);
  }

  MinterRest api = MinterRest();

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
      final status = await OneSignal.shared.getPermissionSubscriptionState();
      final playerId = status.subscriptionStatus.userId;

      final createProfile = await api.createProfile(CreateProfileRequest(
          playerId: playerId,
          name: event.name,
          mnemonic: _account.mnemonic,
          pin: _account.pin,
          promoteUrl: "null"));
      debugPrint(createProfile.toJson().toString());
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
