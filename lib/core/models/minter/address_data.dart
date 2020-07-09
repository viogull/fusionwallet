/// data : {"address":"Mx039f3c8b3568812dfc1fbf2d22f214d2538df712","balances":[{"coin":"BIP","amount":"0.000000000000000000"}]}
/// latest_block_time : "2020-07-08T18:54:33Z"

class AddressData {
  Data _data;
  String _latestBlockTime;

  Data get data => _data;
  String get latestBlockTime => _latestBlockTime;

  AddressData({
      Data data, 
      String latestBlockTime}){
    _data = data;
    _latestBlockTime = latestBlockTime;
}

  AddressData.fromJson(dynamic json) {
    _data = json["data"] != null ? Data.fromJson(json["data"]) : null;
    _latestBlockTime = json["latestBlockTime"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_data != null) {
      map["data"] = _data.toJson();
    }
    map["latestBlockTime"] = _latestBlockTime;
    return map;
  }

}

/// address : "Mx039f3c8b3568812dfc1fbf2d22f214d2538df712"
/// balances : [{"coin":"BIP","amount":"0.000000000000000000"}]

class Data {
  String _address;
  List<Balances> _balances;

  String get address => _address;
  List<Balances> get balances => _balances;

  Data({
      String address, 
      List<Balances> balances}){
    _address = address;
    _balances = balances;
}

  Data.fromJson(dynamic json) {
    _address = json["address"];
    if (json["balances"] != null) {
      _balances = [];
      json["balances"].forEach((v) {
        _balances.add(Balances.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["address"] = _address;
    if (_balances != null) {
      map["balances"] = _balances.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// coin : "BIP"
/// amount : "0.000000000000000000"

class Balances {
  String _coin;
  String _amount;

  String get coin => _coin;
  String get amount => _amount;

  Balances({
      String coin, 
      String amount}){
    _coin = coin;
    _amount = amount;
}

  Balances.fromJson(dynamic json) {
    _coin = json["coin"];
    _amount = json["amount"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["coin"] = _coin;
    map["amount"] = _amount;
    return map;
  }

}