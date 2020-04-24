import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fusion_wallet/localizations.dart';
import 'package:fusion_wallet/ui/components/custom/fusion_button.dart';
import 'package:fusion_wallet/ui/theme/fusion_theme.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share/share.dart';

class QrPageData {
  final String qrData;
  QrPageData(this.qrData);
}

class PassphraseShareQrPage extends StatelessWidget {
  static const String navId = "/passphrase/qr/share";

  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context).settings.arguments as List;

    return Stack(children: <Widget>[
      Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SvgPicture.asset(
          "assets/images/backgrounds/bg_primary.svg",
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          fit: BoxFit.fill,
        ),
      ),
      Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title:
              Text(AppLocalizations.of(context).toolbarRecoverFromSeedTitle()),
          backgroundColor: Colors.transparent,
          centerTitle: true,
          elevation: 0,
          iconTheme:
              IconThemeData(color: Theme.of(context).colorScheme.primary),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: <Widget>[
                    QrImage(
                      version: QrVersions.auto,
                      data: data.toString(),
                      backgroundColor: Theme.of(context).colorScheme.onSurface,
                      size: MediaQuery.of(context).size.width * 0.5,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RaisedButton.icon(
                          shape: RoundedRectangleBorder(
                              borderRadius: FusionTheme.borderRadius),
                          label:
                              Text(AppLocalizations.of(context).buttonShare()),
                          onPressed: () {
                            Share.share(data.toString());
                          },
                          icon: Container(
                            child: SvgPicture.asset(
                              'assets/images/icons/ic_shareicon.svg',
                              color: Colors.white,
                            ),
                            width: 18,
                            height: 18,
                          )),
                    ),
                  ],
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                child: Container(
                  height: 48,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: FusionButton(
                    AppLocalizations.of(context).buttonClose(),
                    () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
          ],
        ),
      ),
    ]);
  }
}
