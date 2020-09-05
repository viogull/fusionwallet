import 'balances.dart';

/// address : "Mx9dafdb2de4f6d4db4a1a4408aae31fb315acc7d9"
/// balances : [{"coin":"BIP","amount":"0.379000000000000000"}]
/// total_balance_sum : "0.379000000000000000"
/// total_balance_sum_usd : "0.001837213870000000"
/// available_balance_sum : "0.379000000000000000"
/// available_balance_sum_usd : "0.001837213870000000"

class Data {
  String address;
  List<Balances> balances;
  String totalBalanceSum;
  String totalBalanceSumUsd;
  String availableBalanceSum;
  String availableBalanceSumUsd;

  Data(
      {this.address,
      this.balances,
      this.totalBalanceSum,
      this.totalBalanceSumUsd,
      this.availableBalanceSum,
      this.availableBalanceSumUsd});

  Data.fromJson(dynamic json) {
    address = json["address"];
    if (json["balances"] != null) {
      balances = [];
      json["balances"].forEach((v) {
        balances.add(Balances.fromJson(v));
      });
    }
    totalBalanceSum = json["totalBalanceSum"];
    totalBalanceSumUsd = json["totalBalanceSumUsd"];
    availableBalanceSum = json["availableBalanceSum"];
    availableBalanceSumUsd = json["availableBalanceSumUsd"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["address"] = address;
    if (balances != null) {
      map["balances"] = balances.map((v) => v.toJson()).toList();
    }
    map["totalBalanceSum"] = totalBalanceSum;
    map["totalBalanceSumUsd"] = totalBalanceSumUsd;
    map["availableBalanceSum"] = availableBalanceSum;
    map["availableBalanceSumUsd"] = availableBalanceSumUsd;
    return map;
  }
}
