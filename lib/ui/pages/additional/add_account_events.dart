import 'package:equatable/equatable.dart';

class AddAccountEvent extends Equatable {
  const AddAccountEvent();

  @override
  List<Object> get props => [];
}

class AddAccountInitEvent extends AddAccountEvent {}

class AddAccountCreateNewEvent extends AddAccountEvent {}

class AddAccountCreatedEvent extends AddAccountEvent {}

class AddAccountFromRecoverEvent extends AddAccountEvent {}

class AddAccountFinishRecoverEvent extends AddAccountEvent {
  final String mnemonic;
  final String name;

  const AddAccountFinishRecoverEvent({this.mnemonic, this.name});
}

class AddAccountSetNameEvent extends AddAccountEvent {
  final String mnemonic;
  final String address;
  final String seed;
  final String publicKey;
  final String privateKey;

  const AddAccountSetNameEvent(
      {this.address,
      this.mnemonic,
      this.seed,
      this.publicKey,
      this.privateKey});

  @override
  List<Object> get props => [seed];

  @override
  String toString() => 'AddAccountSetNameEvent { $seed } ';
}

class AddAccountFinishingEvent extends AddAccountEvent {
  final String name;
  const AddAccountFinishingEvent({this.name});

  @override
  List<Object> get props => [name];

  @override
  String toString() => 'AddAccountFinishingEvent {  } ';
}

class AddAccountCloseEvent extends AddAccountEvent {}
