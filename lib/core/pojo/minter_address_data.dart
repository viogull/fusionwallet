class MinterAddressData {
  String mnemonic;
  String seed;
  String privateKey;
  String publicKey;
  String address;

  MinterAddressData({
      this.mnemonic, 
      this.seed, 
      this.privateKey, 
      this.publicKey, 
      this.address});

  MinterAddressData.fromJson(dynamic json) {
    mnemonic = json["mnemonic"];
    seed = json["seed"];
    privateKey = json["privateKey"];
    publicKey = json["publicKey"];
    address = json["address"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["mnemonic"] = mnemonic;
    map["seed"] = seed;
    map["privateKey"] = privateKey;
    map["publicKey"] = publicKey;
    map["address"] = address;
    return map;
  }

}