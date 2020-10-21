class Coin {
  int id;
  String symbol;

  Coin({
      this.id, 
      this.symbol});

  Coin.fromJson(dynamic json) {
    id = json["id"];
    symbol = json["symbol"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["symbol"] = symbol;
    return map;
  }

}