/// coins : ["BIP","ZERO","KARAT","DEV","POP","CAT","POPE","SHSCOIN","CONSULCOIN","BTCSECURE","LASHIN","GOLDEN","TEAM","NUT","GOODLY"]

class MinterCoinsResponse {
  List<String> coins;

  MinterCoinsResponse({
      this.coins});

  MinterCoinsResponse.fromJson(dynamic json) {
    coins = json["coins"] != null ? json["coins"].cast<String>() : [];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["coins"] = coins;
    return map;
  }

}