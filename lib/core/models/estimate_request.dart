/// coinToSell : "BIP"
/// coinToBuy : "FUSION"
/// valueToSell : "10"

class EstimateRequest {
  String coinToSell;
  String coinToBuy;
  String valueToSell;

  EstimateRequest({this.coinToSell, this.coinToBuy, this.valueToSell});

  EstimateRequest.fromJson(dynamic json) {
    coinToSell = json["coinToSell"];
    coinToBuy = json["coinToBuy"];
    valueToSell = json["valueToSell"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["coinToSell"] = coinToSell;
    map["coinToBuy"] = coinToBuy;
    map["valueToSell"] = valueToSell;
    return map;
  }
}
