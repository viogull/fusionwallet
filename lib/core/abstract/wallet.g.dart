// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$Wallet on _Wallet, Store {
  final _$accountAtom = Atom(name: '_Wallet.account');

  @override
  Account get account {
    _$accountAtom.reportRead();
    return super.account;
  }

  @override
  set account(Account value) {
    _$accountAtom.reportWrite(value, super.account, () {
      super.account = value;
    });
  }

  final _$_WalletActionController = ActionController(name: '_Wallet');

  @override
  void loadAccount({@required Account account}) {
    final _$actionInfo =
        _$_WalletActionController.startAction(name: '_Wallet.loadAccount');
    try {
      return super.loadAccount(account: account);
    } finally {
      _$_WalletActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
account: ${account}
    ''';
  }
}
