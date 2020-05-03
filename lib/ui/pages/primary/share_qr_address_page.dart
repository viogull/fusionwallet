import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fusion_wallet/theme/fusion_theme.dart';
import 'package:fusion_wallet/ui/components/custom/fusion_scaffold.dart';
import 'package:fusion_wallet/utils/haptic.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:random_string/random_string.dart';
import 'package:share/share.dart';

import '../../../localizations.dart';
import '../../../service_locator.dart';

class ShareQrPage extends StatelessWidget {
  static const String navId = "/qr/share";

  @override
  Widget build(BuildContext context) {
    final address = randomString(64);
    return FusionScaffold(
      title: AppLocalizations.of(context).buttonShare(),
      child: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(
              flex: 4,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: <Widget>[
                    QrImage(
                      version: QrVersions.auto,
                      foregroundColor: Theme.of(context).colorScheme.primary,
                      data: address,
                      backgroundColor: Theme.of(context).colorScheme.surface,
                      size: MediaQuery.of(context).size.width * 0.5,
                    ),
                  ],
                ),
              ),
            ),
            Flexible(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: RaisedButton.icon(
                    color: Theme.of(context).colorScheme.primary,
                    shape: RoundedRectangleBorder(
                        borderRadius: FusionTheme.borderRadius),
                    label: Text(
                      AppLocalizations.of(context).buttonShare(),
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary),
                    ),
                    onPressed: () {
                      Share.share(address);
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
            ),
            Flexible(
                flex: 2,
                child: Column(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Clipboard.setData(ClipboardData(text: address));
                        sl.get<HapticUtil>().success();
                        Fluttertoast.showToast(
                            msg: AppLocalizations.of(context).labelOk());
                      },
                      child: Card(
                          margin: const EdgeInsets.all(12),
                          color: Theme.of(context).colorScheme.surface,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: FusionTheme.borderRadius,
                              side: BorderSide(
                                  color:
                                      Theme.of(context).colorScheme.onSurface,
                                  width: 0.25)),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: AutoSizeText(
                              address,
                              textAlign: TextAlign.center,
                              minFontSize: 8,
                              maxLines: 4,
                              maxFontSize: 14,
                            ),
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: AutoSizeText(
                        AppLocalizations.of(context).labelTapToCopy(),
                        textAlign: TextAlign.center,
                        minFontSize: 6,
                        maxLines: 1,
                        maxFontSize: 10,
                      ),
                    )
                  ],
                )),
            Flexible(
              flex: 1,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ButtonBar(
                    buttonMinWidth: MediaQuery.of(context).size.width * 0.9,
                    buttonHeight: 45,
                    alignment: MainAxisAlignment.center,
                    children: <Widget>[
                      RaisedButton(
                        child: Text(
                          AppLocalizations.of(context)
                              .toolbarRecoverFromSeedTitle(),
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimary),
                        ),
                        color: Theme.of(context).colorScheme.primary,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      )
                    ],
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
