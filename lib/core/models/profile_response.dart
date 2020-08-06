/// hasAccess : true
/// rewards : []
/// _id : "5f2ab7067c8bff52909ddac9"
/// name : "Joe"
/// mnemonic : "city scrap little candy glide artist force strike demand raven okay twist"
/// address : "Mx5d9db9d7e1c18835805f5ce373d493e6e353192d"
/// hash : "bcb15f821479b4d5772bd0ca866c00ad5f926e3580720659cc80d39c9d09802a"
/// player_id : "b1e0e02b-8468-4793-9c3c-efeb958ddf39"
/// uuid : "58d56599-ca54-4493-9cc2-40538f6a5787"
/// promote_url : "null"
/// lastSync : "2020-08-05T13:41:26.818Z"
/// __v : 0

class ProfileResponse {
  bool hasAccess;
  List<dynamic> rewards;
  String id;
  String name;
  String mnemonic;
  String address;
  String hash;
  String playerId;
  String uuid;
  String promoteUrl;
  String lastSync;
  int v;

  ProfileResponse(
      {this.hasAccess,
      this.rewards,
      this.id,
      this.name,
      this.mnemonic,
      this.address,
      this.hash,
      this.playerId,
      this.uuid,
      this.promoteUrl,
      this.lastSync,
      this.v});

  ProfileResponse.fromJson(dynamic json) {
    hasAccess = json["hasAccess"];
    if (json["rewards"] != null) {
      rewards = [];
      json["rewards"].forEach((v) {
        rewards.add(v.fromJson(v));
      });
    }
    id = json["Id"];
    name = json["name"];
    mnemonic = json["mnemonic"];
    address = json["address"];
    hash = json["hash"];
    playerId = json["playerId"];
    uuid = json["uuid"];
    promoteUrl = json["promoteUrl"];
    lastSync = json["lastSync"];
    v = json["V"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["hasAccess"] = hasAccess;
    if (rewards != null) {
      map["rewards"] = rewards.map((v) => v.toJson()).toList();
    }
    map["Id"] = id;
    map["name"] = name;
    map["mnemonic"] = mnemonic;
    map["address"] = address;
    map["hash"] = hash;
    map["playerId"] = playerId;
    map["uuid"] = uuid;
    map["promoteUrl"] = promoteUrl;
    map["lastSync"] = lastSync;
    map["V"] = v;
    return map;
  }
}
