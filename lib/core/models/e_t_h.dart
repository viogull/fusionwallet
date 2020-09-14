class ETH {
  double buy;
  double sell;

  ETH({
      this.buy, 
      this.sell});

  ETH.fromJson(dynamic json) {
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