import 'transaction.dart';

/// data : [{"txn":4013680,"hash":"Mt9851e50b7086afa875aa1f4513eaf6071660ee74e95d67f92c6ab24cfc64a4ac"},{"txn":4013679,"hash":"Mt581835ab965df12c1cce9aad450a3d736ea2fdc006ac94c530815e687aca7932"}]
/// links : {"first":"explorer-api.minter.network/api/v1/transactions?address=Mx9ee8786c6bb80cf321b7a11b4d57ba5df1143879&page=1","last":"explorer-api.minter.network/api/v1/transactions?address=Mx9ee8786c6bb80cf321b7a11b4d57ba5df1143879&page=80250","prev":null,"next":"explorer-api.minter.network/api/v1/transactions?address=Mx9ee8786c6bb80cf321b7a11b4d57ba5df1143879&page=2"}
/// meta : {"current_page":1,"last_page":80250,"path":"explorer-api.minter.network/api/v1/transactions","per_page":50,"total":4012494}

class TransactionsResponse {
  List<Transaction> data;
  Links links;
  Meta meta;

  TransactionsResponse({this.data, this.links, this.meta});

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

/// current_page : 1
/// last_page : 80250
/// path : "explorer-api.minter.network/api/v1/transactions"
/// per_page : 50
/// total : 4012494

class Meta {
  int currentPage;
  int lastPage;
  String path;
  int perPage;
  int total;

  Meta({this.currentPage, this.lastPage, this.path, this.perPage, this.total});

  Meta.fromJson(dynamic json) {
    currentPage = json["currentPage"];
    lastPage = json["lastPage"];
    path = json["path"];
    perPage = json["perPage"];
    total = json["total"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["currentPage"] = currentPage;
    map["lastPage"] = lastPage;
    map["path"] = path;
    map["perPage"] = perPage;
    map["total"] = total;
    return map;
  }
}

/// first : "explorer-api.minter.network/api/v1/transactions?address=Mx9ee8786c6bb80cf321b7a11b4d57ba5df1143879&page=1"
/// last : "explorer-api.minter.network/api/v1/transactions?address=Mx9ee8786c6bb80cf321b7a11b4d57ba5df1143879&page=80250"
/// prev : null
/// next : "explorer-api.minter.network/api/v1/transactions?address=Mx9ee8786c6bb80cf321b7a11b4d57ba5df1143879&page=2"

class Links {
  String first;
  String last;
  dynamic prev;
  String next;

  Links({this.first, this.last, this.prev, this.next});

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

/// txn : 4013680
/// hash : "Mt9851e50b7086afa875aa1f4513eaf6071660ee74e95d67f92c6ab24cfc64a4ac"
