class EthBalanceResponse {
  num  value;

  EthBalanceResponse({
      this.value});

  EthBalanceResponse.fromJson(dynamic json) {
    value = json["value"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["value"] = value;
    return map;
  }

}