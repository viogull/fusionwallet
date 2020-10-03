import 'estimation.dart';

class WithdrawInvoice {
  Estimation estimation;
  String creationDate;
  String status;
  bool completed;
  String id;
  String networkType;
  String coin;
  String createdBy;
  double  qty;
  String card;
  String mnemonic;
  String fiatCurrency;
  String createdAt;
  String updatedAt;
  int v;

  WithdrawInvoice({
      this.estimation, 
      this.creationDate, 
      this.status, 
      this.completed, 
      this.id, 
      this.networkType, 
      this.coin, 
      this.createdBy, 
      this.qty, 
      this.card, 
      this.mnemonic, 
      this.fiatCurrency, 
      this.createdAt, 
      this.updatedAt, 
      this.v});

  WithdrawInvoice.fromJson(dynamic json) {
    estimation = json["estimation"] != null ? Estimation.fromJson(json["estimation"]) : null;
    creationDate = json["creationDate"];
    status = json["status"];
    completed = json["completed"];
    id = json["_id"];
    networkType = json["networkType"];
    coin = json["coin"];
    createdBy = json["createdBy"];
    qty = json["qty"];
    card = json["card"];
    mnemonic = json["mnemonic"];
    fiatCurrency = json["fiatCurrency"];
    createdAt = json["createdAt"];
    updatedAt = json["updatedAt"];
    v = json["__v"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (estimation != null) {
      map["estimation"] = estimation.toJson();
    }
    map["creationDate"] = creationDate;
    map["status"] = status;
    map["completed"] = completed;
    map["_id"] = id;
    map["networkType"] = networkType;
    map["coin"] = coin;
    map["createdBy"] = createdBy;
    map["qty"] = qty;
    map["card"] = card;
    map["mnemonic"] = mnemonic;
    map["fiatCurrency"] = fiatCurrency;
    map["createdAt"] = createdAt;
    map["updatedAt"] = updatedAt;
    map["__v"] = v;
    return map;
  }

}