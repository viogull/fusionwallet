import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:fusion_wallet/core/models/coefficients_response.dart';
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
          future: injector.get<MinterRest>().fetchCoefficients(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: PlatformCircularProgressIndicator());
            } else if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData == true) {
              final response = snapshot.data as CoefficientsResponse;
              debugPrint("Res: " + response.rates.length.toString());

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
                  rows: response.rates
                      .map(
                        (avenger) => DataRow(cells: [
                          DataCell(
                            Text(avenger.currency + " "),
                          ),
                          DataCell(
                            Text(avenger.value.toString(),
                                textAlign: TextAlign.center),
                          ),
                          DataCell(
                            Text(avenger.value.toString()),
                          ),
                        ]),
                      )
                      .toList(),
                ),
              );
            } else {
              return Center(child: PlatformCircularProgressIndicator());
            }
          }),
    );
  }
}
