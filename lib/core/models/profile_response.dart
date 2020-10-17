import 'erc20.dart';

class ProfileResponse {
  bool hasAccess;
  List<dynamic> rewards;
  String id;
  String name;
  String mnemonic;
  String address;
  String hash;
  String playerId;
  Erc20 erc20;
  String uuid;
  String promoteUrl;
  String lastSync;
  int v;

  ProfileResponse({
      this.hasAccess, 
      this.rewards, 
      this.id, 
      this.name, 
      this.mnemonic, 
      this.address, 
      this.hash, 
      this.playerId, 
      this.erc20, 
      this.uuid, 
      this.promoteUrl, 
      this.lastSync, 
      this.v});

  ProfileResponse.fromJson(dynamic json) {
    hasAccess = json["hasAccess"];
    if (json["rewards"] != null) {
      rewards = [];
      json["rewards"].forEach((v) {
        rewards.add(v);
      });
    }
    id = json["_id"];
    name = json["name"];
    mnemonic = json["mnemonic"];
    address = json["address"];
    hash = json["hash"];
    playerId = json["playerId"];
    erc20 = json["erc20"] != null ? Erc20.fromJson(json["erc20"]) : null;
    uuid = json["uuid"];
    promoteUrl = json["promoteUrl"];
    lastSync = json["lastSync"];
    v = json["_v"];
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
    if (erc20 != null) {
      map["erc20"] = erc20.toJson();
    }
    map["uuid"] = uuid;
    map["promoteUrl"] = promoteUrl;
    map["lastSync"] = lastSync;
    map["V"] = v;
    return map;
  }

}