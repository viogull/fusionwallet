import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:fusion_wallet/localizations.dart';
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

    return PlatformScaffold(
      appBar: PlatformAppBar(
        android: (_) => MaterialAppBarData(
            centerTitle: true,
            elevation: 0,
            iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
            backgroundColor: Colors.transparent),
        backgroundColor: Colors.transparent,
        title: Text(
          AppLocalizations.of(context).toolbarSharePasshpraseQr(),
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Center(
        child: Column(
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
                      size: MediaQuery.of(context).size.width * 0.5,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: PlatformButton(
                        child: Text(AppLocalizations.of(context).buttonShare()),
                        onPressed: () {
                          Share.share(data.toString(),
                              subject: AppLocalizations.of(context)
                                  .toolbarSharePasshpraseQr()
                                  .toString());
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                child: PlatformButton(
                  child: Text(AppLocalizations.of(context).buttonClose()),
                  onPressed: () {},
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
