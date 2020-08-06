/// url : "https://fusionpush.cash/tx/-EABq-qKTU5UAAAAAAAAAJR2M5gMAAE53TvSSj9U4GR0-pQeFokFa8deLWMQAACFRGF0YXOAgIpBU0QAAAAAAAAA"

class DecodePushLinkRequest {
  String url;

  DecodePushLinkRequest({this.url});

  DecodePushLinkRequest.fromJson(dynamic json) {
    url = json["url"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["url"] = url;
    return map;
  }
}
