import 'package:fusion_wallet/core/models/withdraw_invoice.dart';


class PersonalInvoicesResponse {
  List<WithdrawInvoice> invoices;

  PersonalInvoicesResponse({
      this.invoices});

  PersonalInvoicesResponse.fromJson(dynamic json) {
    if (json["invoices"] != null) {
      invoices = [];
      json["invoices"].forEach((v) {
        invoices.add(WithdrawInvoice.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (invoices != null) {
      map["invoices"] = invoices.map((v) => v.toJson()).toList();
    }
    return map;
  }

}