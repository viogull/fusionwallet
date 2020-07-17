import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fusion_wallet/localizations.dart';
import 'package:fusion_wallet/ui/components/custom/fusion_scaffold.dart';
import 'package:fusion_wallet/ui/theme.dart';

class PopupHistoryPage extends StatefulWidget {
  static const String navId = '/PopupDialogWidget';
  @override
  _PopupHistoryPageState createState() => new _PopupHistoryPageState();
}

class _PopupHistoryPageState extends State<PopupHistoryPage> {
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  var list;

  Future<Null> _startDateSelect(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: startDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));

    if (picked != null && picked != startDate)
      setState(() {
        startDate = picked;
      });
  }

  Future<Null> _endDateSelect(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: endDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));

    if (picked != null && picked != endDate)
      setState(() {
        endDate = picked;
      });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);




    final labelAccount = Container(
      alignment: Alignment.topLeft,
      margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
      child: Text(
        AppLocalizations.of(context).labelAccount(),
        style: TextStyle(
          color: (theme.colorScheme.onSurface),
        ),
      ),
    );

    final history = Container(

        width: MediaQuery.of(context).size.width,
        child: Card(
          borderOnForeground: false,
          elevation: 16,
          color: Theme.of(context).colorScheme.surface,
          shape: RoundedRectangleBorder(
            borderRadius: FusionTheme.borderRadius,
          ),
          margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
          child: LimitedBox(
            maxWidth: MediaQuery.of(context).size.width,
            maxHeight: 40,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
              child: GestureDetector(
//              onTap: _showModalSheet,
                child: Container(
                  margin: EdgeInsets.only(left: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width * 0.70,
                        child: AutoSizeText(
                          AppLocalizations.of(context).inputAccountNameHintText(),
                          textAlign: TextAlign.left,
                          minFontSize: 10,
                          maxLines: 1,
                          maxFontSize: 20,
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          SvgPicture.asset(
                            ('assets/images/icons/ic_bitcoin.svg'),
                            color: Theme.of(context).textTheme.bodyText1.color,
                            fit: BoxFit.fill,
                            height: 12,
                            width: 12,
                            // height: MediaQuery.of(context).size.height,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.014,
                          ),
                          Text(
                            '0.00',
                            textAlign: TextAlign.right,
                          ),
                        ],
                      ),

                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
    );


    final cardStart = Center(
      child: Card(
        borderOnForeground: false,
        elevation: 16,
        color: Theme.of(context).colorScheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: FusionTheme.borderRadius,
        ),
        margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.35,
          height: 45,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Theme.of(context).colorScheme.surface,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
            child: GestureDetector(
              child:
                  Center(child: Text("${startDate.toLocal()}".split(' ')[0])),
              // onTap: () => _startDateSelect(context),
            ),
          ),
        ),
      ),
    );

    final cardEnd = Center(
      child: Card(
        borderOnForeground: false,
        elevation: 16,
        color: Theme.of(context).colorScheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: FusionTheme.borderRadius,
        ),
        margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
        child: Container(
            width: MediaQuery.of(context).size.width * 0.35,
            height: 45,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Theme.of(context).colorScheme.surface,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
              child: GestureDetector(
                child:
                    Center(child: Text("${endDate.toLocal()}".split(' ')[0])),
                //onTap: () => _endDateSelect(context),
              ),
            )),
      ),
    );

    final labelStartDate = Container(
      alignment: Alignment.topLeft,
      margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
      child: Text(
        "Start Date:",
        style: TextStyle(
          color: (theme.colorScheme.onSurface),
        ),
      ),
    );

    final labelEndDate = Container(
      alignment: Alignment.topLeft,
      margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
      child: Text(
        "End Date:",
        style: TextStyle(
          color: (theme.colorScheme.onSurface),
        ),
      ),
    );

    final buttonResult = Container(
      height: MediaQuery.of(context).size.height * 0.6,
      child: Expanded(
        //Expanded is used so that all the widget get fit into the available screen
        child: ListView.builder(
          itemCount: 8,
          itemBuilder: (context, i) => SizedBox(
            height: 100.0,
            child: Card(
              borderOnForeground: false,
              elevation: 16,
              color: Theme.of(context).colorScheme.surface,
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 0.2, color: Colors.white),
                borderRadius: FusionTheme.borderRadius,
              ),
              margin: const EdgeInsets.only(bottom: 40, top: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(
                    height: 8,
                  ),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(
                          AppLocalizations.of(context)
                              .inputAccountNameHelperText(),
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.3,
                        ),
                        SvgPicture.asset(
                          ('assets/images/icons/ic_bitcoin.svg'),
                          // color: Colors.white,
                          fit: BoxFit.fill,
                          height: 12,
                          width: 12,
                        ),
                        Text(
                          '0.00',
                          textAlign: TextAlign.right,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                        child: Text(
                          '01.01.2020',
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    return FusionScaffold(
      title: AppLocalizations.of(context).toolbarHistoryTitle(),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(
                left: 24.0,
                right: 24.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
//                crossAxisAlignment: Alignment.bottomCenter,
                children: <Widget>[
                  Flexible(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        labelAccount,
                        history,
                      ],
                    ),
                  ),

//                  SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
                  Flexible(
                    flex: 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                labelStartDate,
                                cardStart,
                              ],
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                labelEndDate,
                                cardEnd,
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    flex: 6,
                    child: buttonResult,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//List<bool> numberTruthList = [true, true, true, true, true, true, true];
//Widget _buildRow(BuildContext context) {
//  return Card(
//    borderOnForeground: false,
//    elevation: 16,
//    color: Colors.black,
//    shape: RoundedRectangleBorder(
//      borderRadius: BorderRadius.circular(5.0),
//    ),
//    margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
//    child: Padding(
//      padding: const EdgeInsets.all(3.0),
//      child: ListView.builder(
//        itemCount: 6,
//        itemBuilder: (context, i) {
//          if (numberTruthList[i]) {
//            return ListTile(
//              title: Text("$i"),
//            );
//          }
//        },
//      ),
//    ),
//  );
//}
