import 'receivers.dart';

class MultisendRequest {
  String coin;
  List<Receivers> receivers;
  String mnemonic;

  MultisendRequest({
      this.coin, 
      this.receivers, 
      this.mnemonic});

  MultisendRequest.fromJson(dynamic json) {
    coin = json["coin"];
    if (json["receivers"] != null) {
      receivers = [];
      json["receivers"].forEach((v) {
        receivers.add(Receivers.fromJson(v));
      });
    }
    mnemonic = json["mnemonic"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["coin"] = coin;
    if (receivers != null) {
      map["receivers"] = receivers.map((v) => v.toJson()).toList();
    }
    map["mnemonic"] = mnemonic;
    return map;
  }

}