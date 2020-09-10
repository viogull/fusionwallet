// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'erc20_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$Erc20Store on _Erc20Store, Store {
  final _$isWalletPersistedAtom = Atom(name: '_Erc20Store.isWalletPersisted');

  @override
  bool get isWalletPersisted {
    _$isWalletPersistedAtom.reportRead();
    return super.isWalletPersisted;
  }

  @override
  set isWalletPersisted(bool value) {
    _$isWalletPersistedAtom.reportWrite(value, super.isWalletPersisted, () {
      super.isWalletPersisted = value;
    });
  }

  final _$addressAtom = Atom(name: '_Erc20Store.address');

  @override
  String get address {
    _$addressAtom.reportRead();
    return super.address;
  }

  @override
  set address(String value) {
    _$addressAtom.reportWrite(value, super.address, () {
      super.address = value;
    });
  }

  final _$privateKeyAtom = Atom(name: '_Erc20Store.privateKey');

  @override
  String get privateKey {
    _$privateKeyAtom.reportRead();
    return super.privateKey;
  }

  @override
  set privateKey(String value) {
    _$privateKeyAtom.reportWrite(value, super.privateKey, () {
      super.privateKey = value;
    });
  }

  final _$loadErc20WalletsAsyncAction =
      AsyncAction('_Erc20Store.loadErc20Wallets');

  @override
  Future<dynamic> loadErc20Wallets() {
    return _$loadErc20WalletsAsyncAction.run(() => super.loadErc20Wallets());
  }

  final _$createErc20WalletAsyncAction =
      AsyncAction('_Erc20Store.createErc20Wallet');

  @override
  Future<dynamic> createErc20Wallet({String name, String password}) {
    return _$createErc20WalletAsyncAction
        .run(() => super.createErc20Wallet(name: name, password: password));
  }

  @override
  String toString() {
    return '''
isWalletPersisted: ${isWalletPersisted},
address: ${address},
privateKey: ${privateKey}
    ''';
  }
}
