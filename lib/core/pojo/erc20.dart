class Erc20 {
  String symbol;
  String addr;
  double balance;
  int balanceUsd;

  Erc20({
      this.symbol, 
      this.addr, 
      this.balance, 
      this.balanceUsd});

  Erc20.fromJson(dynamic json) {
    symbol = json["symbol"];
    addr = json["addr"];
    balance = json["balance"];
    balanceUsd = json["balanceUsd"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["symbol"] = symbol;
    map["addr"] = addr;
    map["balance"] = balance;
    map["balanceUsd"] = balanceUsd;
    return map;
  }

}