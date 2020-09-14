import 'b_t_c.dart';
import 'e_t_h.dart';
import 'u_s_d_t.dart';
import 'b_i_p.dart';
import 'f_u_s_i_o_n.dart';

class CurrencyPricesResponse {
  BTC bTC;
  ETH eTH;
  USDT uSDT;
  BIP bIP;
  FUSION fUSION;

  CurrencyPricesResponse({
      this.bTC, 
      this.eTH, 
      this.uSDT, 
      this.bIP, 
      this.fUSION});

  CurrencyPricesResponse.fromJson(dynamic json) {
    bTC = json["BTC"] != null ? BTC.fromJson(json["BTC"]) : null;
    eTH = json["ETH"] != null ? ETH.fromJson(json["ETH"]) : null;
    uSDT = json["USDT"] != null ? USDT.fromJson(json["USDT"]) : null;
    bIP = json["BIP"] != null ? BIP.fromJson(json["BIP"]) : null;
    fUSION = json["FUSION"] != null ? FUSION.fromJson(json["FUSION"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (bTC != null) {
      map["BTC"] = bTC.toJson();
    }
    if (eTH != null) {
      map["ETH"] = eTH.toJson();
    }
    if (uSDT != null) {
      map["USDT"] = uSDT.toJson();
    }
    if (bIP != null) {
      map["BIP"] = bIP.toJson();
    }
    if (fUSION != null) {
      map["FUSION"] = fUSION.toJson();
    }
    return map;
  }

}