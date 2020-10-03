class Estimation {
  int t;
  double value;

  Estimation({
      this.t, 
      this.value});

  Estimation.fromJson(dynamic json) {
    t = json["t"];
    value = json["value"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["t"] = t;
    map["value"] = value;
    return map;
  }

}