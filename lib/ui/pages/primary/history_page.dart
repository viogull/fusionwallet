import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fusion_wallet/localizations.dart';
import 'package:fusion_wallet/theme/fusion_theme.dart';
import 'package:fusion_wallet/ui/components/custom/fusion_button.dart';
import 'package:fusion_wallet/ui/pages/popups/popups_history_page.dart';

class HistoryPage extends StatefulWidget {
  static const String navId = '/HistoryPage';
  @override
  _HistoryPageState createState() => new _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();

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
    //DateTime selectedDate = DateTime.now();

    void _showModalSheet() {
      showModalBottomSheet(
          context: context,
          builder: (builder) {
            return new Container(
              color: Theme.of(context).colorScheme.surface,
              child: Expanded(
                //Expanded is used so that all the widget get fit into the available screen
                child: ListView.builder(
                  itemCount: 8,
                  itemBuilder: (context, i) => SizedBox(
                    height: 75.0,
                    child: Container(
//                      width: MediaQuery.of(context).size.width * 0.8,
                      decoration: BoxDecoration(
                        border: Border(
                            // top: BorderSide(width: 1, color: Colors.white),
                            bottom: BorderSide(width: 2, color: Colors.white)),
                      ),
                      margin: const EdgeInsets.only(
                          bottom: 10, top: 30, left: 22, right: 22),
                      child: Column(
//                        crossAxisAlignment: CrossAxisAlignment.,
//                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          SizedBox(
                            height: 8,
                          ),
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  AppLocalizations.of(context)
                                      .inputAccountNameHelperText(),
                                  textAlign: TextAlign.left,
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.3,
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
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          });
    }

    final background = SvgPicture.asset(
      ('assets/images/backgrounds/bg_primary.svg'),
      fit: BoxFit.fill,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
    );

    final labelAccount = Container(
      alignment: Alignment.topLeft,
      margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
      child: Text(
        'Account',
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
          maxHeight: 35,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
            child: GestureDetector(
              onTap: _showModalSheet,
              child: Row(
                children: <Widget>[
                  Text(
                    AppLocalizations.of(context).inputAccountNameHintText(),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.1,
                  ),
                  SvgPicture.asset(
                    ('assets/images/icons/ic_bitcoin.svg'),
                    // color: Colors.white,
                    fit: BoxFit.fill,
                    height: 12,
                    width: 12,
                    // height: MediaQuery.of(context).size.height,
                  ),
                  SizedBox(
                    width: 7,
                  ),
                  Text(
                    '0.00',
                    textAlign: TextAlign.right,
                  ),
                ],
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
              onTap: () => _startDateSelect(context),
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
                onTap: () => _endDateSelect(context),
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
      height: 50,
      width: MediaQuery.of(context).size.width,
      child: FusionButton(
        AppLocalizations.of(context).buttonViewResults(),
        () {
          Navigator.pushNamed(context, PopupHistoryPage.navId);
        },
      ),
    );

    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: <Widget>[
          background,
          Container(
            padding: EdgeInsets.only(
              left: 24.0,
              right: 24.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              // mainAxisSize: MainAxisSize.min,
//                crossAxisAlignment: Alignment.bottomCenter,
              children: <Widget>[
//                  SizedBox(height: 20,),
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
                  flex: 3,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.20,
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: buttonResult,
                ),
                SizedBox(
                  height: 45,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
