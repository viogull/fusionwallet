import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fusion_wallet/localizations.dart';
import 'package:fusion_wallet/ui/theme.dart';
import 'package:fusion_wallet/ui/components/custom/fusion_button.dart';
import 'package:fusion_wallet/ui/pages/popups/popups_history_page.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../inject.dart';

class HistoryPage extends StatefulWidget {
  static const String navId = '/HistoryPage';
  @override
  _HistoryPageState createState() => new _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  String _selectedAccount;

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

    final colors = Theme.of(context).colorScheme;
    final allAccounts = injector.get<Vault>().getAllAccounts();
    allAccounts.forEach((acc) {
      debugPrint("Account ${acc.name}, ${acc.address}, ${acc.hash}");
    });
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Container(
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
                  Container(
                    alignment: Alignment.topLeft,
                    margin:
                        EdgeInsets.symmetric(vertical: 0.0, horizontal: 8.0),
                    child: Text(
                      AppLocalizations.of(context).labelAccount(),
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
                          vertical: 0, horizontal: 8),
                      child: LimitedBox(
                        maxWidth: MediaQuery.of(context).size.width,
                        maxHeight: 35,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 6, horizontal: 4),
                          child: GestureDetector(
                            onTap: () async {
                              final modalAddressSelection =
                                  await showBarModalBottomSheet(
                                      context: context,
                                      backgroundColor: colors.background,
                                      builder: (context, controller) {
                                        return Material(
                                          child: CupertinoPageScaffold(
                                            backgroundColor: colors.background,
                                            navigationBar:
                                                CupertinoNavigationBar(
                                              backgroundColor:
                                                  Colors.transparent,
                                              automaticallyImplyLeading: false,
                                              middle: Text(
                                                  AppLocalizations.of(context)
                                                      .chooseAccountTitle(),
                                                  style: TextStyle(
                                                      color: theme.colorScheme
                                                          .onBackground)),
                                            ),
                                            child: SafeArea(
                                              bottom: false,
                                              child: ListView.builder(
                                                reverse: false,
                                                shrinkWrap: true,
                                                physics:
                                                    ClampingScrollPhysics(),
                                                controller: controller,
                                                itemCount: allAccounts.length,
                                                itemBuilder: (context, index) =>
                                                    ListTile(
                                                  title: AutoSizeText(
                                                      allAccounts[index].name ==
                                                              null
                                                          ? allAccounts[index]
                                                              .seed
                                                          : allAccounts[index]
                                                              .name),
                                                  subtitle: AutoSizeText("" +
                                                      (allAccounts[index]
                                                                  .address ==
                                                              null
                                                          ? ""
                                                          : allAccounts[index]
                                                              .address)),
                                                  onTap: () {
                                                    Navigator.of(context).pop(
                                                        allAccounts[index]
                                                            .name);
                                                  },
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      });
                              setState(() {
                                this._selectedAccount =
                                    modalAddressSelection as String;
                              });
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Flexible(
                                  flex: 5,
                                  child: AutoSizeText(
                                    (this._selectedAccount == null)
                                        ? AppLocalizations.of(context)
                                            .inputAccountNameHintText()
                                        : this._selectedAccount,
                                    textAlign: TextAlign.left,
                                    minFontSize: 10,
                                    maxFontSize: 12,
                                  ),
                                ),
                                Flexible(
                                    flex: 5,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
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
                                        )
                                      ],
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
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
                          Container(
                            alignment: Alignment.topLeft,
                            margin: EdgeInsets.symmetric(
                                vertical: 0.0, horizontal: 20.0),
                            child: Text(
                              AppLocalizations.of(context).labelStartDate(),
                              style: TextStyle(
                                color: (theme.colorScheme.onSurface),
                              ),
                            ),
                          ),
                          Center(
                            child: Card(
                              borderOnForeground: false,
                              elevation: 16,
                              color: Theme.of(context).colorScheme.surface,
                              shape: RoundedRectangleBorder(
                                borderRadius: FusionTheme.borderRadius,
                              ),
                              margin: const EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 0),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.35,
                                height: 45,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Theme.of(context).colorScheme.surface,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 8),
                                  child: GestureDetector(
                                    child: Center(
                                        child: Text("${startDate.toLocal()}"
                                            .split(' ')[0])),
                                    onTap: () => _startDateSelect(context),
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
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
                            alignment: Alignment.topLeft,
                            margin: EdgeInsets.symmetric(
                                vertical: 0.0, horizontal: 20.0),
                            child: Text(
                              AppLocalizations.of(context).labelEndDate(),
                              style: TextStyle(
                                color: (theme.colorScheme.onSurface),
                              ),
                            ),
                          ),
                          Center(
                            child: Card(
                              borderOnForeground: false,
                              elevation: 16,
                              color: Theme.of(context).colorScheme.surface,
                              shape: RoundedRectangleBorder(
                                borderRadius: FusionTheme.borderRadius,
                              ),
                              margin: const EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 0),
                              child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.35,
                                  height: 45,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color:
                                        Theme.of(context).colorScheme.surface,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 6, horizontal: 4),
                                    child: GestureDetector(
                                      child: Center(
                                          child: Text("${endDate.toLocal()}"
                                              .split(' ')[0])),
                                      onTap: () => _endDateSelect(context),
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
              flex: 3,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.20,
              ),
            ),
            Flexible(
              flex: 1,
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: FusionButton(
                  text: AppLocalizations.of(context).buttonViewResults(),
                  onPressed: () async {
                    debugPrint(
                        "Requesting history for ${this._selectedAccount} , startDate ${this.startDate.toIso8601String()} to ${this.endDate.toIso8601String()}");

                    Navigator.of(context).push(new MaterialPageRoute(
                        builder: (context) {
                          return PopupHistoryPage(
                              address: injector
                                  .get<Vault>()
                                  .getAllAccounts()
                                  .firstWhere((element) =>
                                      element.name == this._selectedAccount)
                                  .address,
                              name: this._selectedAccount,
                              from: this.startDate,
                              to: this.endDate);
                          ;
                        },
                        fullscreenDialog: true));
                  },
                ),
              ),
            ),
            SizedBox(
              height: 45,
            ),
          ],
        ),
      ),
    );
  }
}
