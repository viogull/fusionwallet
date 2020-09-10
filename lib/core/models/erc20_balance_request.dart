/// jsonrpc : "2.0"
/// method : "eth_getBalance"
/// params : ["0xc94770007dda54cF92009BFF0dE90c06F603a09f","latest"]
/// id : 1

class Erc20BalanceRequest {

  final String  blockParam = "latest";


  String jsonrpc = "2.0";
  String method = "eth_getBalance";
  List<String> params;
   int id = 1;

  Erc20BalanceRequest(String address) {
    params.add(address);
    params.add(blockParam);
  }

  Erc20BalanceRequest.fromJson(dynamic json) {
    jsonrpc = json["jsonrpc"];
    method = json["method"];
    params = json["params"] != null ? json["params"].cast<String>() : [];
    id = json["id"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["jsonrpc"] = jsonrpc;
    map["method"] = method;
    map["params"] = params;
    map["id"] = id;
    return map;
  }

}