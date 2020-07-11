import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fusion_wallet/localizations.dart';
import 'package:fusion_wallet/ui/components/custom/fusion_button.dart';
import 'package:fusion_wallet/ui/components/custom/fusion_scaffold.dart';
import 'package:fusion_wallet/ui/pages/auth/passphrase/scan_qr_page.dart';
import 'package:fusion_wallet/ui/pages/popups/popup_page.dart';

//class RecoverFromSeedPage extends StatelessWidget {
//  static const navId = "/auth/recover";
//
//  @override
//  Widget build(BuildContext context) {
//    // TODO: implement build
//    return Container();
//  }
//}

class RecoverAccountPage extends StatefulWidget {
  static const String navId = '/RecaverAccountPage';
  @override
  _RecoverAccountSate createState() => new _RecoverAccountSate();
}

class _RecoverAccountSate extends State<RecoverAccountPage> {
  Future<String> scan() async {
//    try {
//      String barcode = await BarcodeScanner.scan(OverlayTheme.TITANIUM);
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

//  final TextEditingController _textFieldController = TextEditingController();
//  @override
//  void initState() {
//    _textFieldController.text = barcode;
//    super.initState();
//  }

  String barcode = '';

  bool _rememberMeFlag = false;
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    debugPrint('rebild $barcode');


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



    final scanQR1 = Container(
      height: 300.0,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: theme.primaryColor)),
      child: SizedBox.expand(
        child: TextFormField(
          maxLines: 14,
          initialValue: barcode,
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
    );

    final button = Container(
      height: 50,
      width: MediaQuery.of(context).size.width,
      child: FusionButton(AppLocalizations.of(context).buttonVerify(), () {
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
          ],
        ),
      ),
    );
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