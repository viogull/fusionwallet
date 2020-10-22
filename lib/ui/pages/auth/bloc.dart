import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fusion_wallet/core/abstract/erc20_wallet.dart';
import 'package:fusion_wallet/core/abstract/preferences.dart';
import 'package:fusion_wallet/core/minter_rest.dart';
import 'package:fusion_wallet/core/models.dart';
import 'package:fusion_wallet/core/models/create_profile_request.dart';
import 'package:fusion_wallet/inject.dart';
import 'package:fusion_wallet/main.dart';
import 'package:fusion_wallet/utils/biometric.dart';
import 'package:hive/hive.dart';
import 'package:logger/logger.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import 'event.dart';
import 'state.dart';

class AuthenticationBloc
    extends Bloc<AccountCreationEvent, AccountCreationState> {
  AuthenticationBloc() : super(null) {
    preferences = _box.getAt(0);
  }

  Logger log = injector.get<Logger>();
  MinterRest api = MinterRest();

  Preferences preferences;
  Account _account = Account();
  Erc20Wallet _erc20wallet = Erc20Wallet();

  Box<Preferences> _box = Hive.box(preferencesBox);

  bool _isRecoveringAccount = false;

  AccountCreationState get initialState => AccountInitialState();

  @override
  Stream<AccountCreationState> mapEventToState(
    AccountCreationEvent event,
  ) async* {
    debugPrint("New event incoming -> $event");

    if (event is AccountLockEvent) {
      yield AccountLockedState();
    }
    if (event is AccountInitialEvent) {
      yield AccountInitialState();
    }
    if (event is AccountStartRecoverEvent) {
      yield AccountRecoveryState();
    } else if (event is AccountCompleteRecoverEvent) {
      log.d("Completing account recovery for ${event.profile.name}, id"
          " ${event.profile.id}. Minter  -> ${event.profile.address}, ERC20 -> ${event.profile.erc20.address}");
      _isRecoveringAccount = true;
      _account.mnemonic = event.profile.mnemonic;
      _account.name = event.profile.name;
      preferences.name = event.profile.name;
      _account.seed = event.profile.id;
      _account.hash = event.profile.hash;
      _account.address = event.profile.address;

      _erc20wallet.address = event.profile.erc20.address;
      _erc20wallet.privateKey = event.profile.erc20.privateKey;
      _erc20wallet.name = event.profile.name;

      yield CreatePincodeState();
    } else if (event is AccountCreateWalletEvent) {
      yield CreatePincodeState();
    } else if (event is PincodeCreatedEvent) {
      _account.pin = event.pin;

      if (this._isRecoveringAccount) {
        log.d("Recovering account is succesfully finished. Saved "
            "${_account.name} with pin ${_account.pin}");

        log.d("Fetching profile data for recovering...");

        if (_account.isInBox) {
          _account.save();
          _erc20wallet.save();
        } else {
          log.d("Account not saved. Persisting...");
          Hive.box<Account>(accountsBox).add(_account);
          Hive.box<Erc20Wallet>(erc20walletsBox).add(_erc20wallet);

        }
        yield AccountUnlockedState();
      } else {
        final isBiometricAvailable =
            await injector.get<BiometricUtil>().hasBiometrics();

        log.d(
            "Checking biometrics for availability, is available? -> $isBiometricAvailable");
        if (isBiometricAvailable)
          yield BiometricsConfigureState();
        else {
          preferences.biometricEnabled = false;
          yield PassphraseCreationState();
        }
      }
    } else if (event is BiometricConfiguredEvent) {
      preferences.biometricEnabled = event.enableBiometrics;
      preferences.save();

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
      final referal = await injector.get<Vault>().getLastReferalInviter();

      final createProfile = await api.createProfile(CreateProfileRequest(
          playerId: playerId,
          name: event.name,
          mnemonic: _account.mnemonic,
          pin: _account.pin,
          promoteUrl: referal));
      log.d(createProfile.toString());
      _account.name = event.name;
      _account.hash = createProfile.hash;
      _account.sessionKey = createProfile.id;
      _account.address = createProfile.address;

      preferences.name = event.name;


      _erc20wallet.address = createProfile.erc20.address;
      _erc20wallet.privateKey = createProfile.erc20.privateKey;
      _erc20wallet.name = event.name;

      if (createProfile != null) {

        if (_erc20wallet.isInBox) {
          _erc20wallet.save();
        } else {
          Box<Erc20Wallet> wallets = Hive.box(erc20walletsBox);
          wallets.add(_erc20wallet);
          _erc20wallet.save();
        }

        if (_account.isInBox) {
          _account.save();
          preferences.save();
        } else {
          Box<Account> accs = Hive.box(accountsBox);
          accs.add(_account);
          _account.save();
          preferences.save();
        }
        yield AccountUnlockedState();
      }
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
