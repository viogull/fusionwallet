import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fusion_wallet/core/models/transanctions_response.dart';
import 'package:fusion_wallet/localizations.dart';
import 'package:fusion_wallet/ui/components/transaction_view.dart';
import 'package:fusion_wallet/ui/theme.dart';

import '../../../inject.dart';
import '../../widgets.dart';

class PopupHistoryPage extends StatefulWidget {
  final String address;
  final DateTime from;
  final DateTime to;

  final String name;

  PopupHistoryPage({this.address, this.from, this.to, this.name});

  static const String navId = '/PopupDialogWidget';
  @override
  _PopupHistoryPageState createState() => new _PopupHistoryPageState();
}

class _PopupHistoryPageState extends State<PopupHistoryPage> {
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  var list;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return FusionScaffold(
        title: AppLocalizations.of(context).toolbarHistoryTitle(),
        child: Center(
          child: FutureBuilder(
              future: injector
                  .get<MinterRest>()
                  .fetchTransactions(address: widget.address),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData) {
                  final txs = (snapshot.data as TransactionsResponse).data;
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 9.0,
                      horizontal: 12.0,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Flexible(
                          flex: 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Container(
                                alignment: Alignment.topLeft,
                                margin: EdgeInsets.symmetric(
                                    vertical: 0.0, horizontal: 9.0),
                                child: Text(
                                  AppLocalizations.of(context).account,
                                  style: TextStyle(
                                    color: (theme.colorScheme.onSurface),
                                  ),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                child: Card(
                                  borderOnForeground: false,
                                  elevation: 16,
                                  color: Theme.of(context).colorScheme.surface,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: FusionTheme.borderRadius,
                                  ),
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 0),
                                  child: LimitedBox(
                                    maxWidth: MediaQuery.of(context).size.width,
                                    maxHeight: 35,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 6, horizontal: 4),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            (widget.name == null)
                                                ? AppLocalizations.of(context)
                                                    .inputAccountNameHintText()
                                                : (widget.name),
                                            textAlign: TextAlign.left,
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.1,
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
                            ],
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05,
                        ),
                        Flexible(
                          flex: 2,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Container(
                                        alignment: Alignment.topLeft,
                                        margin: EdgeInsets.symmetric(
                                            vertical: 0.0, horizontal: 20.0),
                                        child: Text(
                                          AppLocalizations.of(context)
                                              .labelStartDate(),
                                          style: TextStyle(
                                            color:
                                                (theme.colorScheme.onSurface),
                                          ),
                                        ),
                                      ),
                                      Center(
                                        child: Card(
                                          borderOnForeground: false,
                                          elevation: 16,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .surface,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                FusionTheme.borderRadius,
                                          ),
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 0, horizontal: 0),
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.35,
                                            height: 45,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .surface,
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 10,
                                                      horizontal: 8),
                                              child: GestureDetector(
                                                child: Center(
                                                    child: Text(
                                                        "${startDate.toLocal()}"
                                                            .split(' ')[0])),
                                                // onTap: () => _startDateSelect(context),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Container(
                                        alignment: Alignment.topLeft,
                                        margin: EdgeInsets.symmetric(
                                            vertical: 0.0, horizontal: 20.0),
                                        child: Text(
                                          AppLocalizations.of(context)
                                              .labelEndDate(),
                                          style: TextStyle(
                                            color:
                                                (theme.colorScheme.onSurface),
                                          ),
                                        ),
                                      ),
                                      Center(
                                        child: Card(
                                          borderOnForeground: false,
                                          elevation: 16,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .surface,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                FusionTheme.borderRadius,
                                          ),
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 0, horizontal: 0),
                                          child: Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.35,
                                              height: 45,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .surface,
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 6,
                                                        horizontal: 4),
                                                child: GestureDetector(
                                                  child: Center(
                                                      child: Text(
                                                          "${endDate.toLocal()}"
                                                              .split(' ')[0])),
                                                  //onTap: () => _endDateSelect(context),
                                                ),
                                              )),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        Flexible(
                          flex: 6,
                          child: (txs.isNotEmpty)
                              ? Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.6,
                                  child: ListView.builder(
                                      itemCount: txs.length,
                                      itemBuilder: (context, i) =>
                                          TransactionView(
                                            transaction: txs[i],
                                            requestedAddress: widget.address,
                                          )),
                                )
                              : Container(
                                  child: Center(
                                      child: AutoSizeText(
                                          AppLocalizations.of(context)
                                              .transferLoading))),
                        ),
                      ],
                    ),
                  );
                } else
                  return Container(
                      child:
                          Center(child: PlatformCircularProgressIndicator()));
              }),
        ));
  }
}
