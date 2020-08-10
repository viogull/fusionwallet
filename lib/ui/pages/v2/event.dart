import 'package:equatable/equatable.dart';
import 'package:fusion_wallet/core/models.dart';

import 'package:meta/meta.dart';

class AccountCreationEvent extends Equatable {
  const AccountCreationEvent();

  @override
  List<Object> get props => [];
}

class AccountCreateWalletEvent extends AccountCreationEvent {}

class PincodeCreatedEvent extends AccountCreationEvent {
  final String pin;
  const PincodeCreatedEvent({@required this.pin});

  @override
  List<Object> get props => [pin];

  @override
  String toString() => 'PincodeCreated { $pin } ';
}

class AccountStartRecoverEvent extends AccountCreationEvent {}

class PassphraseVerifiedEvent extends AccountCreationEvent {
  final String mnemonic;
  final String address;
  final String seed;
  final String publicKey;
  final String privateKey;

  const PassphraseVerifiedEvent(
      {@required this.mnemonic,
      @required this.address,
      @required this.seed,
      this.privateKey,
      this.publicKey});

  @override
  List<Object> get props => [mnemonic, address, seed];

  @override
  String toString() => 'PassphraseVerifiedEvent { $seed } ';
}

class AccountCompleteRecoverEvent extends AccountCreationEvent {
  final Account recoveryAccount;

  const AccountCompleteRecoverEvent({@required this.recoveryAccount});

  @override
  List<Object> get props => [recoveryAccount.toString()];

  @override
  String toString() => 'AccountCompleteRecoverEvent { $recoveryAccount } ';
}

class BiometricConfiguredEvent extends AccountCreationEvent {
  final bool enableBiometrics;
  const BiometricConfiguredEvent({@required this.enableBiometrics});

  @override
  List<Object> get props => [enableBiometrics];

  @override
  String toString() => 'BiometricSettingEvent { $enableBiometrics } ';
}

class AccountNamingEvent extends AccountCreationEvent {
  final String name;
  const AccountNamingEvent({@required this.name});

  @override
  List<Object> get props => [name];

  @override
  String toString() => 'AccountNamingEvent { $name } ';
}

class AccountNameCreatedEvent extends AccountCreationEvent {
  final String name;
  const AccountNameCreatedEvent({@required this.name});

  @override
  List<Object> get props => [name];

  @override
  String toString() => 'AccountNamingEvent { $name } ';
}

class AccountLockEvent extends AccountCreationEvent {
  final bool unlockWithBiometric;
  final String expectedPincode;

  const AccountLockEvent({this.unlockWithBiometric, this.expectedPincode});

  @override
  List<Object> get props => [unlockWithBiometric, expectedPincode];

  @override
  String toString() =>
      'LockAccountEvent { $unlockWithBiometric, expected code $expectedPincode } ';
}

class AccountUnlockEvent extends AccountCreationEvent {}

class AccountCreationFinishingEvent extends AccountCreationEvent {}
