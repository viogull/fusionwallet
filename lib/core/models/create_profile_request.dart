/// player_id : "b1e0e02b-8468-4793-9c3c-efeb958ddf39"
/// name : "Joe"
/// mnemonic : "city scrap little candy glide artist force strike demand raven okay twist"
/// promote_url : "null"
/// pin : "111111"

class CreateProfileRequest {
  String playerId;
  String name;
  String mnemonic;
  String promoteUrl;
  String pin;

  CreateProfileRequest(
      {this.playerId, this.name, this.mnemonic, this.promoteUrl, this.pin});

  CreateProfileRequest.fromJson(dynamic json) {
    playerId = json["player_id"];
    name = json["name"];
    mnemonic = json["mnemonic"];
    promoteUrl = json["promote_url"];
    pin = json["pin"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["player_id"] = playerId;
    map["name"] = name;
    map["mnemonic"] = mnemonic;
    map["promote_url"] = promoteUrl;
    map["pin"] = pin;
    return map;
  }
}
