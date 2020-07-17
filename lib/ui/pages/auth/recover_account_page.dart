import 'package:barcode_scan/barcode_scan.dart';
import 'package:barcode_scan/model/android_options.dart';
import 'package:barcode_scan/model/scan_options.dart';
import 'package:barcode_scan/platform_wrapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
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
      margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 24.0),
      child: Text(
        AppLocalizations.of(context).inputAccountNameHelperText(),
        style: TextStyle(
          color: (theme.colorScheme.onSurface),
        ),
      ),
    );

    final accountName = BlocProvider(
      create: (context) => AllFieldsFormBloc(),
      child: Builder(
        builder: (context) {
          final formBloc = BlocProvider.of<AllFieldsFormBloc>(context);

          return FormBlocListener<AllFieldsFormBloc, String, String>(
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: theme.colorScheme.primary),
              ),
              height: 40.0,
              child: Container(
                margin: EdgeInsets.only(left: 24),
                child: TextFieldBlocBuilder(
                  maxLines: 1,
                  textAlign: TextAlign.left,
                  textFieldBloc: formBloc.text1,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(0.0) ,
                    border: OutlineInputBorder(
//                    borderRadius: BorderRadius.zero,
                      borderSide: BorderSide.none,
                      gapPadding: 0.0,
                    ),
                    hintText: AppLocalizations.of(context).inputEditAccountNameHint(),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );


    final scanQR = BlocProvider(
      create: (context) => AllFieldsFormBloc(),
      child: Builder(
        builder: (context) {
          final formBloc = BlocProvider.of<AllFieldsFormBloc>(context);

          return FormBlocListener<AllFieldsFormBloc, String, String>(
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: theme.colorScheme.primary),
              ),
              height: MediaQuery.of(context).size.height * 0.25,
              child: Container(
                margin: EdgeInsets.only(left: 24),
                child: TextFieldBlocBuilder(
                  minLines: 20,
                  maxLines: 35,
                  textAlign: TextAlign.start,
                  textFieldBloc: formBloc.text1,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(0.0) ,
                      border: OutlineInputBorder(
//                    borderRadius: BorderRadius.zero,
                        borderSide: BorderSide.none,
                        gapPadding: 0.0,
                      ),
                      hintText: AppLocalizations.of(context).inputEnterScanPasshpraseHintText(),

                      suffixIcon: IconButton(
                        icon: SvgPicture.asset(
                          'assets/images/icons/ic_qrcodescan.svg',
                          height: 35.0,
                        ),
                        onPressed:  _scan
                      )
                  ),
                ),
              ),
            ),
          );
        },
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

    return FusionScaffold(
      title: AppLocalizations.of(context).toolbarChoosePassTitle(),
      child: Container(
        //width: MediaQuery.of(context).size.width,
        child: Stack(
          //fit: StackFit.passthrough,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(
                left: 24.0,
                right: 24.0,
              ),
//              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[

                  Flexible(
                    flex: 4,
                    child: logo,
                  ),


                  Flexible(
                    flex: 1,
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

                  Flexible(
                    flex: 2,
                    child: button,
                  ),
                  SizedBox(
                    height: 5,
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

class AllFieldsFormBloc extends FormBloc<String, String> {

  final text1 = TextFieldBloc();
  final text2 = TextFieldBloc();




  AllFieldsFormBloc() {
    addFieldBlocs(fieldBlocs: [
      text2,
      text1,
    ]);
  }

  @override
  void onSubmitting() async {
    try {
      await Future<void>.delayed(Duration(milliseconds: 500));

      emitSuccess(canSubmitAgain: true);
    } catch (e) {
      emitFailure();
    }
  }
}