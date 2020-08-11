import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fusion_wallet/core/state_container.dart';
import 'package:fusion_wallet/localizations.dart';
import 'package:fusion_wallet/ui/components/custom/fusion_button.dart';
import 'package:fusion_wallet/ui/components/custom/fusion_scaffold.dart';
import 'package:fusion_wallet/ui/theme.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share/share.dart';

class QrPageData {
  final String qrData;
  QrPageData(this.qrData);
}

class ViewPassphraseDialog extends StatelessWidget {
  final String data;
  static const String navId = "/passphrase/qr/share";

  ViewPassphraseDialog({@required this.data});

  @override
  Widget build(BuildContext context) {
    final qr = StateContainer.of(context).selectedAccount.mnemonic;
    return SafeArea(
      child: FusionScaffold(
        title: AppLocalizations.of(context).toolbarTitleShowPassphrase(),
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
                      data: data == null ? qr.toString() : data,
                      backgroundColor: Theme.of(context).colorScheme.background,
                      size: MediaQuery.of(context).size.width * 0.5,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          data == null ? qr : data,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RaisedButton.icon(
                        color: Theme.of(context).colorScheme.primary,
                          shape: RoundedRectangleBorder(
                              borderRadius: FusionTheme.borderRadius),
                          label:
                              Text(AppLocalizations.of(context).buttonShare(),
                              style: TextStyle(color: Theme.of(context).colorScheme.onPrimary)),
                          onPressed: () {
                            Share.share(data);
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
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: FusionButton(
                    text: AppLocalizations.of(context).buttonClose(),
                    onPressed: () {
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
    );
  }
}
