import 'package:barcode_scan/barcode_scan.dart';
import 'package:barcode_scan/model/android_options.dart';
import 'package:barcode_scan/model/scan_options.dart';
import 'package:barcode_scan/platform_wrapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_bloc/form_bloc.dart';
import 'package:fusion_wallet/core/minter_rest.dart';
import 'package:fusion_wallet/localizations.dart';
import 'package:fusion_wallet/ui/components/custom/fusion_button.dart';
import 'package:fusion_wallet/utils/validators.dart';

import '../../../inject.dart';
import '../../widgets.dart';

class RecoverAccountBloc extends FormBloc<String, String> {
  final nameTextBloc = TextFieldBloc(
    validators: [
      FieldBlocValidators.required,
    ],
  );

  final mnemonicTextBloc = TextFieldBloc(
    validators: [
      FieldBlocValidators.required,
    ],
  );

  AddContactFormBloc() {
    addFieldBlocs(
      fieldBlocs: [
        nameTextBloc,
        mnemonicTextBloc,
      ],
    );
  }

  @override
  void onSubmitting() async {
    print(nameTextBloc.value);
    print(mnemonicTextBloc.value);

    try {
      if (this.nameTextBloc.value != null && mnemonicTextBloc.value != null) {
        debugPrint("Checking current account contacts");
        emitLoading();
        final recoverRequest = await injector
            .get<MinterRest>()
            .recover(nameTextBloc.value, mnemonicTextBloc.value);

        this.emitSuccess();
      }
    } on Exception catch (e) {
      emitFailure();
    }
  }
}

class RecoverAccountPage extends StatefulWidget {
  static const navId = "/auth/recover";
  static const passphrasePattern = "[\w ]{12}";

  @override
  _RecoverAccountState createState() => new _RecoverAccountState();
}

class _RecoverAccountState extends State<RecoverAccountPage> {
  ScanResult scanResult;
  List<BarcodeFormat> selectedFormats = [..._possibleFormats];
  String _scannedQrData;

  final inputController = TextEditingController();

  static final _possibleFormats = BarcodeFormat.values.toList()
    ..removeWhere((e) => e == BarcodeFormat.unknown);

  Future _scan() async {
    try {
      var result = await BarcodeScanner.scan();

      if (result != null) {
        debugPrint("Received data ${result.rawContent}");
        setState(() {
          this._scannedQrData = result.rawContent;
        });
      }
    } on PlatformException catch (e) {
      var result = ScanResult(
        type: ResultType.Error,
        format: BarcodeFormat.unknown,
      );
      if (e.code == BarcodeScanner.cameraAccessDenied) {
      } else {
        result.rawContent = 'Unknown error: $e';
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    debugPrint("Building recover page, initial data -> ${this._scannedQrData}");
    inputController.text = this._scannedQrData;
    return SafeArea(
        child: FusionScaffold(
      title: AppLocalizations.of(context).toolbarRecoverFromSeedTitle(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Flexible(
                flex: 4,
                child: SvgPicture.asset(
                  ('assets/images/icons/ic_recoverpasswordicon.svg'),
                  placeholderBuilder: (context) => CircularProgressIndicator(),
                  height: 100.0,
                )),

            SizedBox(
              height: 10,
            ),
            Flexible(
              flex: 2,
              child: Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
                child: Text(
                  AppLocalizations.of(context).inputAccountNameHelperText(),
                  style: TextStyle(
                    color: (theme.colorScheme.onSurface),
                  ),
                ),
              ),
            ),

            Flexible(
              flex: 4,
              child: Container(
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
                      labelText: AppLocalizations.of(context)
                          .inputEditAccountNameHint(),
                      labelStyle: TextStyle(
                        color: (theme.colorScheme.onSurface),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            Flexible(
              flex: 8,
              child: Container(
                height: 300.0,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: theme.primaryColor)),
                child: SizedBox.expand(
                  child: TextFormField(
                    controller: inputController,
                    maxLines: 14,
                    style: TextStyle(
                      color: (theme.colorScheme.onSurface),
                    ),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: this._scannedQrData == null
                            ? AppLocalizations.of(context)
                                .inputEnterScanPasshpraseHintText()
                            : "",
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
              ),
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
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: FusionButton(
                    text: AppLocalizations.of(context).buttonVerify(),
                    onPressed: () {}),
              ),
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
