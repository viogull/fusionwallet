import 'package:barcode_scan/barcode_scan.dart';
import 'package:barcode_scan/model/android_options.dart';
import 'package:barcode_scan/model/scan_options.dart';
import 'package:barcode_scan/platform_wrapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fusion_wallet/localizations.dart';
import 'package:fusion_wallet/ui/components/custom/fusion_button.dart';
import 'package:fusion_wallet/ui/pages/popups/popup_page.dart';

import '../../widgets.dart';

class RecoverAccountPage extends StatefulWidget {
  static const navId = "/auth/recover";
  static const passphrasePattern = "[\w ]{12}";

  @override
  _RecoverAccountState createState() => new _RecoverAccountState();
}

class _RecoverAccountState extends State<RecoverAccountPage> {
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
// ignore: type_annotate_public_apis
  initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      _numberOfCameras = await BarcodeScanner.numberOfCameras;
      setState(() {});
    });
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
          result.rawContent =
              AppLocalizations.of(context).errorCameraRestriction();
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
    // TODO: implement build
    final ThemeData theme = Theme.of(context);

    final logo = SvgPicture.asset(
      ('assets/images/icons/ic_recoverpasswordicon.svg'),
//      placeholderBuilder: (context) => CircularProgressIndicator(),
      height: 100.0,
    );

    final text = Container(
      alignment: Alignment.topLeft,
      margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
      child: Text(
        AppLocalizations.of(context).inputAccountNameHelperText(),
        style: TextStyle(
          color: (theme.colorScheme.onSurface),
        ),
      ),
    );

    final accountName = Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: theme.colorScheme.onPrimary)),
      height: 30.0,
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: TextFormField(
          initialValue: "",
          style: TextStyle(
            color: (theme.colorScheme.onSurface),
          ),
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: AppLocalizations.of(context).inputEditAccountNameHint(),
            labelStyle: TextStyle(
              color: (theme.colorScheme.onSurface),
            ),
          ),
        ),
      ),
    );

    final scanQR = Container(
      height: 300.0,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: theme.primaryColor)),
      child: SizedBox.expand(
        child: TextFormField(
          maxLines: 14,
          initialValue: "",
          //initialValue: '(barcode == null ) ? "hvhvhhhhvvhvhh" : barcode',
          style: TextStyle(
            color: (theme.colorScheme.onSurface),
          ),
          decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: AppLocalizations.of(context)
                  .inputEnterScanPasshpraseHintText(),
              // helperText: barcode,

              hintStyle: TextStyle(
                color: (theme.colorScheme.onSurface),
              ),
              suffixIcon: IconButton(
                  icon: SvgPicture.asset(
                    'assets/images/icons/ic_qrcodescan.svg',
                    height: 35.0,
                  ),
                  onPressed: _scan)),
        ),
      ),
    );

    final button = Container(
      height: 50,
      width: MediaQuery.of(context).size.width,
      child: FusionButton(
          text: AppLocalizations.of(context).buttonVerify(),
          onPressed: () {
            Navigator.of(context).push(new MaterialPageRoute(
                builder: (_) {
                  return PopupDialogWidget(
                      AppLocalizations.of(context).popupPassVerifiedTitle(),
                      "assets/images/icons/ic_taskdone.svg",
                      AppLocalizations.of(context)
                          .popupAccVerificationWelcomeText());
                },
                fullscreenDialog: true));
          }),
    );

    return SafeArea(
        child: FusionScaffold(
      title: AppLocalizations.of(context).toolbarRecoverFromSeedTitle(),
      onBackClicked: (_) {
        Navigator.of(context).pop();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Flexible(
              flex: 4,
              child: logo,
            ),

            SizedBox(
              height: 10,
            ),
            Flexible(
              flex: 2,
              child: text,
            ),

            Flexible(
              flex: 4,
              child: accountName,
            ),

            Flexible(
              flex: 8,
              child: scanQR,
            ),
            SizedBox(
              height: 20,
            ),
//                  SizedBox(height: 30.0),
            LimitedBox(
              maxHeight: 70.0,
            ),
            Flexible(
              flex: 5,
              child: button,
            ),
            SizedBox(
              height: 5,
            ),
          ],
        ),
      ),
    ));
  }
}

//
//class MyCustomAppBar extends StatelessWidget implements PreferredSizeWidget {
//  final double height;
//  final bool defaultAppBar;
//
//  const MyCustomAppBar({
//    Key key,
//    @required this.height,
//    this.defaultAppBar = true,
//  }) : super(key: key);
//
//  @override
//  Widget build(BuildContext context) {
//    final ThemeData theme = Theme.of(context);
//    return Column(children: [
//      Container(
//        child: PlatformAppBar(
//          android: (_) => MaterialAppBarData(
//              backgroundColor: Colors.transparent,
//              elevation: 0,
//              centerTitle: true,
//              leading: IconButton(
//                onPressed: () {
//                  Navigator.pop(context);
//                },
//                icon: LimitedBox(
//                  maxHeight: 24,
//                  maxWidth: 24,
//                  child: SvgPicture.asset(
//                    'assets/images/icons/ic_next.svg',
//                  ),
//                ),
//              ),
//              title: Text(
//                AppLocalizations.of(context).toolbarRecoverFromSeedTitle(),
////                "Recover from Seed",
//                style: TextStyle(
//                  color: Theme.of(context).colorScheme.onSurface,
//                ),
//              )),
//        ),
//      ),
//    ]);
//  }
//
//  @override
//  Size get preferredSize => Size.fromHeight(height);
//}
