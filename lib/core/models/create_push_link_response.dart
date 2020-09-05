/// url : "https://fusion-push.cash/tx/9AGq6YpNTlQAAAAAAAAAlPcbnj-Rt3z6FwNDGRybsWr8Ap__iA3gtrOnZAAAhFRlc3SAgIA"
/// shortUrl : "https://fusion-push.cash/push/5f1b21e3e9145034298971a1"
/// wallet : "Mxf71b9e3f91b77cfa170343191c9bb16afc029fff"

class CreatePushLinkResponse {
  String url;
  String shortUrl;
  String wallet;
  String push_id;
  String shortDeeplink;
  String qty;
  String coin;

  CreatePushLinkResponse(
      {this.url,
      this.shortUrl,
      this.wallet,
      this.shortDeeplink,
      this.push_id,
      this.coin,
      this.qty});

  CreatePushLinkResponse.fromJson(dynamic json) {
    url = json["url"];
    push_id = json["push_id"];
    shortUrl = json["shortUrl"];
    wallet = json["wallet"];
    shortDeeplink = json["shortDeeplink"];
    qty = json["qty"];
    coin = json["coin"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["url"] = url;
    map["push_id"] = push_id;
    map["shortUrl"] = shortUrl;
    map["wallet"] = wallet;
    map["shortDeeplink"] = shortDeeplink;
    map["qty"] = qty;
    map["coin"] = coin;
    return map;
  }
}
