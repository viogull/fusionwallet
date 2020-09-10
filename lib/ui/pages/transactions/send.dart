import 'package:barcode_scan/barcode_scan.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fusion_wallet/core/models.dart';
import 'package:fusion_wallet/core/models/send_tx_request.dart';
import 'package:fusion_wallet/core/models/transanctions_response.dart';
import 'package:fusion_wallet/localizations.dart';
import 'package:fusion_wallet/ui/components/custom/scaffold.dart';
import 'package:fusion_wallet/ui/theme.dart';
import 'package:hive/hive.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../inject.dart';
import '../../widgets.dart';

typedef ReceiverCardCallback = Function();

enum ReceiverCardMode {
  NOT_SELECTED,
  ADDRESS,
  ACCOUNT,
  CONTACT,
  SCAN_QR,
  SELECTED
}

class SendFundsPage extends StatefulWidget {
  static const String navId = "/funds/send";

  @override
  _SendFundsState createState() => _SendFundsState();
}

class _SendFundsState extends State<SendFundsPage> {
  String _selectedAddress;
  String _selectedCoin;
  String _selectedQty;

  final _qtyController = TextEditingController();

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
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            AppLocalizations.of(context).labelCoin(),
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.onSurface,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ),
                      DropdownSearch<String>(
                        mode: Mode.MENU,
                        maxHeight: 300,
                        showSelectedItem: true,
                        selectedItem: (this._selectedCoin == null)
                            ? ""
                            : this._selectedCoin,
                        items: addressBalances.data.balances
                            .map((e) => e.coin)
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
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            AppLocalizations.of(context).labelAmount(),
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.onSurface,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Theme(
                        data: ThemeData(
                            primaryColor:
                                Theme.of(context).colorScheme.primary),
                        child: TextFormField(
                          keyboardType: TextInputType.numberWithOptions(
                              signed: false, decimal: true),
                          controller: _qtyController,
                          textInputAction: TextInputAction.next,
                          style: TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onBackground
                                  .withOpacity(0.99)),
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 1),
                              hintText:
                                  AppLocalizations.of(context).enterAmount,
                              border: inputBorder(context),
                              enabledBorder: inputBorder(context)),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            AppLocalizations.of(context).labelTo(),
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.onSurface,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      buildReceiverCard(context),
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
                            onPressed: () {},
                          ),
                        ),
                      ),
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
                      RaisedButton(
                        onPressed: () async {
                          log.d(
                              "Trying send ${this._qtyController.value.text}  ${this._selectedCoin}  to ${this._selectedAddress}");

                          final sendTxRes = await injector
                              .get<MinterRest>()
                              .send(
                                  txData: SendTxRequest(
                                      to: this._selectedAddress,
                                      value: this._qtyController.value.text,
                                      mnemonic: StateContainer.of(context)
                                          .selectedAccount
                                          .mnemonic,
                                      coin: this._selectedCoin),
                                  hash: StateContainer.of(context)
                                      .selectedAccount
                                      .hash);
                          log.d("Response Data after sending... ${sendTxRes}");
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
                        },
                        child: Text(
                          AppLocalizations.of(context).buttonPreview(),
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimary),
                        ),
                        color: Theme.of(context).colorScheme.primary,
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

  inputBorder(BuildContext context) => OutlineInputBorder(
      gapPadding: 4,
      borderRadius: FusionTheme.borderRadius,
      borderSide: BorderSide(color: Theme.of(context).colorScheme.primary));

  ReceiverCardMode mode = ReceiverCardMode.NOT_SELECTED;

  List<Contact> _contacts;
  List<Account> _accounts;

  final _cancelController = TextEditingController(text: "Cancel");
  var _aspectTolerance = 0.00;
  var _numberOfCameras = 0;
  var _selectedCamera = -1;
  var _useAutoFocus = true;
  var _autoEnableFlash = false;
  static final _possibleFormats = BarcodeFormat.values.toList()
    ..removeWhere((e) => e == BarcodeFormat.unknown);
  List<BarcodeFormat> selectedFormats = [..._possibleFormats];
  ScanResult scanResult;

  @override
  void initState() {
    _contacts = Hive.box<Contact>(contactsBox).values.toList();
    _accounts = Hive.box<Account>(accountsBox).values.toList();
    debugPrint("Length ${_accounts.length}");
    if (mode == ReceiverCardMode.SCAN_QR) {
      Future.delayed(Duration.zero, () async {
        _numberOfCameras = await BarcodeScanner.numberOfCameras;
        setState(() {
          this.mode = ReceiverCardMode.SCAN_QR;
        });
      });
    }
    super.initState();
  }

  Future _scan() async {
    try {
      var options = ScanOptions(
        autoEnableFlash: true,
        android: AndroidOptions(
          useAutoFocus: true,
        ),
      );
      var result = await BarcodeScanner.scan(options: options);
      setState(() => scanResult = result);
    } on PlatformException catch (e) {
      var result = ScanResult(
        type: ResultType.Error,
        format: BarcodeFormat.unknown,
      );
      if (e.code == BarcodeScanner.cameraAccessDenied) {
        setState(() {
          result.rawContent = 'The user did not grant the camera permission!';
        });
      } else {
        result.rawContent = 'Unknown error: $e';
      }
      setState(() {
        scanResult = result;
      });
    }
  }

  Widget buildReceiverCard(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    // TODO: implement build
    switch (mode) {
      case ReceiverCardMode.ADDRESS:
        {
          return Theme(
            data:
                ThemeData(primaryColor: Theme.of(context).colorScheme.primary),
            child: TextField(
              decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  hintText: AppLocalizations.of(context).enterAddress,
                  hintStyle:
                      TextStyle(color: colors.onBackground.withOpacity(0.7)),
                  border: inputBorder(context),
                  enabled: true,
                  suffixIcon: IconButton(
                    icon: Icon(Icons.cancel, color: colors.error, size: 18),
                    onPressed: () {
                      this.setState(() {
                        this.mode = ReceiverCardMode.NOT_SELECTED;
                      });
                    },
                  ),
                  enabledBorder: inputBorder(context)),
            ),
          );
        }
      case ReceiverCardMode.SCAN_QR:
        {
          return Theme(
            data:
                ThemeData(primaryColor: Theme.of(context).colorScheme.primary),
            child: TextFormField(
              initialValue: this.scanResult.rawContent,
              style: TextStyle(color: colors.onBackground.withOpacity(0.7)),
              decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  hintText: AppLocalizations.of(context).enterAddress,
                  hintStyle:
                      TextStyle(color: colors.onBackground.withOpacity(0.7)),
                  border: inputBorder(context),
                  enabled: true,
                  suffixIcon: IconButton(
                    icon: Icon(Icons.cancel, color: colors.error, size: 18),
                    onPressed: () {
                      this.setState(() {
                        this.mode = ReceiverCardMode.NOT_SELECTED;
                      });
                    },
                  ),
                  enabledBorder: inputBorder(context)),
            ),
          );
        }
      case ReceiverCardMode.SELECTED:
        {
          return Theme(
            data:
                ThemeData(primaryColor: Theme.of(context).colorScheme.primary),
            child: TextFormField(
              initialValue: _selectedAddress,
              style: TextStyle(color: colors.onBackground.withOpacity(0.7)),
              decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  hintText: AppLocalizations.of(context).enterAddress,
                  hintStyle:
                      TextStyle(color: colors.onBackground.withOpacity(0.7)),
                  border: inputBorder(context),
                  enabled: true,
                  suffixIcon: IconButton(
                    icon: Icon(Icons.cancel,
                        color: Theme.of(context).colorScheme.onBackground,
                        size: 18),
                    onPressed: () {
                      this.setState(() {
                        this.mode = ReceiverCardMode.NOT_SELECTED;
                      });
                    },
                  ),
                  enabledBorder: inputBorder(context)),
            ),
          );
        }
        break;
      default:
        {
          return Row(
            children: <Widget>[
              buildReceiverCardItem(
                  context: context,
                  label: AppLocalizations.of(context).labelAddress(),
                  icon: "assets/images/icons/ic_add.svg",
                  onPressed: () {
                    setState(() {
                      this.mode = ReceiverCardMode.ADDRESS;
                    });
                  }),
              buildReceiverCardItem(
                  context: context,
                  label: AppLocalizations.of(context).labelMyContacts(),
                  icon: "assets/images/icons/ic_contacts.svg",
                  onPressed: () async {
                    final modalAddressSelection = await showBarModalBottomSheet(
                        context: context,
                        backgroundColor: colors.background,
                        builder: (context, controller) {
                          return Material(
                            child: CupertinoPageScaffold(
                              backgroundColor: colors.background,
                              navigationBar: CupertinoNavigationBar(
                                backgroundColor: colors.background,
                                leading: SvgPicture.asset(
                                    "assets/images/icons/ic_contacts.svg"),
                                middle: Text(
                                  AppLocalizations.of(context)
                                      .chooseContactTitle(),
                                  style: TextStyle(color: colors.onBackground),
                                ),
                              ),
                              child: SafeArea(
                                bottom: false,
                                child: ListView.builder(
                                  reverse: false,
                                  shrinkWrap: true,
                                  physics: ClampingScrollPhysics(),
                                  controller: controller,
                                  itemCount: _contacts.length,
                                  itemBuilder: (context, index) => ListTile(
                                    title: Text(_contacts[index].name),
                                    subtitle: Text(_contacts[index].address),
                                    onTap: () {
                                      Navigator.of(context)
                                          .pop(_contacts[index].address);
                                    },
                                  ),
                                ),
                              ),
                            ),
                          );
                        });
                    setState(() {
                      this.mode = ReceiverCardMode.SELECTED;
                      this._selectedAddress = modalAddressSelection as String;
                    });
                  }),
              buildReceiverCardItem(
                  context: context,
                  label: AppLocalizations.of(context).labelAccount(),
                  icon: "assets/images/icons/ic_accounts.svg",
                  onPressed: () async {
                    final modalAddressSelection = await showBarModalBottomSheet(
                        context: context,
                        backgroundColor: colors.background,
                        builder: (context, controller) {
                          return Material(
                            child: CupertinoPageScaffold(
                              backgroundColor: colors.background,
                              navigationBar: CupertinoNavigationBar(
                                backgroundColor: colors.background,
                                leading: SvgPicture.asset(
                                    "assets/images/icons/ic_contacts.svg"),
                                middle: Text(
                                  AppLocalizations.of(context)
                                      .chooseAccountTitle(),
                                  style: TextStyle(color: colors.onBackground),
                                ),
                              ),
                              child: SafeArea(
                                bottom: false,
                                child: ListView.builder(
                                  reverse: false,
                                  shrinkWrap: true,
                                  physics: ClampingScrollPhysics(),
                                  controller: controller,
                                  itemCount: _accounts.length,
                                  itemBuilder: (context, index) => ListTile(
                                    title: Text(_accounts[index].address == null
                                        ? ""
                                        : _accounts[index].address),
                                    onTap: () {
                                      Navigator.of(context)
                                          .pop(_accounts[index].address);
                                    },
                                  ),
                                ),
                              ),
                            ),
                          );
                        });
                    setState(() {
                      this.mode = ReceiverCardMode.SELECTED;
                      this._selectedAddress = modalAddressSelection as String;
                    });
                  }),
              buildReceiverCardItem(
                  context: context,
                  label: AppLocalizations.of(context).labelScanQr(),
                  icon: "assets/images/icons/ic_qr.svg",
                  onPressed: () async {
                    await _scan();
                  }),
            ],
          );
        }
        break;
    }
  }

  Widget buildReceiverCardItem(
          {BuildContext context,
          String label,
          String icon,
          ReceiverCardCallback onPressed}) =>
      Flexible(
        flex: 1,
        child: GestureDetector(
          onTap: () {
            onPressed();
          },
          child: Center(
            child: Card(
              margin: const EdgeInsets.all(4),
              elevation: 0,
              color: Theme.of(context).colorScheme.surface,
              shape: RoundedRectangleBorder(
                  borderRadius: FusionTheme.borderRadius,
                  side:
                      BorderSide(color: Theme.of(context).colorScheme.primary)),
              child: Container(
                width: MediaQuery.of(context).size.width / 5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    SvgPicture.asset(
                      icon,
                      color: Theme.of(context).colorScheme.primary,
                      width: 24,
                      height: 24,
                      fit: BoxFit.scaleDown,
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(label,
                            style: TextStyle(fontSize: 10), maxLines: 1),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}
