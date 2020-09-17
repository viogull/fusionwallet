class Receivers {
  String to;
  String value;

  Receivers({
      this.to, 
      this.value});

  Receivers.fromJson(dynamic json) {
    to = json["to"];
    value = json["value"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["to"] = to;
    map["value"] = value;
    return map;
  }

}