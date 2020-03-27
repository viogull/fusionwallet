import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fusion_wallet/localizations.dart';
import 'package:fusion_wallet/ui/components/custom/fusion_button.dart';
import 'package:fusion_wallet/ui/pages/auth/passphrase/scan_qr_page.dart';
import 'package:fusion_wallet/ui/pages/popups/popup_page.dart';
import 'package:fusion_wallet/ui/theme/fusion_theme.dart';

class RecoverFromSeedPage extends StatelessWidget {
  static const navId = "/auth/recover";

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container();
  }
}

class RecoverAccountPage extends StatefulWidget {
  static const String navId = '/RecaverAccountPage';
  @override
  _RecaverAccountPage createState() => new _RecaverAccountPage();
}

class _RecaverAccountPage extends State<RecoverAccountPage> {
  bool _rememberMeFlag = false;
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    final background = SvgPicture.asset(
      ('assets/images/backgrounds/bg_primary.svg'),
      fit: BoxFit.fill,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
    );

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
            color: (theme.brightness == Brightness.dark)
                ? FusionTheme.dark.colorScheme.onPrimary
                : FusionTheme.light.colorScheme.onPrimary),
      ),
    );

    final accountName = Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: theme.primaryColor)),
      height: 30.0,
      width: 39.0,
      child: Center(
        child: TextField(
          style: TextStyle(
            color: (theme.brightness == Brightness.dark)
                ? FusionTheme.dark.colorScheme.onPrimary
                : FusionTheme.light.colorScheme.onPrimary,
          ),
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: AppLocalizations.of(context).inputEditAccountNameHint(),
            labelStyle: TextStyle(
                color: (theme.brightness == Brightness.dark)
                    ? FusionTheme.dark.colorScheme.onPrimary
                    : FusionTheme.light.colorScheme.onPrimary),
          ),
        ),
      ),
    );

    final scanQR = Container(
      height: 200.0,
      width: 100,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: theme.primaryColor)),
      child: SizedBox.expand(
        child: TextFormField(
          maxLines: 10,
          style: TextStyle(
            color: (theme.brightness == Brightness.dark)
                ? FusionTheme.dark.colorScheme.onPrimary
                : FusionTheme.light.colorScheme.onPrimary,
          ),
          decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: AppLocalizations.of(context)
                  .inputEnterScanPasshpraseHintText(),
              hintStyle: TextStyle(
                color: (theme.brightness == Brightness.dark)
                    ? FusionTheme.dark.colorScheme.onPrimary
                    : FusionTheme.light.colorScheme.onPrimary,
              ),
              suffixIcon: IconButton(
                icon: SvgPicture.asset(
                  'assets/images/icons/ic_qrcodescan.svg',
                  height: 35.0,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, ScanQrPage.navId);
                },
              )),
        ),
      ),
    );

    final button = Container(
      height: 50,
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

    return Scaffold(
      body: Container(
        //width: MediaQuery.of(context).size.width,
        child: Stack(
          fit: StackFit.passthrough,
          children: <Widget>[
            background,
            Container(
              padding: EdgeInsets.only(
                left: 24.0,
                right: 24.0,
              ),
//              width: MediaQuery.of(context).size.width,
              child: ListView(
                children: <Widget>[
                  MyCustomAppBar(
                    height: 80,
                  ),
                  logo,
                  SizedBox(height: 25.0),
                  text,
                  SizedBox(height: 25.0),
                  accountName,
                  SizedBox(height: 25.0),
                  scanQR,
                  SizedBox(height: 100.0),
                  button,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyCustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  final bool defaultAppBar;

  const MyCustomAppBar({
    Key key,
    @required this.height,
    this.defaultAppBar = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Column(children: [
      Container(
        child: PlatformAppBar(
          android: (_) => MaterialAppBarData(
              backgroundColor: Colors.transparent,
              elevation: 0,
              centerTitle: true,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: LimitedBox(
                  maxHeight: 24,
                  maxWidth: 24,
                  child: SvgPicture.asset(
                    'assets/images/icons/ic_next.svg',
                  ),
                ),
              ),
              title: Text(
                AppLocalizations.of(context).toolbarRecoverFromSeedTitle(),
//                "Recover from Seed",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              )),
        ),
      ),
    ]);
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
