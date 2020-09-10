// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'convert_form_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ConvertFormStore on _ConvertFormStore, Store {
  Computed<bool> _$isEstimationAllowedComputed;

  @override
  bool get isEstimationAllowed => (_$isEstimationAllowedComputed ??=
          Computed<bool>(() => super.isEstimationAllowed,
              name: '_ConvertFormStore.isEstimationAllowed'))
      .value;

  final _$coinToSellAtom = Atom(name: '_ConvertFormStore.coinToSell');

  @override
  String get coinToSell {
    _$coinToSellAtom.reportRead();
    return super.coinToSell;
  }

  @override
  set coinToSell(String value) {
    _$coinToSellAtom.reportWrite(value, super.coinToSell, () {
      super.coinToSell = value;
    });
  }

  final _$coinToBuyAtom = Atom(name: '_ConvertFormStore.coinToBuy');

  @override
  String get coinToBuy {
    _$coinToBuyAtom.reportRead();
    return super.coinToBuy;
  }

  @override
  set coinToBuy(String value) {
    _$coinToBuyAtom.reportWrite(value, super.coinToBuy, () {
      super.coinToBuy = value;
    });
  }

  final _$valueToSellAtom = Atom(name: '_ConvertFormStore.valueToSell');

  @override
  String get valueToSell {
    _$valueToSellAtom.reportRead();
    return super.valueToSell;
  }

  @override
  set valueToSell(String value) {
    _$valueToSellAtom.reportWrite(value, super.valueToSell, () {
      super.valueToSell = value;
    });
  }

  final _$feeAtom = Atom(name: '_ConvertFormStore.fee');

  @override
  String get fee {
    _$feeAtom.reportRead();
    return super.fee;
  }

  @override
  set fee(String value) {
    _$feeAtom.reportWrite(value, super.fee, () {
      super.fee = value;
    });
  }

  final _$willGetAtom = Atom(name: '_ConvertFormStore.willGet');

  @override
  String get willGet {
    _$willGetAtom.reportRead();
    return super.willGet;
  }

  @override
  set willGet(String value) {
    _$willGetAtom.reportWrite(value, super.willGet, () {
      super.willGet = value;
    });
  }

  final _$balancesAtom = Atom(name: '_ConvertFormStore.balances');

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

  final _$coinsAtom = Atom(name: '_ConvertFormStore.coins');

  @override
  ObservableFuture<List<String>> get coins {
    _$coinsAtom.reportRead();
    return super.coins;
  }

  @override
  set coins(ObservableFuture<List<String>> value) {
    _$coinsAtom.reportWrite(value, super.coins, () {
      super.coins = value;
    });
  }

  final _$messagesStreamAtom = Atom(name: '_ConvertFormStore.messagesStream');

  @override
  Observable<InformationMessage> get messagesStream {
    _$messagesStreamAtom.reportRead();
    return super.messagesStream;
  }

  @override
  set messagesStream(Observable<InformationMessage> value) {
    _$messagesStreamAtom.reportWrite(value, super.messagesStream, () {
      super.messagesStream = value;
    });
  }

  final _$validateEstimationAsyncAction =
      AsyncAction('_ConvertFormStore.validateEstimation');

  @override
  Future<dynamic> validateEstimation(String update) {
    return _$validateEstimationAsyncAction
        .run(() => super.validateEstimation(update));
  }

  final _$exchangeAsyncAction = AsyncAction('_ConvertFormStore.exchange');

  @override
  Future<dynamic> exchange(String memo) {
    return _$exchangeAsyncAction.run(() => super.exchange(memo));
  }

  final _$estimateAsyncAction = AsyncAction('_ConvertFormStore.estimate');

  @override
  Future<dynamic> estimate() {
    return _$estimateAsyncAction.run(() => super.estimate());
  }

  final _$_ConvertFormStoreActionController =
      ActionController(name: '_ConvertFormStore');

  @override
  Future<dynamic> fetchBalances(String address) {
    final _$actionInfo = _$_ConvertFormStoreActionController.startAction(
        name: '_ConvertFormStore.fetchBalances');
    try {
      return super.fetchBalances(address);
    } finally {
      _$_ConvertFormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  Future<dynamic> fetchCoins() {
    final _$actionInfo = _$_ConvertFormStoreActionController.startAction(
        name: '_ConvertFormStore.fetchCoins');
    try {
      return super.fetchCoins();
    } finally {
      _$_ConvertFormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void selectCoinToSell(String coin) {
    final _$actionInfo = _$_ConvertFormStoreActionController.startAction(
        name: '_ConvertFormStore.selectCoinToSell');
    try {
      return super.selectCoinToSell(coin);
    } finally {
      _$_ConvertFormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void selectCoinToBuy(String coin) {
    final _$actionInfo = _$_ConvertFormStoreActionController.startAction(
        name: '_ConvertFormStore.selectCoinToBuy');
    try {
      return super.selectCoinToBuy(coin);
    } finally {
      _$_ConvertFormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void selectValueToSell(String value) {
    final _$actionInfo = _$_ConvertFormStoreActionController.startAction(
        name: '_ConvertFormStore.selectValueToSell');
    try {
      return super.selectValueToSell(value);
    } finally {
      _$_ConvertFormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void calculateFees(String fee, String willGet) {
    final _$actionInfo = _$_ConvertFormStoreActionController.startAction(
        name: '_ConvertFormStore.calculateFees');
    try {
      return super.calculateFees(fee, willGet);
    } finally {
      _$_ConvertFormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void calcMaxValue(String coin) {
    final _$actionInfo = _$_ConvertFormStoreActionController.startAction(
        name: '_ConvertFormStore.calcMaxValue');
    try {
      return super.calcMaxValue(coin);
    } finally {
      _$_ConvertFormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
coinToSell: ${coinToSell},
coinToBuy: ${coinToBuy},
valueToSell: ${valueToSell},
fee: ${fee},
willGet: ${willGet},
balances: ${balances},
coins: ${coins},
messagesStream: ${messagesStream},
isEstimationAllowed: ${isEstimationAllowed}
    ''';
  }
}
