class CreateInvoiceRequest {
  String networkType;
  String coin;
  String createdBy;
  double qty;
  String card;
  String mnemonic;
  String fiatCurrency;

  CreateInvoiceRequest(
      {this.networkType,
      this.coin,
      this.createdBy,
      this.qty,
      this.card,
      this.mnemonic,
      this.fiatCurrency});

  CreateInvoiceRequest.fromJson(dynamic json) {
    networkType = json["networkType"];
    coin = json["coin"];
    createdBy = json["createdBy"];
    qty = json["qty"];
    card = json["card"];
    mnemonic = json["mnemonic"];
    fiatCurrency = json["fiatCurrency"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["networkType"] = networkType;
    map["coin"] = coin;
    map["createdBy"] = createdBy;
    map["qty"] = qty;
    map["card"] = card;
    map["mnemonic"] = mnemonic;
    map["fiatCurrency"] = fiatCurrency;
    return map;
  }
}
