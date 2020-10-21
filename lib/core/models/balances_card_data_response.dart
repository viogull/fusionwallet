import 'package:fusion_wallet/core/pojo/minter.dart';

import 'erc20.dart';

class BalancesCardDataResponse {
  List<Minter> minter;
  List<Erc20> erc20;

  BalancesCardDataResponse({
      this.minter, 
      this.erc20});

  BalancesCardDataResponse.fromJson(dynamic json) {
    if (json["minter"] != null) {
      minter = [];
      json["minter"].forEach((v) {
        minter.add(Minter.fromJson(v));
      });
    }
    if (json["erc20"] != null) {
      erc20 = [];
      json["erc20"].forEach((v) {
        erc20.add(Erc20.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (minter != null) {
      map["minter"] = minter.map((v) => v.toJson()).toList();
    }
    if (erc20 != null) {
      map["erc20"] = erc20.map((v) => v.toJson()).toList();
    }
    return map;
  }

}