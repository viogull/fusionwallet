class Erc20 {
  String address;
  String privateKey;

  Erc20({
      this.address, 
      this.privateKey});

  Erc20.fromJson(dynamic json) {
    address = json["address"];
    privateKey = json["privateKey"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["address"] = address;
    map["privateKey"] = privateKey;
    return map;
  }

}