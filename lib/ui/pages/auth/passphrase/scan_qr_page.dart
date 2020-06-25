import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
//    try {
//      //String barcode = await BarcodeScanner.scan(OverlayTheme.NATRIUM);
//      debugPrint(barcode);
//      setState(() => this.barcode = barcode);
//    } on PlatformException catch
////      if (e.code == BarcodeScanner.CameraAccessDenied) {
////        setState(() {
////          this.barcode = 'The user did not grant the camera permission!';
////        });
////      }
//     else {
//        setState(() => this.barcode = 'Unknown error: $e');
//      }
//    } on FormatException {
//      setState(() => this.barcode =
//          'null (User returned using the "back"-button before scanning anything. Result)');
//    } catch (e) {
//      setState(() => this.barcode = 'Unknown error: $e');
//    }
  }

  String barcode = "";

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    scan();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
