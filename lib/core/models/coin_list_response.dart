/// crr : 100
/// volume : "0.000000000000000000"
/// reserveBalance : "0.000000000000000000"
/// max_supply : "0.000000000000000000"
/// name : "BIP"
/// symbol : "BIP"

class MinterCoin {
  int crr;
  String volume;
  String reserveBalance;
  String maxSupply;
  String name;
  String symbol;

  MinterCoin(
      {this.crr,
      this.volume,
      this.reserveBalance,
      this.maxSupply,
      this.name,
      this.symbol});

  MinterCoin.fromJson(dynamic json) {
    crr = json["crr"];
    volume = json["volume"];
    reserveBalance = json["reserveBalance"];
    maxSupply = json["maxSupply"];
    name = json["name"];
    symbol = json["symbol"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["crr"] = crr;
    map["volume"] = volume;
    map["reserveBalance"] = reserveBalance;
    map["maxSupply"] = maxSupply;
    map["name"] = name;
    map["symbol"] = symbol;
    return map;
  }
}
