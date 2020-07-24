/// txn : 4013680
/// hash : "Mt9851e50b7086afa875aa1f4513eaf6071660ee74e95d67f92c6ab24cfc64a4ac"
/// nonce : 12322
/// block : 2429038
/// timestamp : "2020-07-17T16:56:43Z"
/// fee : "0.010000000000000000"
/// gas_coin : "KARAT"
/// type : 1
/// payload : ""
/// from : "Mxf349e19dc79d0f5382858560bf0b90d056d9548d"
/// data : {"coin":"KARAT","to":"Mxca2a976aafe53d02b080cd8beecfc9d604b17d4b","value":"1.000000000000000000"}

class Transaction {
  int txn;
  String hash;
  int nonce;
  int block;
  String timestamp;
  String fee;
  String gasCoin;
  int type;
  String payload;
  String from;
  Data data;

  Transaction(
      {this.txn,
      this.hash,
      this.nonce,
      this.block,
      this.timestamp,
      this.fee,
      this.gasCoin,
      this.type,
      this.payload,
      this.from,
      this.data});

  Transaction.fromJson(dynamic json) {
    txn = json["txn"];
    hash = json["hash"];
    nonce = json["nonce"];
    block = json["block"];
    timestamp = json["timestamp"];
    fee = json["fee"];
    gasCoin = json["gasCoin"];
    type = json["type"];
    payload = json["payload"];
    from = json["from"];
    data = json["data"] != null ? Data.fromJson(json["data"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["txn"] = txn;
    map["hash"] = hash;
    map["nonce"] = nonce;
    map["block"] = block;
    map["timestamp"] = timestamp;
    map["fee"] = fee;
    map["gasCoin"] = gasCoin;
    map["type"] = type;
    map["payload"] = payload;
    map["from"] = from;
    if (data != null) {
      map["data"] = data.toJson();
    }
    return map;
  }
}

/// coin : "KARAT"
/// to : "Mxca2a976aafe53d02b080cd8beecfc9d604b17d4b"
/// value : "1.000000000000000000"

class Data {
  String coin;
  String to;
  String value;

  Data({this.coin, this.to, this.value});

  Data.fromJson(dynamic json) {
    coin = json["coin"];
    to = json["to"];
    value = json["value"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["coin"] = coin;
    map["to"] = to;
    map["value"] = value;
    return map;
  }
}
