/// name : "Joe"
/// mnemonic : "city scrap little candy glide artist force strike demand raven okay twist"

class CanRecoverRequest {
  String name;
  String mnemonic;

  CanRecoverRequest({this.name, this.mnemonic});

  CanRecoverRequest.fromJson(dynamic json) {
    name = json["name"];
    mnemonic = json["mnemonic"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["name"] = name;
    map["mnemonic"] = mnemonic;
    return map;
  }
}
