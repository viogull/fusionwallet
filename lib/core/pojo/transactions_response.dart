class TransactionsResponse {
  List<Transaction> data;
  Links links;
  Meta meta;

  TransactionsResponse({
      this.data, 
      this.links, 
      this.meta});

  TransactionsResponse.fromJson(dynamic json) {
    if (json["data"] != null) {
      data = [];
      json["data"].forEach((v) {
        data.add(Transaction.fromJson(v));
      });
    }
    links = json["links"] != null ? Links.fromJson(json["links"]) : null;
    meta = json["meta"] != null ? Meta.fromJson(json["meta"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (data != null) {
      map["data"] = data.map((v) => v.toJson()).toList();
    }
    if (links != null) {
      map["links"] = links.toJson();
    }
    if (meta != null) {
      map["meta"] = meta.toJson();
    }
    return map;
  }

}

class Meta {
  int currentPage;
  int lastPage;
  String path;
  int perPage;
  int total;

  Meta({
      this.currentPage, 
      this.lastPage, 
      this.path, 
      this.perPage, 
      this.total});

  Meta.fromJson(dynamic json) {
    currentPage = json["current_page"];
    lastPage = json["last_page"];
    path = json["path"];
    perPage = json["per_page"];
    total = json["total"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["current_page"] = currentPage;
    map["last_page"] = lastPage;
    map["path"] = path;
    map["per_page"] = perPage;
    map["total"] = total;
    return map;
  }

}

class Links {
  String first;
  String last;
  dynamic prev;
  dynamic next;

  Links({
      this.first, 
      this.last, 
      this.prev, 
      this.next});

  Links.fromJson(dynamic json) {
    first = json["first"];
    last = json["last"];
    prev = json["prev"];
    next = json["next"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["first"] = first;
    map["last"] = last;
    map["prev"] = prev;
    map["next"] = next;
    return map;
  }

}

class Transaction {
  int txn;
  String hash;
  int nonce;
  int height;
  String timestamp;
  Gas_coin gasCoin;
  String gas;
  int gasPrice;
  String fee;
  int type;
  String payload;
  String from;
  Data data;
  String rawTx;

  Transaction({
      this.txn, 
      this.hash, 
      this.nonce, 
      this.height, 
      this.timestamp, 
      this.gasCoin, 
      this.gas, 
      this.gasPrice, 
      this.fee, 
      this.type, 
      this.payload, 
      this.from, 
      this.data, 
      this.rawTx});

  Transaction.fromJson(dynamic json) {
    txn = json["txn"];
    hash = json["hash"];
    nonce = json["nonce"];
    height = json["height"];
    timestamp = json["timestamp"];
    gasCoin = json["gas_coin"] != null ? Gas_coin.fromJson(json["gas_coin"]) : null;
    gas = json["gas"];
    gasPrice = json["gas_price"];
    fee = json["fee"];
    type = json["type"];
    payload = json["payload"];
    from = json["from"];
    data = json["data"] != null ? Data.fromJson(json["data"]) : null;
    rawTx = json["raw_tx"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["txn"] = txn;
    map["hash"] = hash;
    map["nonce"] = nonce;
    map["height"] = height;
    map["timestamp"] = timestamp;
    if (gasCoin != null) {
      map["gas_coin"] = gasCoin.toJson();
    }
    map["gas"] = gas;
    map["gas_price"] = gasPrice;
    map["fee"] = fee;
    map["type"] = type;
    map["payload"] = payload;
    map["from"] = from;
    if (data != null) {
      map["data"] = data.toJson();
    }
    map["raw_tx"] = rawTx;
    return map;
  }

}

class Data {
  Coin coin;
  String to;
  String value;

  Data({
      this.coin, 
      this.to, 
      this.value});

  Data.fromJson(dynamic json) {
    coin = json["coin"] != null ? Coin.fromJson(json["coin"]) : null;
    to = json["to"];
    value = json["value"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (coin != null) {
      map["coin"] = coin.toJson();
    }
    map["to"] = to;
    map["value"] = value;
    return map;
  }

}

class Coin {
  int id;
  String symbol;

  Coin({
      this.id, 
      this.symbol});

  Coin.fromJson(dynamic json) {
    id = json["id"];
    symbol = json["symbol"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["symbol"] = symbol;
    return map;
  }

}

class Gas_coin {
  int id;
  String symbol;

  Gas_coin({
      this.id, 
      this.symbol});

  Gas_coin.fromJson(dynamic json) {
    id = json["id"];
    symbol = json["symbol"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["symbol"] = symbol;
    return map;
  }

}