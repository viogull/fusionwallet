/// to : "Mxsdopoapsdosadpasldp"
/// value : "1.00"
/// coin : "MNT"
/// gasCoin : "MNT"

class SendTxRequest {
  String to;
  String value;
  String coin;
  String gasCoin;

  SendTxRequest({this.to, this.value, this.coin, this.gasCoin});

  SendTxRequest.fromJson(dynamic json) {
    to = json["to"];
    value = json["value"];
    coin = json["coin"];
    gasCoin = json["gasCoin"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["to"] = to;
    map["value"] = value;
    map["coin"] = coin;
    map["gasCoin"] = gasCoin;
    return map;
  }
}
