

import 'address_data.dart';

/// data : {"address":"Mx9dafdb2de4f6d4db4a1a4408aae31fb315acc7d9","balances":[{"coin":"BIP","amount":"0.379000000000000000"}],"total_balance_sum":"0.379000000000000000","total_balance_sum_usd":"0.001837213870000000","available_balance_sum":"0.379000000000000000","available_balance_sum_usd":"0.001837213870000000"}
/// latest_block_time : "2020-09-05T12:15:01Z"

class AddressDataWithUsd {
  Data data;
  String latestBlockTime;

  AddressDataWithUsd({this.data, this.latestBlockTime});

  AddressDataWithUsd.fromJson(dynamic json) {
    data = json["data"] != null ? Data.fromJson(json["data"]) : null;
    latestBlockTime = json["latestBlockTime"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (data != null) {
      map["data"] = data.toJson();
    }
    map["latestBlockTime"] = latestBlockTime;
    return map;
  }
}
