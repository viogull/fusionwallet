


import 'package:flutter/material.dart';
import 'package:fusion_wallet/core/models.dart';
import 'package:fusion_wallet/core/models/convert_request.dart';
import 'package:fusion_wallet/core/models/minter_coins_response.dart';
import 'package:fusion_wallet/utils/numbers.dart';
import 'package:mobx/mobx.dart';

import '../../inject.dart';
part 'convert_form_store.g.dart';

class ConvertFormStore = _ConvertFormStore with _$ConvertFormStore;



class InformationMessage {
  bool isError;
  String message;

  InformationMessage({this.isError, this.message});

}

abstract class _ConvertFormStore with Store {


  final api = injector.get<MinterRest>();
  final log = injector.get<Logger>();


  @observable
  String coinToSell;

  @observable
  String coinToBuy;

  @observable
  String valueToSell = '0.0';

  @observable
  String fee = '';


  @observable
  String willGet = '';


  @observable
  ObservableFuture<AddressData> balances;

  @observable
  ObservableFuture<List<String>> coins;


  @observable
  Observable<InformationMessage> messagesStream;

  @computed
  bool get isSellCoinSelected => coinToSell.isNotEmpty;


  @computed
  bool get isBuyCoinSelected => coinToBuy.isNotEmpty;


  @computed
  bool get isSellValueEntered => valueToSell.isNotEmpty;


  @computed
  bool get isEstimationAllowed => isSellCoinSelected && isBuyCoinSelected && isSellValueEntered;


  List<ReactionDisposer> _disposers;

  void setupEstimationCalculators() {
    _disposers = [
      reaction((_) => valueToSell, validateEstimation),
    ];
  }

  @action
  Future validateEstimation(String update) async  {
    log.d("Convert  Form Update -> $update. Allow? -> $isEstimationAllowed ");
    if(isEstimationAllowed) {
      log.d("Entered values => $valueToSell $coinToSell ----> $coinToBuy");
      estimate();
    }
  }

  void dispose() {
    for (final d in _disposers) {
      d();
    }
  }


  @action
  Future fetchBalances(String address) => balances = ObservableFuture(api.fetchAddressData(address: address))
      .then((AddressData balances) => balances = balances);

  @action
  Future fetchCoins() => coins = ObservableFuture(api.fetchMinterCoins()).then((MinterCoinsResponse value) => value.coins);



  void fetchInitials({String address}) {
    fetchBalances(address);
    fetchCoins();
  }
  @action
  void selectCoinToSell(String coin) {

    coinToSell = coin;
  }

  @action
  void selectCoinToBuy(String coin) {
    debugPrint("Selected $coin for buy");
    coinToBuy = coin;
  }

  @action
  void selectValueToSell(String value) {

    debugPrint("Selected $value to  sell");

    this.valueToSell = value;
  }

  @action
  void calculateFees(String fee, String willGet) {


    this.willGet = NumberUtil.sanitizeNumber(willGet, maxDecimalDigits: 12);

    this.fee = NumberUtil.sanitizeNumber(fee, maxDecimalDigits: 7);

  }


  @action
  void exchange(String memo) async {
    if(isEstimationAllowed) {
      log.d("Converting ...");
      final succes = await api.convert(requestData: ConvertRequest(coinToBuy: coinToBuy, coinToSell: coinToSell, valueToSell: valueToSell, mnemonic: memo));
      if(succes) {
        messagesStream.value = InformationMessage(isError: false, message:  "Succesfully converted");
      } else {
        messagesStream.value = InformationMessage(isError: true, message:  "Failed on exchange. Please, try later.");

      }
      return;
    }
  }


  @action
  Future estimate() async {
    log.d("Estimating ...");
    final estimation = await api.estimate( new EstimateRequest(coinToSell: coinToSell, coinToBuy: coinToBuy, valueToSell: valueToSell));
    if(estimation != null) {
      calculateFees(estimation.commission, estimation.willGet);
    }
    return estimation;
  }

  @action
  void calcMaxValue(String coin) {
    log.d("Max Value for $coin -> ");

  }
}