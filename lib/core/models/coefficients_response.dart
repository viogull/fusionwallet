class CoefficientsResponse {
  List<Rates> rates;

  CoefficientsResponse({this.rates});

  CoefficientsResponse.fromJson(Map<String, dynamic> json) {
    if (json['rates'] != null) {
      rates = new List<Rates>();
      json['rates'].forEach((v) {
        rates.add(new Rates.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.rates != null) {
      data['rates'] = this.rates.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Rates {
  String currency;
  dynamic value;
  String sId;

  Rates({this.currency, this.value, this.sId});

  Rates.fromJson(Map<String, dynamic> json) {
    currency = json['currency'];
    value = json['value'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['currency'] = this.currency;
    data['value'] = this.value;
    data['_id'] = this.sId;
    return data;
  }
}
