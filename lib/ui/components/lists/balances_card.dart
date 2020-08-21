import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fusion_wallet/core/models/models.dart';
import 'package:fusion_wallet/ui/components/balances_card_item.dart';
import 'package:fusion_wallet/ui/theme.dart';
import 'package:fusion_wallet/utils/flasher.dart';
import 'package:fusion_wallet/utils/haptic.dart';

import '../../../inject.dart';
import '../../../localizations.dart';

class AccountBalancesCard extends StatefulWidget {
  final AddressData data;
  final Function onPlusTapped;

  AccountBalancesCard({this.data, this.onPlusTapped});

  @override
  _AccountBalancesCardState createState() => _AccountBalancesCardState();
}

class _AccountBalancesCardState extends State<AccountBalancesCard> {
  bool _showUsdValues = false;

  Widget buildBalancesList(BuildContext context) {
    return ListView.builder(
        itemCount: widget.data.data.balances.length,
        itemBuilder: (_, index) {
          return ListTile(
              title: Text(widget.data.data.balances[index].coin.toString()));
        });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final ThemeData theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 1),
      child: Container(
        width: width,
        height: width * 0.5,
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: Card(
                elevation: 2,
                color: theme.colorScheme.surface,
                margin: const EdgeInsets.all(16),
                shape: RoundedRectangleBorder(
                    borderRadius: FusionTheme.borderRadius,
                    side: BorderSide(
                        color: theme.colorScheme.onSurface, width: 0.1)),
                child: SizedBox.expand(
                    child: Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 12, top: 8),
                              child: Text(
                                AppLocalizations.of(context)
                                    .labelCryptoAvailable(),
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 12,
                                    color: theme.colorScheme.onSurface
                                        .withOpacity(0.9)),
                              ),
                            ),
                            BalancesCardItem(
                                title: widget.data.data.balances.first.coin,
                                value: widget.data.data.balances.first.amount,
                                showUsd: this._showUsdValues)
                          ],
                        ))),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: LimitedBox(
                maxHeight: 24,
                maxWidth: 24,
                child: FloatingActionButton(
                  focusElevation: 2,
                  highlightElevation: 8,
                  mini: true,
                  heroTag: 'info_fab_tag',
                  child: GestureDetector(
                    onTap: () {
                      injector.get<HapticUtil>().selection();

                      String flashText = (this._showUsdValues)
                          ? AppLocalizations.of(context).cardCurrencyMode()
                          : AppLocalizations.of(context).cardUsdMode();
                      FlashHelper.infoBar(context, message: flashText);
                      setState(() {
                        this._showUsdValues = !(this._showUsdValues);
                      });
                    },
                    child: SizedBox(
                      width: 15,
                      height: 15,
                      child: SvgPicture.asset(
                          (_showUsdValues)
                              ? "assets/images/icons/ic_dollar.svg"
                              : "assets/images/icons/ic_bitcoin.svg",
                          color: Theme.of(context).colorScheme.onSecondary,
                          placeholderBuilder: (BuildContext context) =>
                              Container(
                                  padding: const EdgeInsets.all(2.0),
                                  child: PlatformCircularProgressIndicator())),
                    ),
                  ),
                  onPressed: () {},
                  elevation: 8,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: LimitedBox(
                maxHeight: 32,
                maxWidth: 32,
                child: FloatingActionButton(
                  mini: true,
                  child: Icon(
                    Icons.add,
                    size: 24,
                  ),
                  onPressed: () {
                    widget.onPlusTapped();
                  },
                  elevation: 0,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
