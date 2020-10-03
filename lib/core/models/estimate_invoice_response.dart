class EstimateInvoiceResponse {
  double value;
  String currency;
  int timestamp;

  EstimateInvoiceResponse({
      this.value, 
      this.currency, 
      this.timestamp});

  EstimateInvoiceResponse.fromJson(dynamic json) {
    value = json["value"];
    currency = json["currency"];
    timestamp = json["timestamp"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["value"] = value;
    map["currency"] = currency;
    map["timestamp"] = timestamp;
    return map;
  }

}