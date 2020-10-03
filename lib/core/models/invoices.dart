import 'estimation.dart';

class Invoices {
  Estimation estimation;
  String creationDate;
  String status;
  bool completed;
  String id;
  String createdBy;
  String coin;
  String fiatCurrency;
  double qty;
  String card;
  String networkType;
  String mnemonic;
  int v;
  String createdAt;
  String invoice;
  String message;
  String updatedAt;

  Invoices({
      this.estimation, 
      this.creationDate, 
      this.status, 
      this.completed, 
      this.id, 
      this.createdBy, 
      this.coin, 
      this.fiatCurrency, 
      this.qty, 
      this.card, 
      this.networkType, 
      this.mnemonic, 
      this.v, 
      this.createdAt, 
      this.invoice, 
      this.message, 
      this.updatedAt});

  Invoices.fromJson(dynamic json) {
    estimation = json["estimation"] != null ? Estimation.fromJson(json["estimation"]) : null;
    creationDate = json["creationDate"];
    status = json["status"];
    completed = json["completed"];
    id = json["Id"];
    createdBy = json["createdBy"];
    coin = json["coin"];
    fiatCurrency = json["fiatCurrency"];
    qty = json["qty"];
    card = json["card"];
    networkType = json["networkType"];
    mnemonic = json["mnemonic"];
    v = json["V"];
    createdAt = json["createdAt"];
    invoice = json["invoice"];
    message = json["message"];
    updatedAt = json["updatedAt"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (estimation != null) {
      map["estimation"] = estimation.toJson();
    }
    map["creationDate"] = creationDate;
    map["status"] = status;
    map["completed"] = completed;
    map["Id"] = id;
    map["createdBy"] = createdBy;
    map["coin"] = coin;
    map["fiatCurrency"] = fiatCurrency;
    map["qty"] = qty;
    map["card"] = card;
    map["networkType"] = networkType;
    map["mnemonic"] = mnemonic;
    map["V"] = v;
    map["createdAt"] = createdAt;
    map["invoice"] = invoice;
    map["message"] = message;
    map["updatedAt"] = updatedAt;
    return map;
  }

}