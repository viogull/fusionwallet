import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fusion_wallet/localizations.dart';
import 'package:fusion_wallet/ui/components/custom/fusion_scaffold.dart';

class RateExchangePage extends StatefulWidget {
  static const String navId = '/RateExchangePage';
  @override
  _RateExchangePageState createState() => new _RateExchangePageState();
}

class _RateExchangePageState extends State<RateExchangePage> {

  List<Rate> rate;



  @override
  void initState() {


    rate = Rate.getRate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return FusionScaffold(
      title: AppLocalizations.of(context).labelExchangeCoins(),
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: DataTable(
          columns: [
            DataColumn(
              label: Text("", style: TextStyle(fontSize: 16)),
              numeric: false,
            ),
            DataColumn(
              label: Text("Sale", style: TextStyle(fontSize: 16)),
              numeric: false,
            ),
            DataColumn(
              label: Text("Buy", style: TextStyle(fontSize: 16)),
              numeric: false,
            ),

          ],
          rows: rate
              .map(
                (avenger) => DataRow(

                cells: [
                  DataCell(
                    Text(avenger.coin),
                  ),
                  DataCell(
                    Text(avenger.sale),
                  ),
                  DataCell(
                    Text(avenger.buy),
                  ),
                ]),
          )
              .toList(),
        ),




      ),
    );
  }
}
class Rate {
  String coin;
  String sale;
  String buy;



  Rate({this.coin, this.sale, this.buy});

  static List<Rate> getRate() {
    return <Rate>[
      Rate(coin: "BIP", sale: "1", buy: '1'),
      Rate(coin: "BTC", sale: "0.312", buy: '1'),
      Rate(coin: "ETH", sale: "1.234", buy: '1'),

    ];
  }
}
