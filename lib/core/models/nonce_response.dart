
/// data : {"nonce":"38881"}
class NonceResponse {
  Data data;

  NonceResponse({this.data});

  NonceResponse.fromJson(dynamic json) {
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

/// nonce : "38881"
class Data {
  String nonce;

  Data({this.nonce});

  Data.fromJson(dynamic json) {
    nonce = json["nonce"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["nonce"] = nonce;
    return map;
  }
}