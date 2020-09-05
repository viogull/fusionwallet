/// coinToSell : "BIP"
/// coinToBuy : "FUSION"
/// valueToSell : "0.11"
/// mnemonic : "protect..."

class ConvertRequest {
  String coinToSell;
  String coinToBuy;
  String valueToSell;
  String mnemonic;

  ConvertRequest(
      {this.coinToSell, this.coinToBuy, this.valueToSell, this.mnemonic});

  ConvertRequest.fromJson(dynamic json) {
    coinToSell = json["coinToSell"];
    coinToBuy = json["coinToBuy"];
    valueToSell = json["valueToSell"];
    mnemonic = json["mnemonic"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["coinToSell"] = coinToSell;
    map["coinToBuy"] = coinToBuy;
    map["valueToSell"] = valueToSell;
    map["mnemonic"] = mnemonic;
    return map;
  }
}
