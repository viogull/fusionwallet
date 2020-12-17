class FUSION {
  num buy;
  num sell;

  FUSION({
      this.buy, 
      this.sell});

  FUSION.fromJson(dynamic json) {
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