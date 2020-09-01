import 'package:fusion_wallet/core/models/profile_response.dart';

/// restore : true
/// data : {"hasAccess":true,"rewards":[],"_id":"5f32ba7e1b36ce000cdcefe9","name":"Flex","mnemonic":"provide juice trick rebel airport carpet knock arctic perfect swing lizard short","address":"Mx14f063a59a034bac0f05598955ceef336a5c52fb","hash":"bcb15f821479b4d5772bd0ca866c00ad5f926e3580720659cc80d39c9d09802a","player_id":"b1636d23-cea2-48b0-b276-7f6f1baf3706","uuid":"43289c04-20a3-43c5-b4b9-f9d2234d9d44","promote_url":"null","lastSync":"2020-08-11T15:34:22.721Z","__v":0}

class CanRecoverResponse {
  bool restore;
  ProfileResponse data;

  CanRecoverResponse({this.restore, this.data});

  CanRecoverResponse.fromJson(dynamic json) {
    restore = json["restore"];
    data = json["data"] != null ? ProfileResponse.fromJson(json["data"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["restore"] = restore;
    if (data != null) {
      map["data"] = data.toJson();
    }
    return map;
  }
}
