/// coin : "MNT"
/// value : "1"
/// payload : "Test"

class CreatePushLinkRequest {
  String coin;
  String value;
  String payload;

  CreatePushLinkRequest({this.coin, this.value, this.payload});

  CreatePushLinkRequest.fromJson(dynamic json) {
    coin = json["coin"];
    value = json["value"];
    payload = json["payload"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["coin"] = coin;
    map["value"] = value;
    map["payload"] = payload;
    return map;
  }
}
