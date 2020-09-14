class BTC {
  double buy;
  double sell;

  BTC({
      this.buy, 
      this.sell});

  BTC.fromJson(dynamic json) {
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