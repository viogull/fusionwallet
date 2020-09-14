import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:fusion_wallet/core/models/coefficients_response.dart';
import 'package:fusion_wallet/core/models/currency_prices_response.dart';
import 'package:fusion_wallet/localizations.dart';
import 'package:fusion_wallet/ui/components/custom/scaffold.dart';

import '../../inject.dart';

class RateExchangePage extends StatelessWidget {
  static const String navId = '/RateExchangePage';

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return FusionScaffold(
      title: AppLocalizations.of(context).toolbarRateTitle(),
      child: FutureBuilder(
          future: injector.get<MinterRest>().fetchCurrencyPrices(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: PlatformCircularProgressIndicator());
            } else if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData == true) {
              final response = snapshot.data as CurrencyPricesResponse;
              var list =  List();

              return Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: DataTable(
                  columns: [
                    DataColumn(
                      label: Text("      ",
                          style: TextStyle(fontSize: 14),
                          textAlign: TextAlign.start),
                      numeric: false,
                    ),
                    DataColumn(
                      label: Text(AppLocalizations.of(context).buttonSell(),
                          style: TextStyle(fontSize: 14),
                          textAlign: TextAlign.center),
                      numeric: false,
                    ),
                    DataColumn(
                      label: Text(AppLocalizations.of(context).buttonBuy(),
                          style: TextStyle(fontSize: 14),
                          textAlign: TextAlign.center),
                      numeric: false,
                    ),
                  ],
                  rows: [
                DataRow(cells:
                [
                  DataCell(Text('BTC'),),
                  DataCell(Text(response.bTC.buy.toString(),textAlign: TextAlign.center),),
                  DataCell(Text(response.bTC.sell.toString()),) ]
                ),
                    DataRow(cells:
                    [
                      DataCell(Text('ETH'),),
                      DataCell(Text(response.eTH.buy.toString(),textAlign: TextAlign.center),),
                      DataCell(Text(response.eTH.sell.toString()),) ]
                    ),
                    DataRow(cells:
                    [
                      DataCell(Text('FUSION'),),
                      DataCell(Text(response.fUSION.buy.toString(),textAlign: TextAlign.center),),
                      DataCell(Text(response.fUSION.sell.toString()),) ]
                    ),
                    DataRow(cells:
                    [
                      DataCell(Text('BIP'),),
                      DataCell(Text(response.bIP.buy.toString(),textAlign: TextAlign.center),),
                      DataCell(Text(response.bIP.sell.toString()),) ]
                    ),
                    DataRow(cells:
                    [
                      DataCell(Text('USDT'),),
                      DataCell(Text(response.uSDT.buy.toString(),textAlign: TextAlign.center),),
                      DataCell(Text(response.uSDT.sell.toString()),) ]
                    ),
                  ]
                ),
              );
            } else {
              return Center(child: PlatformCircularProgressIndicator());
            }
          }),
    );
  }
}
