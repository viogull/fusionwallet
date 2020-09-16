import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

import '../../../inject.dart';
import 'add_account_events.dart';
import 'add_account_states.dart';

class AddAccountBloc extends Bloc<AddAccountEvent, AddAccountState> {
  AddAccountBloc() : super(null);

  final log = Logger();

  AddAccountState get initialState => AddAccountInitialState();

  String _name;
  String _mnemonic;
  String _seed;
  String _address;
  String _pubKey;
  String _privKey;

  @override
  Stream<AddAccountState> mapEventToState(
    AddAccountEvent event,
  ) async* {
    debugPrint("New event incoming -> $event");

    if (event is AddAccountInitEvent) {
      yield AddAccountInitialState();
    } else if (event is AddAccountCreateNewEvent) {
      yield AddAccountMnemonicState();
    } else if (event is AddAccountFromRecoverEvent) {
      yield AddAccountRecoveryState();
    } else if (event is AddAccountSetNameEvent) {
      _mnemonic = event.mnemonic;
      _address = event.address;
      _seed = event.seed;
      _pubKey = event.publicKey;
      _privKey = event.privateKey;

      yield AddAccountNameState();
    } else if (event is AddAccountCreatedEvent) {
      yield AddAccountCreatedState();
    } else if (event is AddAccountFinishingEvent) {
      _name = event.name;
      log.d("Adding additional account $_name , ${event.props}");
      await injector.get<Vault>().addAccount(
          name: _name,
          mnemonic: _mnemonic,
          seed: _seed,
          address: _address,
          privKey: _privKey,
          publicKey: _pubKey);
      yield AddAccountFinishedState();
    } else {
      yield AddAccountInitialState();
    }
  }
}
