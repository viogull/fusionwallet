import 'coin.dart';

class Minter {
  Coin coin;
  String amount;
  String bipAmount;
  String usdAmount;

  Minter({
      this.coin, 
      this.amount, 
      this.bipAmount, 
      this.usdAmount});

  Minter.fromJson(dynamic json) {
    coin = json["coin"] != null ? Coin.fromJson(json["coin"]) : null;
    amount = json["amount"];
    bipAmount = json["bip_amount"];
    usdAmount = json["usd_amount"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (coin != null) {
      map["coin"] = coin.toJson();
    }
    map["amount"] = amount;
    map["bip_amount"] = bipAmount;
    map["usd_amount"] = usdAmount;
    return map;
  }

}