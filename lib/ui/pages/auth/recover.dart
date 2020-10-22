import 'dart:convert';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:barcode_scan/platform_wrapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_bloc/form_bloc.dart';
import 'package:fusion_wallet/core/minter_rest.dart';
import 'package:fusion_wallet/core/models/recover_response.dart';
import 'package:fusion_wallet/localizations.dart';
import 'package:fusion_wallet/ui/components/custom/button.dart';

import '../../../inject.dart';
import '../../widgets.dart';
import '../pages.dart';
import 'event.dart';

class RecoverAccountBloc extends FormBloc<String, String> {
  final AppLocalizations localizations;

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

  RecoverAccountBloc({this.localizations}) {
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
        final recovery = await injector
            .get<MinterRest>()
            .canRecover(nameTextBloc.value, mnemonicTextBloc.value);

        debugPrint("Can recover -> ${recovery.toString()}");
        if (recovery.restore)
          this.emitSuccess(successResponse: json.encode(recovery));
        else
          this.emitFailure(
              failureResponse: localizations.cannotRecoverAccount());
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
  String _scannedQrData =  "occur lunar grit evil fun urban fuel aspect door hair hammer inside";

  static final _possibleFormats = BarcodeFormat.values.toList()
    ..removeWhere((e) => e == BarcodeFormat.unknown);

  void _nextRecoveryStage(BuildContext context, {dynamic profile}) {
    BlocProvider.of<AuthenticationBloc>(context).add(
        AccountCompleteRecoverEvent(
            profile: RecoverResponse.fromJson(profile)));
  }

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

    return BlocProvider(
      create: (context) => RecoverAccountBloc(),
      child: Builder(
        builder: (context) {
          final bloc = context.bloc<RecoverAccountBloc>();
          if (this._scannedQrData.isNotEmpty) {
            bloc.mnemonicTextBloc.updateInitialValue(this._scannedQrData);
          }
          return FormBlocListener<RecoverAccountBloc, String, String>(
              onLoading: (context, state) {
                // BlocLoader.show(context);
              },
              onSuccess: (context, state) {
                //  BlocLoader.hide(context);
                final rec = json.decode(state.successResponse);

                _nextRecoveryStage(context, profile: rec);

              },
              onFailure: (context, state) {
                //   BlocLoader.hide(context);

                Scaffold.of(context).showSnackBar(
                    SnackBar(content: Text(state.failureResponse)));
              },
              child: FusionScaffold(
                title:
                AppLocalizations.of(context).toolbarRecoverFromSeedTitle(),
                appBarIcon: IconButton(
                  icon: Icon(Icons.arrow_back,
                      color: Theme.of(context).colorScheme.primary),
                  onPressed: () {
                    BlocProvider.of<AuthenticationBloc>(context)
                        .add(AccountInitialEvent());
                  },
                ),
                child: Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Flexible(
                          flex: 4,
                          child: SvgPicture.asset(
                            ('assets/images/icons/ic_recoverpasswordicon.svg'),
                            placeholderBuilder: (context) =>
                                CircularProgressIndicator(),
                            height: 100.0,
                          )),

                      SizedBox(
                        height: 10,
                      ),

                      Flexible(
                          flex: 4,
                          child: Center(
                              child: TextFieldBlocBuilder(
                                  textFieldBloc: bloc.nameTextBloc,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: AppLocalizations.of(context)
                                        .inputAccountNameHelperText(),
                                    labelStyle: TextStyle(
                                      color: (theme.colorScheme.onSurface),
                                    ),
                                  )))),
                      Flexible(
                        flex: 8,
                        child: Container(
                          height: 300.0,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: theme.primaryColor)),
                          child: SizedBox.expand(
                            child: TextFieldBlocBuilder(
                              textFieldBloc: bloc.mnemonicTextBloc,
                              textInputAction: TextInputAction.done,
                              animateWhenCanShow: true,
                              maxLines: 14,
                              enableSuggestions: true,
                              enableInteractiveSelection: true,
                              showSuggestionsWhenIsEmpty: true,
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
                          width: MediaQuery.of(context).size.width,
                          child: FusionButton(
                              text: AppLocalizations.of(context).buttonVerify(),
                              onPressed: () {
                                debugPrint("Tapped on submit");
                                bloc.submit();
                              }),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ),
              ));
        },
      ),
    );
  }
}
