/// publicKey : "MpXSxxs"
/// coin : "MNT"
/// stake : 1000
/// gasCoin : "MNT"

class DelegateUboundTxRequest {
  String publicKey;
  String coin;
  int stake;
  String gasCoin;

  DelegateUboundTxRequest(
      {this.publicKey, this.coin, this.stake, this.gasCoin});

  DelegateUboundTxRequest.fromJson(dynamic json) {
    publicKey = json["publicKey"];
    coin = json["coin"];
    stake = json["stake"];
    gasCoin = json["gasCoin"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["publicKey"] = publicKey;
    map["coin"] = coin;
    map["stake"] = stake;
    map["gasCoin"] = gasCoin;
    return map;
  }
}
