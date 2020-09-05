/// willGet : "14.481763441129249186"
/// commission : "0.1"

class EstimateResponse {
  String willGet;
  String commission;

  EstimateResponse({this.willGet, this.commission});

  EstimateResponse.fromJson(dynamic json) {
    willGet = json["willGet"];
    commission = json["commission"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["willGet"] = willGet;
    map["commission"] = commission;
    return map;
  }
}
