import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fusion_wallet/localizations.dart';
import 'package:fusion_wallet/ui/components/custom/fusion_button.dart';
import 'package:fusion_wallet/ui/pages/auth/terms_conditions_page.dart';
import 'package:fusion_wallet/ui/pages/popups/edit_account_name_page.dart';
import 'package:fusion_wallet/ui/theme/fusion_theme.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter/services.dart';

class AddContactPage extends StatefulWidget {
  static const String navId = '/AddContactPage';
  @override
  _AddContactPageState createState() => new _AddContactPageState();
}

class _AddContactPageState extends State<AddContactPage> {
  Future<String> scan() async {
    try {
      String barcode = await BarcodeScanner.scan();
      debugPrint(barcode);
      return barcode;
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          this.barcode = 'The user did not grant the camera permission!';
        });
      } else {
        return null;
      }
    } on FormatException {
      setState(() => this.barcode =
          'null (User returned using the "back"-button before scanning anything. Result)');
    } catch (e) {
      return null;
    }
  }

  String barcode = '';
  bool _rememberMeFlag = false;
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    debugPrint('rebild $barcode');

    final background = SvgPicture.asset(
      ('assets/images/backgrounds/bg_primary.svg'),
      fit: BoxFit.fill,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
    );

    final logo = Container(
      height: 130,
      child: SvgPicture.asset(
        ('assets/images/icons/ic_man.svg'),
        placeholderBuilder: (context) => CircularProgressIndicator(),
        height: 90.0,
      ),
    );


    final ellipse =
    Padding(
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

    final email = Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: theme.colorScheme.primary),
      ),
      height: 30.0,
      child: Center(
        child: TextField(
          style: TextStyle(
            color: (theme.colorScheme.onSurface),
          ),
          // obscureText: true,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: AppLocalizations.of(context).inputAddContactNameHint(),
            labelStyle: TextStyle(
              color: (theme.colorScheme.onSurface),
            ),
          ),
        ),
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

    final scanQR = Container(
      height: 200.0,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: theme.colorScheme.primary),
      ),
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
              hintText:
                  AppLocalizations.of(context).inputAddContactAddressHint(),
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

//                  Navigator.pushNamed(context, ScanQrPage.navId);
                },
              )),
        ),
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

                    width: MediaQuery.of(context).size.width  ,
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
                          SizedBox(height: 5,),
                        ],
                      ),
                    ),

                  ),

              );
            });
      }),
    );

    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: <Widget>[
            background,
            Container(
              padding: EdgeInsets.only(
                left: 24.0,
                right: 24.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  AppBar(
                    title: Text(
                        AppLocalizations.of(context).toolbarAddContactTitle()),
                    backgroundColor: Colors.transparent,
                    centerTitle: true,
                    elevation: 0,
                    iconTheme: IconThemeData(
                        color: Theme.of(context).colorScheme.primary),
                  ),

                  //LimitedBox (maxHeight: 60,),
                  SizedBox(
                    height: 5,
                  ),
                  Flexible(
                    flex: 3,
                    child: Stack(
                      children: <Widget>[
                        logo,
                        ellipse
                      ],
                    ),
                  ),
//                  SizedBox(height: 10 ,),
                  // LimitedBox(maxHeight: 30,),
                  Flexible(
                    flex: 1,
                    child: text,
                  ),

                  Flexible(
                    flex: 1,
                    child: email,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  // LimitedBox(maxHeight:30 ,),
                  Flexible(
                    flex: 1,
                    child: label,
                  ),
                  Flexible(
                    flex: 2,
                    child: scanQR,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  //LimitedBox(maxHeight: 50,),
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
