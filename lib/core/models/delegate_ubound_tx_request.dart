/// publicKey : "MpXSxxs"
/// coin : "MNT"
/// stake : 1000
/// gasCoin : "MNT"

class DelegateUboundTxRequest {
  String publicKey;
  String coin;
  String stake;
  String gasCoin;
  String mnemonic;

  DelegateUboundTxRequest(
      {this.publicKey, this.coin, this.stake, this.gasCoin, this.mnemonic});

  DelegateUboundTxRequest.fromJson(dynamic json) {
    publicKey = json["publicKey"];
    coin = json["coin"];
    stake = json["stake"];
    gasCoin = json["gasCoin"];
    mnemonic = json['mnemonic'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["publicKey"] = publicKey;
    map["coin"] = coin;
    map["stake"] = stake;
    map["mnemonic"] = mnemonic;
    return map;
  }
}
