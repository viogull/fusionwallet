import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:fusion_wallet/core/models/currency_prices_response.dart';
import 'package:fusion_wallet/localizations.dart';
import 'package:fusion_wallet/ui/components/custom/scaffold.dart';
import 'package:google_fonts/google_fonts.dart';

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

              return Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: DataTable(
                    columns: [
                      DataColumn(
                        label: Text("      ",
                            style: TextStyle(fontSize: 14),
                            textAlign: TextAlign.center),
                      ),
                      DataColumn(
                        label: Text(AppLocalizations.of(context).buttonSell(),
                            style: TextStyle(fontSize: 14),
                            textAlign: TextAlign.center),
                      ),
                      DataColumn(
                        label: Text(AppLocalizations.of(context).buttonBuy(),
                            style: TextStyle(fontSize: 14),
                            textAlign: TextAlign.center),
                      ),
                    ],
                    horizontalMargin: 4,
                    rows: [
                      DataRow(cells: [
                        DataCell(Text(
                          'BTC',
                          textAlign: TextAlign.center,
                          style: headerStyle(context),
                        )),
                        DataCell(
                          Text(response.bTC.buy.toStringAsFixed(4),
                              textAlign: TextAlign.center),
                        ),
                        DataCell(
                          Text(response.bTC.sell.toStringAsFixed(4)),
                        )
                      ]),
                      DataRow(cells: [
                        DataCell(
                          Text('ETH', textAlign: TextAlign.center,),
                        ),
                        DataCell(
                          Text(response.eTH.buy.toStringAsFixed(4),
                              textAlign: TextAlign.center),
                        ),
                        DataCell(
                          Text(response.eTH.sell.toStringAsFixed(4)),
                        )
                      ]),
                      DataRow(cells: [
                        DataCell(
                          Text('FUSION', textAlign: TextAlign.center, style: headerStyle(context),),
                        ),
                        DataCell(
                          Text(response.fUSION.buy.toStringAsFixed(8),
                              textAlign: TextAlign.center),
                        ),
                        DataCell(
                          Text(
                            response.fUSION.sell.toStringAsFixed(8),
                            textAlign: TextAlign.center,
                          ),
                        )
                      ]),
                      DataRow(cells: [
                        DataCell(
                          Text('BIP', textAlign: TextAlign.center, style: headerStyle(context),),
                        ),
                        DataCell(
                          Text(response.bIP.buy.toStringAsFixed(5),
                              textAlign: TextAlign.center),
                        ),
                        DataCell(
                          Text(response.bIP.sell.toStringAsFixed(5), textAlign: TextAlign.center,),
                        )
                      ]),
                      DataRow(cells: [
                        DataCell(
                          Text('USDT', textAlign: TextAlign.center,  style: headerStyle(context),),
                        ),
                        DataCell(
                          Text(response.uSDT.buy.toStringAsFixed(4),
                              textAlign: TextAlign.center),
                        ),
                        DataCell(
                          Text(response.uSDT.sell.toStringAsFixed(4), textAlign: TextAlign.center,),
                        )
                      ]),
                    ]),
              );
            } else {
              return Center(child: PlatformCircularProgressIndicator());
            }
          }),
    );
  }



  headerStyle(BuildContext context) => GoogleFonts.robotoMono(fontSize: 16, color: Theme.of(context).colorScheme.onBackground.withOpacity(0.8));
}
