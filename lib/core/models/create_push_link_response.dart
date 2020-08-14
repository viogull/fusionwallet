/// url : "https://fusion-push.cash/tx/9AGq6YpNTlQAAAAAAAAAlPcbnj-Rt3z6FwNDGRybsWr8Ap__iA3gtrOnZAAAhFRlc3SAgIA"
/// shortUrl : "https://fusion-push.cash/push/5f1b21e3e9145034298971a1"
/// wallet : "Mxf71b9e3f91b77cfa170343191c9bb16afc029fff"

class CreatePushLinkResponse {
  String url;
  String shortUrl;
  String wallet;
  String push_id;
  String shortDeeplink;


  CreatePushLinkResponse({this.url, this.shortUrl, this.wallet, this.shortDeeplink, this.push_id});

  CreatePushLinkResponse.fromJson(dynamic json) {
    url = json["url"];
    push_id = json["push_id"];
    shortUrl = json["shortUrl"];
    wallet = json["wallet"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["url"] = url;
    map["push_id"] = push_id;
    map["shortUrl"] = shortUrl;
    map["wallet"] = wallet;
    return map;
  }
}
