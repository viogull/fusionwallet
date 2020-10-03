


import 'package:flutter/material.dart';
import 'package:fusion_wallet/core/models.dart';
import 'package:mobx/mobx.dart';

import '../../../inject.dart';

part 'withdrawal_store.g.dart';

class WithdrawalStore = _WithdrawalStore with _$WithdrawalStore;



abstract class _WithdrawalStore with Store {






  final api = injector.get<MinterRest>();
  final log = injector.get<Logger>();




  @observable
  String network = 'Minter';

  @observable
  String coin = '';


  @observable
  String fiat = 'USD';

  @observable
  String card = '';


  @observable
  String qty = '0.0';


  @observable
  String estimation = '';




  @observable
  double  maximum  = 0.0;




  @observable
  ObservableFuture<AddressData> balances ;




  @action
  void selectFiatCurrency(String value) {

    debugPrint("Selected fiat currency $value");

    this.fiat = value;

  }

  @action
  void inputQty(String value) {

    debugPrint("Selected qty  $value");

    this.qty = value;
  }


  @action
  void selectNetwork(String value) {

    debugPrint("Selected network $value");

    this.network = value;
  }


  @action
  void enterCoin(String value) {

    debugPrint("Selected coin $value");

    this.coin = value;

    this.maximum = double.parse(balances.value.data.balances.firstWhere((element) => element.coin == this.coin).amount);
  }


  @action
  void enterCard(String value) {

    debugPrint("Entered card  $value");

    this.card = value;
  }

  @action
  Future fetchBalances(String address) => balances = ObservableFuture(api.fetchAddressData(address: address))
      .then((AddressData balances) => balances = balances);


  void fetchInitials({String address}) {
    fetchBalances(address);
  }


  @action
  Future estimate() async {
    log.d("Estimating ...");
    final estimation = await api.estimateInvoice(from: coin, to: fiat, qty: double.parse(qty));
    this.estimation =  "~ ${estimation.value} ${estimation.currency}";
    return estimation;
  }


  List<ReactionDisposer> _disposers;

  void setupEstimationCalculators() {
    _disposers = [
      reaction((_) => qty, validateEstimation),
      reaction((_) => fiat, validateEstimation),
      reaction((_) => coin, validateEstimation),

    ];
  }


  @action
  Future validateEstimation(String update) async  {
    log.d("Convert  Form Update -> $update. Allow?  ");
      estimate();

  }

  void dispose() {
    for (final d in _disposers) {
      d();
    }
  }


  @action
  Future post() async {
    return null;
  }

}