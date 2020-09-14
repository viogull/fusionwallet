class BIP {
  double buy;
  double sell;

  BIP({
      this.buy, 
      this.sell});

  BIP.fromJson(dynamic json) {
    buy = json["buy"];
    sell = json["sell"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["buy"] = buy;
    map["sell"] = sell;
    return map;
  }

}