import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fusion_wallet/localizations.dart';
import 'package:fusion_wallet/theme/fusion_theme.dart';
import 'package:fusion_wallet/ui/components/custom/fusion_button.dart';
import 'package:fusion_wallet/ui/components/custom/fusion_scaffold.dart';
import 'package:fusion_wallet/ui/pages/auth/splash.dart';

class AddContactPage extends StatefulWidget {
  static const String navId = '/contacts/add';
  @override
  _AddContactPageState createState() => new _AddContactPageState();
}

class _AddContactPageState extends State<AddContactPage> {
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
    return FusionScaffold(
        title: AppLocalizations.of(context).toolbarAddContactTitle(),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: BlocProvider(
            create: (context) => AddContactFormBloc(),
            child: Builder(
              builder: (context) {
                final loginFormBloc = context.bloc<AddContactFormBloc>();

                return FormBlocListener<AddContactFormBloc, String, String>(
                  onSubmitting: (context, state) {
                    LoadingDialog.show(context);
                  },
                  onSuccess: (context, state) {
                    LoadingDialog.hide(context);

                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (_) => SuccessScreen()));
                  },
                  onFailure: (context, state) {
                    LoadingDialog.hide(context);

                    Scaffold.of(context).showSnackBar(
                        SnackBar(content: Text(state.failureResponse)));
                  },
                  child: SingleChildScrollView(
                    physics: ClampingScrollPhysics(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 144,
                            height: 144,
                            child: SvgPicture.asset(
                                "assets/images/icons/ic_man.svg"),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFieldBlocBuilder(
                            textFieldBloc: loginFormBloc.accountName,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              labelText:
                                  AppLocalizations.of(context).labelName(),
                            ),
                          ),
                        ),
                        TextFieldBlocBuilder(
                          keyboardType: TextInputType.multiline,
                          textFieldBloc: loginFormBloc.address,
                          maxLines: 4,
                          decoration: InputDecoration(
                              labelText: AppLocalizations.of(context)
                                  .labelAddContactAddress(),
                              suffixIcon: SizedBox(
                                width: 12,
                                height: 12,
                                child: SvgPicture.asset(
                                  "assets/images/icons/ic_qrcodescan.svg",
                                ),
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 24, horizontal: 16),
                          child: FusionButton(
                            onPressed: loginFormBloc.submit,
                            expandedWidth: true,
                            text:
                                AppLocalizations.of(context).buttonAddContact(),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ));
  }
}

class AddContactFormBloc extends FormBloc<String, String> {
  final accountName = TextFieldBloc(
    validators: [
      FieldBlocValidators.required,
    ],
  );

  final address = TextFieldBloc(
    validators: [
      FieldBlocValidators.required,
    ],
  );

  final showSuccessResponse = BooleanFieldBloc();

  AddContactFormBloc() {
    addFieldBlocs(
      fieldBlocs: [
        accountName,
        address,
        showSuccessResponse,
      ],
    );
  }

  @override
  void onSubmitting() async {
    print(accountName.value);
    print(address.value);
    print(showSuccessResponse.value);

    await Future<void>.delayed(Duration(seconds: 1));

    if (showSuccessResponse.value) {
      emitSuccess();
    } else {
      emitFailure(failureResponse: 'This is an awesome error!');
    }
  }
}

class SuccessScreen extends StatelessWidget {
  SuccessScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
          Icon(Icons.tag_faces, size: 100),
          SizedBox(height: 10),
          Text(
            'Success',
            style: TextStyle(fontSize: 54, color: Colors.black),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
          RaisedButton(
            onPressed: () {},
          )
        ])));
  }
}

class LoadingDialog extends StatelessWidget {
  static void show(BuildContext context, {Key key}) => showDialog<void>(
        context: context,
        useRootNavigator: false,
        barrierDismissible: false,
        builder: (_) => LoadingDialog(key: key),
      ).then((_) => FocusScope.of(context).requestFocus(FocusNode()));

  static void hide(BuildContext context) => Navigator.pop(context);

  LoadingDialog({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Center(
        child: Card(
          child: Container(
            width: 80,
            height: 80,
            padding: EdgeInsets.all(12.0),
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
