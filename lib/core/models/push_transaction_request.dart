/// transaction : "f8820d018a4d4e540000000000000001a9e88a4d4e5400000000000000941b685a7c1e78726c48f619c497a07ed75fe00483872386f26fc10000808001b845f8431ca05ddcd3ffd2d5b21ffe4686cadbb462bad9facdd7ee0c2db31a7b6da6f06468b3a044df8fc8b4c4190ef352e0f70112527b6b25c4a22a67c9e9365ac7e511ac12f3"

class PushTransactionRequest {
  String transaction;

  PushTransactionRequest({this.transaction});

  PushTransactionRequest.fromJson(dynamic json) {
    transaction = json["transaction"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["transaction"] = transaction;
    return map;
  }
}
