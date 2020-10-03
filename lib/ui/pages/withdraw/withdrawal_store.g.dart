// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'withdrawal_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$WithdrawalStore on _WithdrawalStore, Store {
  final _$networkAtom = Atom(name: '_WithdrawalStore.network');

  @override
  String get network {
    _$networkAtom.reportRead();
    return super.network;
  }

  @override
  set network(String value) {
    _$networkAtom.reportWrite(value, super.network, () {
      super.network = value;
    });
  }

  final _$coinAtom = Atom(name: '_WithdrawalStore.coin');

  @override
  String get coin {
    _$coinAtom.reportRead();
    return super.coin;
  }

  @override
  set coin(String value) {
    _$coinAtom.reportWrite(value, super.coin, () {
      super.coin = value;
    });
  }

  final _$fiatAtom = Atom(name: '_WithdrawalStore.fiat');

  @override
  String get fiat {
    _$fiatAtom.reportRead();
    return super.fiat;
  }

  @override
  set fiat(String value) {
    _$fiatAtom.reportWrite(value, super.fiat, () {
      super.fiat = value;
    });
  }

  final _$cardAtom = Atom(name: '_WithdrawalStore.card');

  @override
  String get card {
    _$cardAtom.reportRead();
    return super.card;
  }

  @override
  set card(String value) {
    _$cardAtom.reportWrite(value, super.card, () {
      super.card = value;
    });
  }

  final _$qtyAtom = Atom(name: '_WithdrawalStore.qty');

  @override
  String get qty {
    _$qtyAtom.reportRead();
    return super.qty;
  }

  @override
  set qty(String value) {
    _$qtyAtom.reportWrite(value, super.qty, () {
      super.qty = value;
    });
  }

  final _$estimationAtom = Atom(name: '_WithdrawalStore.estimation');

  @override
  String get estimation {
    _$estimationAtom.reportRead();
    return super.estimation;
  }

  @override
  set estimation(String value) {
    _$estimationAtom.reportWrite(value, super.estimation, () {
      super.estimation = value;
    });
  }

  final _$maximumAtom = Atom(name: '_WithdrawalStore.maximum');

  @override
  double get maximum {
    _$maximumAtom.reportRead();
    return super.maximum;
  }

  @override
  set maximum(double value) {
    _$maximumAtom.reportWrite(value, super.maximum, () {
      super.maximum = value;
    });
  }

  final _$balancesAtom = Atom(name: '_WithdrawalStore.balances');

  @override
  ObservableFuture<AddressData> get balances {
    _$balancesAtom.reportRead();
    return super.balances;
  }

  @override
  set balances(ObservableFuture<AddressData> value) {
    _$balancesAtom.reportWrite(value, super.balances, () {
      super.balances = value;
    });
  }

  final _$estimateAsyncAction = AsyncAction('_WithdrawalStore.estimate');

  @override
  Future<dynamic> estimate() {
    return _$estimateAsyncAction.run(() => super.estimate());
  }

  final _$validateEstimationAsyncAction =
      AsyncAction('_WithdrawalStore.validateEstimation');

  @override
  Future<dynamic> validateEstimation(String update) {
    return _$validateEstimationAsyncAction
        .run(() => super.validateEstimation(update));
  }

  final _$postAsyncAction = AsyncAction('_WithdrawalStore.post');

  @override
  Future<dynamic> post() {
    return _$postAsyncAction.run(() => super.post());
  }

  final _$_WithdrawalStoreActionController =
      ActionController(name: '_WithdrawalStore');

  @override
  void selectFiatCurrency(String value) {
    final _$actionInfo = _$_WithdrawalStoreActionController.startAction(
        name: '_WithdrawalStore.selectFiatCurrency');
    try {
      return super.selectFiatCurrency(value);
    } finally {
      _$_WithdrawalStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void inputQty(String value) {
    final _$actionInfo = _$_WithdrawalStoreActionController.startAction(
        name: '_WithdrawalStore.inputQty');
    try {
      return super.inputQty(value);
    } finally {
      _$_WithdrawalStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void selectNetwork(String value) {
    final _$actionInfo = _$_WithdrawalStoreActionController.startAction(
        name: '_WithdrawalStore.selectNetwork');
    try {
      return super.selectNetwork(value);
    } finally {
      _$_WithdrawalStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void enterCoin(String value) {
    final _$actionInfo = _$_WithdrawalStoreActionController.startAction(
        name: '_WithdrawalStore.enterCoin');
    try {
      return super.enterCoin(value);
    } finally {
      _$_WithdrawalStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void enterCard(String value) {
    final _$actionInfo = _$_WithdrawalStoreActionController.startAction(
        name: '_WithdrawalStore.enterCard');
    try {
      return super.enterCard(value);
    } finally {
      _$_WithdrawalStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  Future<dynamic> fetchBalances(String address) {
    final _$actionInfo = _$_WithdrawalStoreActionController.startAction(
        name: '_WithdrawalStore.fetchBalances');
    try {
      return super.fetchBalances(address);
    } finally {
      _$_WithdrawalStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
network: ${network},
coin: ${coin},
fiat: ${fiat},
card: ${card},
qty: ${qty},
estimation: ${estimation},
maximum: ${maximum},
balances: ${balances}
    ''';
  }
}
