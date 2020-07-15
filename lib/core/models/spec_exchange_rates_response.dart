/// time : "2020-04-08 11:25:02"
/// biptousd : "0.0123"
/// usdtobip : "0.0145"

class SpecExchangeRatesResponse {
  String _time;
  String _biptousd;
  String _usdtobip;

  String get time => _time;
  String get biptousd => _biptousd;
  String get usdtobip => _usdtobip;

  SpecExchangeRatesResponse({String time, String biptousd, String usdtobip}) {
    _time = time;
    _biptousd = biptousd;
    _usdtobip = usdtobip;
  }

  SpecExchangeRatesResponse.fromJson(dynamic json) {
    _time = json["time"];
    _biptousd = json["biptousd"];
    _usdtobip = json["usdtobip"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["time"] = _time;
    map["biptousd"] = _biptousd;
    map["usdtobip"] = _usdtobip;
    return map;
  }
}
