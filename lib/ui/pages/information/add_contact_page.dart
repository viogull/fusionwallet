import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fusion_wallet/localizations.dart';
import 'package:fusion_wallet/ui/components/custom/fusion_button.dart';
import 'package:fusion_wallet/ui/components/custom/fusion_scaffold.dart';
import 'package:fusion_wallet/ui/pages/auth/passphrase/scan_qr_page.dart';

class AddContactPage extends StatefulWidget {
  static const String navId = '/AddContactPage';
  @override
  _AddContactPageState createState() => new _AddContactPageState();
}

class _AddContactPageState extends State<AddContactPage> {
  Future<String> scan() async {
//    try {
//      String barcode = await BarcodeScanner.scan(OverlayTheme.BLAISE);
//      debugPrint(barcode);
//      return barcode;
//    } on PlatformException catch (e) {
//      if (e.code == BarcodeScanner.CameraAccessDenied) {
//        setState(() {
//          this.barcode = 'The user did not grant the camera permission!';
//        });
//      } else {
//        return null;
//      }
//    } on FormatException {
//      setState(() => this.barcode =
//          'null (User returned using the "back"-button before scanning anything. Result)');
//    } catch (e) {
//      return null;
//    }
  }

  String barcode = '';
  bool _rememberMeFlag = false;
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    debugPrint('rebild $barcode');


    final logo = Container(
      height: 130,
      child: SvgPicture.asset(
        ('assets/images/icons/ic_man.svg'),
        placeholderBuilder: (context) => CircularProgressIndicator(),
        height: 90.0,
      ),
    );

    final ellipse = Padding(
      padding: EdgeInsets.fromLTRB(65, 0, 10, 50),
      child: SvgPicture.asset(
        ('assets/images/icons/ic_ellipse19.svg'),
        placeholderBuilder: (context) => CircularProgressIndicator(),
        height: 40.0,
      ),
    );

    final text = Container(
      alignment: Alignment.topLeft,
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      child: Text(
        AppLocalizations.of(context).labelAddContactName(),
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
              child: Center(

                child: TextFieldBlocBuilder(
                  maxLines: 1,
                  textAlign: TextAlign.left,
                  textFieldBloc: formBloc.text2,
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


    final label = Container(
      alignment: Alignment.topLeft,
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      child: Text(
        AppLocalizations.of(context).labelAddContactAddress(),
        style: TextStyle(
          color: (theme.colorScheme.onSurface),
        ),
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
              height: MediaQuery.of(context).size.height * 0.20,
              child: Container(
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
                      hintText: AppLocalizations.of(context).inputAddContactAddressHint(),

                      suffixIcon: IconButton(
                        icon: SvgPicture.asset(
                          'assets/images/icons/ic_qrcodescan.svg',
                          height: 35.0,
                        ),
                        onPressed: () async {
                          var barcode = await scan();
                          setState(() {
                            this.barcode = barcode;
                          });
                          debugPrint(barcode);

                          Navigator.pushNamed(context, ScanQrPage.navId);
                        },
                      )
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );



    final menuLabel = Container(
      alignment: Alignment.topLeft,
      margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
      child: Text(
        AppLocalizations.of(context).menuItemEditAccountName(),
        style: TextStyle(
          color: (theme.colorScheme.onSurface),
        ),
      ),
    );

    final accountNameLabel = Container(
      alignment: Alignment.topLeft,
      margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 40.0),
      child: Text(
        AppLocalizations.of(context).inputAccountNameHelperText(),
        style: TextStyle(
          color: (theme.colorScheme.onSurface),
        ),
      ),
    );

    final textField = Container(
      margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 24.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: theme.colorScheme.primary),
      ),
      height: 40.0,
      child: Center(
        child: TextField(
          style: TextStyle(
            color: (theme.colorScheme.onSurface),
          ),
          // obscureText: true,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: AppLocalizations.of(context).inputAccountNameHintText(),
            labelStyle: TextStyle(
              color: (theme.colorScheme.onSurface),
            ),
          ),
        ),
      ),
    );

    final save = Container(
      alignment: Alignment.topRight,
      margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Text(
          AppLocalizations.of(context).labelSave(),
          style: TextStyle(
            color: (theme.colorScheme.onSurface),
          ),
        ),
      ),
    );

    final loginButton = Container(
      height: 50,
      width: MediaQuery.of(context).size.width,
      child: FusionButton(AppLocalizations.of(context).buttonAddContact(), () {
//        Navigator.pushNamed(context, PopupEditAccountName.navId);
        // var dialogWigth = MediaQuery.of(context).size.width;
        showGeneralDialog(
            barrierColor: Colors.grey.withOpacity(0.5),
            context: context,
            barrierDismissible: true,
            barrierLabel:
                MaterialLocalizations.of(context).modalBarrierDismissLabel,
            transitionDuration: const Duration(milliseconds: 200),
            pageBuilder: (BuildContext buildContext, Animation animation,
                Animation secondaryAnimation) {
              return Center(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.28,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: theme.colorScheme.primary),
                  ),
                  child: Material(
                    color: Theme.of(context).colorScheme.surface,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            border: Border(
                                bottom:
                                    BorderSide(width: 1, color: Colors.grey)),
                          ),
                          padding: EdgeInsets.only(bottom: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              menuLabel,
                              save,
                            ],
                          ),
                        ),
                        accountNameLabel,
                        textField,
                        SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            });
      }),
    );

    return FusionScaffold(
      title: AppLocalizations.of(context).toolbarAddContactTitle(),
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(
                left: 24.0,
                right: 24.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Flexible(
                    flex: 4,
                    child: Stack(
                      children: <Widget>[logo, ellipse],
                    ),
                  ),
//

                  Flexible(
                    flex: 2,

                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        text,
                        accountName,
                      ],
                    ),
                  ),
                  Flexible(
                    flex: 3,

                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        label,
                        scanQR,
                      ],
                    ),
                  ),



                  Flexible(
                    flex: 1,
                    child: loginButton,
                  ),
                  SizedBox(height: 5.0),
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