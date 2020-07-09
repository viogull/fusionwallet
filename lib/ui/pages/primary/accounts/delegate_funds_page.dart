import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fusion_wallet/localizations.dart';
import 'package:fusion_wallet/theme/fusion_theme.dart';
import 'package:fusion_wallet/ui/components/custom/fusion_button.dart';
import 'package:fusion_wallet/ui/components/custom/fusion_scaffold.dart';

class DelegateFundsPage extends StatelessWidget {
  static const String navId = "/funds/delegate";
  TextEditingController _sendController = new TextEditingController();
  TextEditingController _receiveController = new TextEditingController();

  BoxDecoration formDecoration(BuildContext context) => BoxDecoration(
      borderRadius: FusionTheme.borderRadius,
      border:
          Border.all(color: Theme.of(context).colorScheme.primary, width: 1));

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return FusionScaffold(
      title: AppLocalizations.of(context).buttonDelegate(),
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
                      Theme(
                        data: theme,
                        child: TextField(
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 1),
                              hintText: AppLocalizations.of(context)
                                  .labelPubkeyOrDomain(),
                              border: inputBorder(context),
                              enabled: true,
                              suffixIcon: buildScanQrEndIcon(context),
                              enabledBorder: inputBorder(context)),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            AppLocalizations.of(context).labelCoin(),
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.onSurface,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Theme(
                        data: theme,
                        child: TextField(
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 1),
                              hintText: AppLocalizations.of(context)
                                  .inputFundsStakeHint(),
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
                     text:  AppLocalizations.of(context).buttonDelegate().toString(),
                     onPressed: () {},
                      expandedWidth: true,
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

  inputBorder(BuildContext context) => OutlineInputBorder(
      gapPadding: 4,
      borderRadius: FusionTheme.borderRadius,
      borderSide: BorderSide(color: Theme.of(context).colorScheme.primary));

  buildScanQrEndIcon(BuildContext context) => Align(
        alignment: Alignment.centerRight,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SvgPicture.asset("assets/images/icons/ic_qrcodescan.svg",
              width: 16, height: 16),
        ),
      );
}
