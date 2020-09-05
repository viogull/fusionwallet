/// coin : "MNT"
/// value : "1"
/// payload : "Test"

class CreatePushLinkRequest {
  String coin;
  String value;
  String payload;
  String sendFrom;

  CreatePushLinkRequest({this.coin, this.value, this.payload, this.sendFrom});

  CreatePushLinkRequest.fromJson(dynamic json) {
    coin = json["coin"];
    value = json["value"];
    sendFrom = json["sendFrom"];
    payload = json["payload"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["coin"] = coin;
    map["value"] = value;
    map["payload"] = payload;
    map["sendFrom"] = sendFrom;
    return map;
  }
}
