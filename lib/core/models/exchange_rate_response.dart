/// avrbuy : "0.0033"
/// avrsell : "0.0039"

class ExchangeRateResponse {
  String _avrbuy;
  String _avrsell;

  String get avrbuy => _avrbuy;
  String get avrsell => _avrsell;

  ExchangeRateResponse({String avrbuy, String avrsell}) {
    _avrbuy = avrbuy;
    _avrsell = avrsell;
  }

  ExchangeRateResponse.fromJson(dynamic json) {
    _avrbuy = json["avrbuy"];
    _avrsell = json["avrsell"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["avrbuy"] = _avrbuy;
    map["avrsell"] = _avrsell;
    return map;
  }
}
