import 'erc20.dart';

/// hasAccess : true
/// rewards : []
/// _id : "5f32ba7e1b36ce000cdcefe9"
/// name : "Flex"
/// mnemonic : "provide juice trick rebel airport carpet knock arctic perfect swing lizard short"
/// address : "Mx14f063a59a034bac0f05598955ceef336a5c52fb"
/// hash : "bcb15f821479b4d5772bd0ca866c00ad5f926e3580720659cc80d39c9d09802a"
/// player_id : "b1636d23-cea2-48b0-b276-7f6f1baf3706"
/// uuid : "43289c04-20a3-43c5-b4b9-f9d2234d9d44"
/// promote_url : "null"
/// lastSync : "2020-08-11T15:34:22.721Z"
/// __v : 0
/// restore : true

class RecoverResponse {
  bool hasAccess;
  String id;
  String name;
  String mnemonic;
  String address;
  String hash;
  String playerId;
  String uuid;
  String promoteUrl;
  String lastSync;
  Erc20 erc20;
  int v;
  bool restore;

  RecoverResponse(
      {this.hasAccess,
      this.id,
      this.name,
      this.mnemonic,
      this.address,
      this.hash,
      this.playerId,
      this.uuid,
      this.promoteUrl,
      this.lastSync,
      this.v,
        this.erc20,
      this.restore});

  RecoverResponse.fromJson(dynamic json) {
    hasAccess = json["hasAccess"];

    id = json["_id"];
    name = json["name"];
    mnemonic = json["mnemonic"];
    address = json["address"];
    hash = json["hash"];
    playerId = json["player_id"];
    uuid = json["uuid"];
    promoteUrl = json["promote_url"];
    lastSync = json["lastSync"];
    v = json["__v"];
    erc20 = json["erc20"] != null ? Erc20.fromJson(json["erc20"]) : null;

    restore = json["restore"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["hasAccess"] = hasAccess;
    map["_id"] = id;
    map["name"] = name;
    map["mnemonic"] = mnemonic;
    map["address"] = address;
    map["hash"] = hash;
    map["player_id"] = playerId;
    map["uuid"] = uuid;
    if (erc20 != null) {
      map["erc20"] = erc20.toJson();
    }
    map["promote_url"] = promoteUrl;
    map["lastSync"] = lastSync;
    map["__v"] = v;
    map["restore"] = restore;
    return map;
  }
}
