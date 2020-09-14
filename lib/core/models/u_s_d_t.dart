class USDT {
  double buy;
  double sell;

  USDT({
      this.buy, 
      this.sell});

  USDT.fromJson(dynamic json) {
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