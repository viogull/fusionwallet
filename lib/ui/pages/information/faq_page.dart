import 'package:flutter/material.dart';
import 'package:fusion_wallet/localizations.dart';
import 'package:fusion_wallet/ui/components/custom/fusion_scaffold.dart';

class FaqPage extends StatelessWidget {
  static const navId = "/faq";

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FusionScaffold(
      child: Container(),
      title: AppLocalizations.of(context).settingsItemFaq(),
    );
  }
}
//import 'package:flutter/material.dart';
//
//void main() => runApp(MyApp());
//
//class MyApp extends StatelessWidget {
//  // This widget is the root of your application.
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      title: 'Flutter Demo',
//      theme: ThemeData(
//        primarySwatch: Colors.blue,
//      ),
//      home: Superheros(),
//    );
//  }
//}
//
//class Superheros extends StatefulWidget {
//  @override
//  _SuperherosState createState() => _SuperherosState();
//}
//
//class _SuperherosState extends State<Superheros> {
//  List<Rate> rate;
//
//
//
//  @override
//  void initState() {
//
//
//    rate = Rate.getRate();
//    super.initState();
//  }
//
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        title: Text("Avengers DataTable"),
//        centerTitle: true,
//      ),
//      body: SingleChildScrollView(
//        scrollDirection: Axis.vertical,
//        child: Center(
//          child: Padding(
//            padding: const EdgeInsets.only(top: 30.0),
//            child: DataTable(
//              columns: [
//                DataColumn(
//                    label: Text("", style: TextStyle(fontSize: 16)),
//                    numeric: false,
//                    ),
//                DataColumn(
//                  label: Text("Sale", style: TextStyle(fontSize: 16)),
//                  numeric: false,
//                ),
//                DataColumn(
//                  label: Text("Buy", style: TextStyle(fontSize: 16)),
//                  numeric: false,
//                ),
//
//              ],
//              rows: rate
//                  .map(
//                    (avenger) => DataRow(
//
//                    cells: [
//                      DataCell(
//                        Text(avenger.coin),
//                      ),
//                      DataCell(
//                        Text(avenger.sale),
//                      ),
//                      DataCell(
//                        Text(avenger.buy),
//                      ),
//                    ]),
//              )
//                  .toList(),
//            ),
//          ),
//        ),
//      ),
//    );
//  }
//}
//
//class Rate {
//  String coin;
//  String sale;
//  String buy;
//
//
//
//  Rate({this.coin, this.sale, this.buy});
//
//  static List<Rate> getRate() {
//    return <Rate>[
//      Rate(coin: "BIP", sale: "1", buy: '1'),
//      Rate(coin: "BTC", sale: "0.312", buy: '1'),
//      Rate(coin: "ETH", sale: "1.234", buy: '1'),
//
//    ];
//  }
//}