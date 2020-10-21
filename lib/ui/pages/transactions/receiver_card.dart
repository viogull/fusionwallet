













import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fusion_wallet/core/models.dart';
import 'package:hive/hive.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../inject.dart';
import '../../../localizations.dart';
import '../../theme.dart';




typedef ReceiverCardCallback = Function();


typedef ReceiverCardAddressCallback = Function(String address);

enum ReceiverCardMode {
  NOT_SELECTED,
  ADDRESS,
  ACCOUNT,
  CONTACT,
  SCAN_QR,
  SELECTED
}


class ReceiverCard extends StatefulWidget {


  final AddressData addressData;
  bool isLast ;
  ReceiverCardCallback onMinusClicked;
  bool isFirst;
  TextEditingController qtyController;
  TextEditingController addressController;


  ReceiverCard({this.addressData, this.qtyController,
    this.isFirst = false,this.isLast = false, this.onMinusClicked, this.addressController});

  @override
  _ReceiverCardState createState ()=> _ReceiverCardState();


}




class _ReceiverCardState extends State<ReceiverCard> {

  final log = injector.get<Logger>();
  String _selectedAddress;
  ReceiverCardMode mode = ReceiverCardMode.NOT_SELECTED;




  List<Contact> _contacts;
  List<Account> _accounts;

  var _numberOfCameras = 0;

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


  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);


    return Container(
      child: Column(
        children: [
          widget.isFirst ? Container() : Align(
            alignment: Alignment.bottomRight,
            child: Container(
              width: 24,
              height: 24,
              margin: const EdgeInsets.only(top: 16),
              child: FloatingActionButton(
                heroTag: 'HeroTag${DateTime.now()}',
                child: SvgPicture.asset(
                    "assets/images/icons/ic_minus.svg",
                    width: 24,
                    height: 24,
                    color: theme.colorScheme.onSecondary,
                    placeholderBuilder: (BuildContext context) =>
                        Container(
                            child:
                            PlatformCircularProgressIndicator())),
                mini: true,
                onPressed: widget.onMinusClicked,
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
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
              keyboardType: TextInputType.numberWithOptions(signed: true, decimal: true),
              controller: widget.qtyController,
              textInputAction: TextInputAction.done,
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
                  ),
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

        ],
      ),
    );
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
            child: TextFormField(
              decoration: InputDecoration(
                  contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  hintText: AppLocalizations.of(context).enterAddress,

                  border: inputBorder(context),
                  enabled: true,
                  suffixIcon: IconButton(
                    icon: Icon(Icons.cancel, color: colors.error, size: 18),
                    onPressed: () {
                      this.setState(() {
                        this.mode = ReceiverCardMode.NOT_SELECTED;
                      });
                    },
                  ),),
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
              controller: widget.addressController,
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
                        builder: (context) {
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
                      widget.addressController.text = _selectedAddress;

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
                        builder: (context) {
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
                      widget.addressController.text = _selectedAddress;
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


  inputBorder(BuildContext context) => OutlineInputBorder(
      gapPadding: 4,
      borderRadius: FusionTheme.borderRadius,
      borderSide: BorderSide(color: Theme.of(context).colorScheme.primary));





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