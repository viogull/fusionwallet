import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fusion_wallet/localizations.dart';
import 'package:fusion_wallet/ui/theme.dart';
import 'package:fusion_wallet/ui/components/custom/fusion_scaffold.dart';

class SendFundsPage extends StatelessWidget {
  static const String navId = "/funds/send";
  TextEditingController _sendController = new TextEditingController();
  TextEditingController _receiveController = new TextEditingController();

  BoxDecoration formDecoration(BuildContext context) => BoxDecoration(
      borderRadius: FusionTheme.borderRadius,
      border:
          Border.all(color: Theme.of(context).colorScheme.primary, width: 1));

  Widget buildBitcoinEndIcon(
          BuildContext context, String qtyText, MainAxisAlignment alignment) =>
      LimitedBox(
        maxWidth: MediaQuery.of(context).size.width / 10,
        child: Row(
          mainAxisAlignment: alignment,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: SvgPicture.asset(
                ('assets/images/icons/ic_bitcoin.svg'),
                // color: Colors.white,
                fit: BoxFit.fitWidth,
                height: 12,
                width: 12,
              ),
            ),
            Text(
              qtyText,
              style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
              textAlign: TextAlign.right,
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return FusionScaffold(
      title: AppLocalizations.of(context).toolbarSendTitle(),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(8),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.9,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Flexible(
                flex: 8,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            AppLocalizations.of(context).labelFrom(),
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.onSurface,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ),
                      Theme(
                        data: ThemeData(
                            primaryColor:
                                Theme.of(context).colorScheme.primary),
                        child: TextField(
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 1),
                              hintText: "Sendfrom",
                              suffix: buildBitcoinEndIcon(
                                  context, "0.00", MainAxisAlignment.end),
                              border: inputBorder(context),
                              enabled: true,
                              enabledBorder: inputBorder(context)),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            AppLocalizations.of(context).labelAmount(),
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.onSurface,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Theme(
                        data: ThemeData(
                            primaryColor:
                                Theme.of(context).colorScheme.primary),
                        child: TextField(
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 1),
                              hintText: "Sendfrom",
                              suffix: buildTextFieldMaxButton(context),
                              prefix: buildBitcoinEndIcon(
                                  context, "0.00", MainAxisAlignment.start),
                              border: inputBorder(context),
                              enabledBorder: inputBorder(context)),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            AppLocalizations.of(context).labelTo(),
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.onSurface,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          buildReceiverCardItem(context,
                              AppLocalizations.of(context).labelAddress()),
                          buildReceiverCardItem(context,
                              AppLocalizations.of(context).labelMyContacts()),
                          buildReceiverCardItem(context,
                              AppLocalizations.of(context).labelContacts()),
                          buildReceiverCardItem(context,
                              AppLocalizations.of(context).labelScanQr()),
                        ],
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          width: 32,
                          height: 32,
                          margin: const EdgeInsets.only(right: 16, top: 16),
                          child: FloatingActionButton(
                            child: SvgPicture.asset(
                                "assets/images/icons/ic_add.svg",
                                width: 24,
                                height: 24,
                                color: theme.colorScheme.onSecondary,
                                placeholderBuilder: (BuildContext context) =>
                                    Container(
                                        padding: const EdgeInsets.all(2.0),
                                        child:
                                            PlatformCircularProgressIndicator())),
                            mini: true,
                            onPressed: () {},
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Flexible(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ButtonBar(
                    alignment: MainAxisAlignment.center,
                    buttonMinWidth: MediaQuery.of(context).size.width * 0.9,
                    buttonHeight: 45,
                    children: <Widget>[
                      RaisedButton(
                        onPressed: () {},
                        child: Text(
                          AppLocalizations.of(context).buttonPreview(),
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimary),
                        ),
                        color: Theme.of(context).colorScheme.primary,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextFieldMaxButton(BuildContext context) => Container(
        width: 32,
        margin: const EdgeInsets.all(4),
        decoration: BoxDecoration(
            borderRadius: FusionTheme.borderRadius,
            border: Border.all(color: Theme.of(context).colorScheme.primary)),
        child: Center(
          child: Text(
            AppLocalizations.of(context)
                .inputMaxAmountSuffix()
                .toString()
                .toUpperCase(),
            style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
          ),
        ),
      );

  Widget buildReceiverCardItem(BuildContext context, String label) => Flexible(
        flex: 1,
        child: Card(
          margin: const EdgeInsets.all(4),
          elevation: 0,
          color: Theme.of(context).colorScheme.surface,
          shape: RoundedRectangleBorder(
              borderRadius: FusionTheme.borderRadius,
              side: BorderSide(color: Theme.of(context).colorScheme.primary)),
          child: LimitedBox(
            maxWidth: MediaQuery.of(context).size.width / 5,
            maxHeight: 44,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: AutoSizeText(
                      label,
                      maxLines: 1,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );

  inputBorder(BuildContext context) => OutlineInputBorder(
      gapPadding: 4,
      borderRadius: FusionTheme.borderRadius,
      borderSide: BorderSide(color: Theme.of(context).colorScheme.primary));
}
