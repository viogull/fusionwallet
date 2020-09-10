/// jsonrpc : "2.0"
/// id : 1
/// result : "0x7c2562030800"

class Erc20BalanceResponse {
  String jsonrpc;
  int id;
  String result;

  Erc20BalanceResponse({
      this.jsonrpc, 
      this.id, 
      this.result});

  Erc20BalanceResponse.fromJson(dynamic json) {
    jsonrpc = json["jsonrpc"];
    id = json["id"];
    result = json["result"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["jsonrpc"] = jsonrpc;
    map["id"] = id;
    map["result"] = result;
    return map;
  }

}