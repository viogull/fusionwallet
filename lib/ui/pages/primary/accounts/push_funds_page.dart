import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fusion_wallet/localizations.dart';
import 'package:fusion_wallet/ui/theme.dart';
import 'package:fusion_wallet/ui/components/custom/fusion_button.dart';
import 'package:fusion_wallet/ui/components/custom/fusion_scaffold.dart';

class PushFundsPage extends StatelessWidget {
  static const String navId = "/funds/push";
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
      title: AppLocalizations.of(context).buttonPush(),
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
                            AppLocalizations.of(context).labelSender(),
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.onSurface,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ),
                      Theme(
                        data: Theme.of(context),
                        child: TextField(
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 1),
                              hintText:
                                  AppLocalizations.of(context).labelName(),
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
                            AppLocalizations.of(context).labelReceiver(),
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.onSurface,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Theme(
                        data: Theme.of(context),
                        child: TextField(
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 1),
                              hintStyle:
                                  TextStyle(color: theme.colorScheme.onSurface),
                              hintText:
                                  AppLocalizations.of(context).labelName(),
                              border: inputBorder(context),
                              enabledBorder: inputBorder(context)),
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
                  child: FusionButton(
                      text: AppLocalizations.of(context)
                          .buttonPush()
                          .toString()
                          .toUpperCase(),
                      onPressed: () {},
                      expandedWidth: true),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  inputBorder(BuildContext context) => OutlineInputBorder(
      gapPadding: 4,
      borderRadius: FusionTheme.borderRadius,
      borderSide: BorderSide(color: Theme.of(context).colorScheme.primary));
}
