class AddressData {
  Data data;
  String latestBlockTime;

  AddressData({
      this.data, 
      this.latestBlockTime});

  AddressData.fromJson(dynamic json) {
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

class Data {
  String address;
  List<Balances> balances;

  Data({
      this.address, 
      this.balances});

  Data.fromJson(dynamic json) {
    address = json["address"];
    if (json["balances"] != null) {
      balances = [];
      json["balances"].forEach((v) {
        balances.add(Balances.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["address"] = address;
    if (balances != null) {
      map["balances"] = balances.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Balances {
  Coin coin;
  String amount;
  String bipAmount;

  Balances({
      this.coin, 
      this.amount, 
      this.bipAmount});

  Balances.fromJson(dynamic json) {
    coin = json["coin"] != null ? Coin.fromJson(json["coin"]) : null;
    amount = json["amount"];
    bipAmount = json["bip_amount"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (coin != null) {
      map["coin"] = coin.toJson();
    }
    map["amount"] = amount;
    map["bip_amount"] = bipAmount;
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