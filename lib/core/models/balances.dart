/// coin : "BIP"
/// amount : "0.379000000000000000"

class Balances {
  String coin;
  String amount;

  Balances({this.coin, this.amount});

  Balances.fromJson(dynamic json) {
    coin = json["coin"];
    amount = json["amount"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["coin"] = coin;
    map["amount"] = amount;
    return map;
  }
}
