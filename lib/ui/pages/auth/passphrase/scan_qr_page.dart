import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fusion_wallet/localizations.dart';

class ScanQrPage extends StatefulWidget {
  static const navId = "/qr/scan";

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ScanQrPageState();
  }
}

class _ScanQrPageState extends State<ScanQrPage> {
  Future scan() async {
    try {
      String barcode = await BarcodeScanner.scan();
      setState(() => this.barcode = barcode);
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          this.barcode = 'The user did not grant the camera permission!';
        });
      } else {
        setState(() => this.barcode = 'Unknown error: $e');
      }
    } on FormatException {
      setState(() => this.barcode =
          'null (User returned using the "back"-button before scanning anything. Result)');
    } catch (e) {
      setState(() => this.barcode = 'Unknown error: $e');
    }
  }

  String barcode = "";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: RaisedButton(
          child: Text(AppLocalizations.of(context).labelScanQr()),
          onPressed: () {
            scan();
          },
        ),
      ),
    );
  }
}
