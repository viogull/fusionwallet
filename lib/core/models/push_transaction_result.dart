
/// data : {"hash":"Mtd007083ed828a3c59040a66ae821d3cb3db9da2274f4d5a0f6d94db785229acf"}
class PushTransactionResult {
  Data data;

  PushTransactionResult({this.data});

  PushTransactionResult.fromJson(dynamic json) {
    data = json["data"] != null ? Data.fromJson(json["data"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (data != null) {
      map["data"] = data.toJson();
    }
    return map;
  }
}

/// hash : "Mtd007083ed828a3c59040a66ae821d3cb3db9da2274f4d5a0f6d94db785229acf"
class Data {
  String hash;

  Data({this.hash});

  Data.fromJson(dynamic json) {
    hash = json["hash"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["hash"] = hash;
    return map;
  }
}