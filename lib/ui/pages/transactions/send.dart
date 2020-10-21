import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fusion_wallet/core/models.dart';
import 'package:fusion_wallet/core/models/multisend_request.dart';
import 'package:fusion_wallet/core/models/receivers.dart';
import 'package:fusion_wallet/core/models/send_tx_request.dart';
import 'package:fusion_wallet/localizations.dart';
import 'package:fusion_wallet/ui/components/custom/scaffold.dart';
import 'package:fusion_wallet/ui/pages/transactions/receiver_card.dart';
import 'package:fusion_wallet/ui/theme.dart';

import '../../../inject.dart';
import '../../widgets.dart';



class SendFundsPage extends StatefulWidget {
  static const String navId = "/funds/send";

  @override
  _SendFundsState createState() => _SendFundsState();
}

class _SendFundsState extends State<SendFundsPage> {


  String _selectedCoin;
  int _receiversQty = 1;


  List<TextEditingController> _qtyControllers = [TextEditingController()];
  List<TextEditingController> _addressControllers = [TextEditingController()];



  final log = injector.get<Logger>();



  BoxDecoration formDecoration(BuildContext context) => BoxDecoration(
      borderRadius: FusionTheme.borderRadius,
      border:
          Border.all(color: Theme.of(context).colorScheme.primary, width: 1));

  Widget buildBitcoinEndIcon(
          BuildContext context, String qtyText, MainAxisAlignment alignment) =>
      LimitedBox(
        maxWidth: MediaQuery.of(context).size.width / 10,
        child: Row(
          mainAxisAlignment: alignment,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: SvgPicture.asset(
                ('assets/images/icons/ic_bitcoin.svg'),
                // color: Colors.white,
                fit: BoxFit.fitWidth,
                height: 12,
                width: 12,
              ),
            ),
            Text(
              qtyText,
              style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
              textAlign: TextAlign.right,
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    final log = injector.get<Logger>();
    final theme = Theme.of(context);
    final addressBalances =
        ModalRoute.of(context).settings.arguments as AddressData;
    return FusionScaffold(
      title: AppLocalizations.of(context).toolbarSendTitle(),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(8),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.9,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Flexible(
                flex: 8,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[

                      DropdownSearch<String>(
                        mode: Mode.MENU,
                        maxHeight: 300,
                        showSelectedItem: true,
                        label: AppLocalizations.of(context).labelCoin(),
                        popupBackgroundColor: Theme.of(context).colorScheme.surface,
                        hint: AppLocalizations.of(context).chooseCurrency(),

                        selectedItem: (this._selectedCoin == null)
                            ? ""
                            : this._selectedCoin,
                        items: addressBalances.data.balances
                            .map((e) => e.coin.symbol)
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            this._selectedCoin = value;
                          });
                        },
                        showSearchBox: false,
                        searchBoxDecoration: InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.fromLTRB(12, 12, 8, 0),
                          labelText: AppLocalizations.of(context)
                              .labelConvertCoinHave(),
                        ),
                        popupShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12),
                          ),
                        ),
                      ),
                      buildReceivers(context, addressBalances),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          width: 32,
                          height: 32,
                          margin: const EdgeInsets.only(right: 16, top: 16),
                          child: FloatingActionButton(
                            child: SvgPicture.asset(
                                "assets/images/icons/ic_add.svg",
                                width: 24,
                                height: 24,
                                color: theme.colorScheme.onSecondary,
                                placeholderBuilder: (BuildContext context) =>
                                    Container(
                                        padding: const EdgeInsets.all(2.0),
                                        child:
                                        PlatformCircularProgressIndicator())),
                            mini: true,
                            onPressed: () {
                              if(this._receiversQty < 3) {
                                injector.get<HapticUtil>().success();
                                setState(() {
                                  this._receiversQty ++;
                                  _qtyControllers.add(TextEditingController());
                                  _addressControllers.add(TextEditingController());
                                });
                              }
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Flexible(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ButtonBar(
                    alignment: MainAxisAlignment.center,
                    buttonMinWidth: MediaQuery.of(context).size.width * 0.9,
                    buttonHeight: 50,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: RaisedButton(
                          animationDuration: const Duration(milliseconds: 800),
                          shape: RoundedRectangleBorder(borderRadius: FusionTheme.borderRadius),
                          onPressed: () async {

                            log.d("Starting sending funds operation. Coin -> [$_selectedCoin]. ");
                            log.d("Count of receivers -> $_receiversQty . Iterating...");


                            if(_receiversQty == 1) {
                               log.d(
                                   "Trying send ${this._qtyControllers.first.value.text}  ${this._selectedCoin}  to ${this._addressControllers.first.value.text}");

                               final sendTxRes = await injector
                                   .get<MinterRest>()
                                   .send(
                                       txData: SendTxRequest(
                                           to: this._addressControllers.first.value.text,
                                           value: this._qtyControllers.first.value.text,
                                           mnemonic: StateContainer.of(context)
                                               .selectedAccount
                                               .mnemonic,
                                           coin: this._selectedCoin),
                                       hash: StateContainer.of(context)
                                           .selectedAccount
                                           .hash);
                              log.d("Response Data after sending... ");
                               if (sendTxRes == true) {
                                 FlashHelper.successBar(context,
                                     message: AppLocalizations.of(context)
                                         .flashOperationSuccess());
                                 Future.delayed(Duration(seconds: 1), () {
                                   Navigator.pop(context);
                                 });
                               } else {
                                 FlashHelper.errorBar(context,
                                     message: AppLocalizations.of(context)
                                         .flashOperationFailed());
                               }
                            } else if(_receiversQty > 1) {
                              //TODO Perform multisend

                              List<Receivers> receivers = [];
                              log.d("Building multisend request body");
                              for(var i = 0; i < _receiversQty; i++) {
                                log.d("${_qtyControllers[i].value.text} ${this._selectedCoin} -----> ${_addressControllers[i].value.text}");
                                receivers.add(Receivers(to: _addressControllers[i].value.text,  value: _qtyControllers[i].value.text));
                              }
                              var multisendRequest = MultisendRequest(
                                mnemonic: StateContainer.of(context)
                                    .selectedAccount
                                    .mnemonic,
                                coin: this._selectedCoin,
                                receivers: receivers
                              );
                              final multisendTxRes = await injector
                                  .get<MinterRest>()
                                  .multisend(
                                  request: multisendRequest,
                                  hash: StateContainer.of(context)
                                      .selectedAccount
                                      .hash);
                              log.d("Response Data after sending... ${multisendTxRes}");
                              if (multisendTxRes == true) {
                                FlashHelper.successBar(context,
                                    message: AppLocalizations.of(context)
                                        .flashOperationSuccess());
                                Future.delayed(Duration(seconds: 1), () {
                                  Navigator.pop(context);
                                });
                              } else {
                                FlashHelper.errorBar(context,
                                    message: AppLocalizations.of(context)
                                        .flashOperationFailed());
                              }

                            }

                          },
                          child: Text(
                            AppLocalizations.of(context).buttonSend(),
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.onPrimary),
                          ),
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }



  Widget buildReceivers(BuildContext context, AddressData addressData) {
    return Expanded(
      child: ListView.builder(itemBuilder: (context, index) =>
          ReceiverCard(addressData: addressData, qtyController: _qtyControllers[index], onMinusClicked: () {
            injector.get<HapticUtil>().error();
            if(this._receiversQty > 0){
              setState(() {
                this._receiversQty --;
                this._qtyControllers.removeLast();
                this._addressControllers.removeLast();
              });
            }

          },addressController: _addressControllers[index]),
      itemCount: this._receiversQty,),
    );
  }

  Widget buildTextFieldMaxButton(BuildContext context) => Container(
        width: 32,
        margin: const EdgeInsets.all(4),
        decoration: BoxDecoration(
            borderRadius: FusionTheme.borderRadius,
            border: Border.all(color: Theme.of(context).colorScheme.primary)),
        child: Center(
          child: Text(
            AppLocalizations.of(context)
                .inputMaxAmountSuffix()
                .toString()
                .toUpperCase(),
            style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
          ),
        ),
      );



}
