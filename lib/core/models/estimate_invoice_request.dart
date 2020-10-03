class EstimateInvoiceRequest {
  String from;
  String to;
  double qty;

  EstimateInvoiceRequest({
      this.from, 
      this.to, 
      this.qty});

  EstimateInvoiceRequest.fromJson(dynamic json) {
    from = json["from"];
    to = json["to"];
    qty = json["qty"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["from"] = from;
    map["to"] = to;
    map["qty"] = qty;
    return map;
  }

}