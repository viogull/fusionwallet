import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';

import '../inject.dart';

class MinterChannel {
  final log = injector.get<Logger>();

  MinterChannel();

  static const platformChannel =
  const MethodChannel('com.fusiongroup.fusion.wallet/natives');

  List<String> getMnemonicsWords(String mnemonic) {
    return mnemonic.split(" ");
  }

  Future<dynamic> generateAddressData() async {
    try {
      return await platformChannel
          .invokeMethod<Map<dynamic, dynamic>>('create_address');
    } on Exception catch (e) {
      log.e(" Exception on generating new address. Details: "
          "\n ${e} \n");
    }
    return null;
  }

  Future<String> buyTransanction(String mnemonic, num nonce, num max,
      String gasCoin, String coinTo, String coinFrom, num value) async {
    return null;
  }

  Future<dynamic> transactions(String address) async {
    try {
      var datas = await platformChannel.invokeMethod<dynamic>(
          'transactions', 'Mx$address') as LinkedHashMap<dynamic, dynamic>;
      return datas;
    } on PlatformException catch (e) {
      log.e("Platform Exception on generating new address. Details: "
          "\n ${e.message} \n ${e.details}");
    }
    return null;
  }

  // TODO Complete Android Implementatiop
  Future<AccountBalance> balances(String address) async {
    // var txs = await transactions("a392c9d3fd055f6f2ef8436a13efc1e4cd856d6f");
    log.d("Fetching balances for address $address");
    try {
      var datas = await platformChannel.invokeMethod<dynamic>(
          'balances', 'Mx$address') as LinkedHashMap<dynamic, dynamic>;

      var txQty = datas['transaction_count'] as String;
      List<AddressBalanceItem> balancesList = List();

      var balances = datas["balance"] as LinkedHashMap<dynamic, dynamic>;
      balances.forEach((key, value) {
        log.d("Balance $key -> $value");
        balancesList.add(AddressBalanceItem(symbol: key, amount: value));
      });

      return AccountBalance(transanctionsQty: txQty, balances: balancesList);
    } on PlatformException catch (e) {
      log.e("Platform Exception on fetching balancess. Details: "
          "\n ${e.message} \n ${e.details}");
    }
    return null;
  }
}

class AccountBalance {
  final String transanctionsQty;
  final List<AddressBalanceItem> balances;

  AccountBalance({this.transanctionsQty, this.balances});
}

class AddressBalanceItem {
  final String symbol;
  final String amount;

  const AddressBalanceItem({@required this.symbol, @required this.amount});
}