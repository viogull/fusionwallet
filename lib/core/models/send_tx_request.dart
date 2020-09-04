/// to : "Mxsdopoapsdosadpasldp"
/// value : "1.00"
/// coin : "MNT"
/// gasCoin : "MNT"

class SendTxRequest {
  String to;
  String value;
  String coin;
  String gasCoin;
  String mnemonic;

  SendTxRequest({this.to, this.value, this.coin, this.gasCoin, this.mnemonic});

  SendTxRequest.fromJson(dynamic json) {
    to = json["to"];
    value = json["value"];
    coin = json["coin"];
    gasCoin = json["gasCoin"];
    mnemonic = json['mnemonic'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["to"] = to;
    map["value"] = value;
    map["coin"] = coin;
    map["gasCoin"] = gasCoin;
    map["mnemonic"] = mnemonic;
    return map;
  }
}
