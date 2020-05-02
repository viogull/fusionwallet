import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fusion_wallet/ui/components/balances_card_item.dart';
import 'package:fusion_wallet/ui/components/custom/fusion_button.dart';
import 'package:fusion_wallet/ui/pages/primary/accounts/delegate_funds_page.dart';
import 'package:fusion_wallet/ui/pages/primary/accounts/push_funds_page.dart';
import 'package:fusion_wallet/ui/pages/primary/accounts/request_funds_page.dart';
import 'package:fusion_wallet/ui/pages/primary/accounts/rewards_info_page.dart';
import 'package:fusion_wallet/ui/pages/primary/accounts/send_funds_page.dart';
import 'package:fusion_wallet/ui/pages/primary/accounts/unbound_funds_page.dart';
import 'package:fusion_wallet/ui/theme/fusion_theme.dart';

import '../../../../localizations.dart';

class AccountsPage extends StatelessWidget {
  static const String navId = "/accounts";

  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemBuilder: (context, index) {
      return _buildAccountsPageBodyItem(context, index);
    });
  }

  Widget _buildAccountsPageBodyItem(BuildContext context, int index) {
    switch (index) {
      case 0:
        {
          return ButtonBar(
            alignment: MainAxisAlignment.center,
            buttonHeight: 45,
            buttonPadding:
                const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            children: <Widget>[
              RaisedButton.icon(
                shape: RoundedRectangleBorder(
                    borderRadius: FusionTheme.borderRadius),
                onPressed: () {
                  Navigator.pushNamed(context, SendFundsPage.navId);
                },
                icon: Icon(Icons.arrow_upward),
                color: FusionTheme.redButtonColor(),
                label: Text(AppLocalizations.of(context)
                    .buttonSend()
                    .toString()
                    .toUpperCase()),
              ),
              RaisedButton.icon(
                  shape: RoundedRectangleBorder(
                      borderRadius: FusionTheme.borderRadius),
                  onPressed: () {
                    Navigator.pushNamed(context, RequestFundsPage.navId);
                  },
                  icon: Icon(Icons.arrow_downward),
                  color: FusionTheme.greenButtonColor(),
                  label: Text(AppLocalizations.of(context)
                      .buttonRequest()
                      .toString()
                      .toUpperCase()))
            ],
          );
        }
        break;
      case 1:
        {
          return ButtonBar(
            alignment: MainAxisAlignment.center,
            buttonMinWidth: 100,
            buttonHeight: 45,
            children: <Widget>[
              FusionButton(
                AppLocalizations.of(context).buttonDelegate(),
                () {
                  Navigator.pushNamed(context, DelegateFundsPage.navId);
                },
              ),
              FusionButton(AppLocalizations.of(context).buttonUnbound(), () {
                Navigator.pushNamed(context, UnboundFundsPage.navId);
              })
            ],
          );
        }
        break;
      case 2:
        {
          return ButtonBar(
            alignment: MainAxisAlignment.center,
            buttonHeight: 45,
            children: <Widget>[
              FusionButton(AppLocalizations.of(context).buttonPush(), () {
                Navigator.pushNamed(context, PushFundsPage.navId);
              })
            ],
          );
        }
        break;
      case 3:
        {
          return _buildBalancesCard(context);
        }
        break;
      case 4:
        {
          return _buildRewardsCard(context);
        }
        break;
      case 5:
        {
          return AutoSizeText(
            AppLocalizations.of(context).labelTransanctionsHistoryTitle(),
            textAlign: TextAlign.center,
          );
        }
        break;
    }
  }

  Widget _buildBalancesCard(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final width = MediaQuery.of(context).size.width * 0.8;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Container(
        width: width,
        height: width * 0.7,
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: Card(
                color: theme.colorScheme.surface,
                margin: const EdgeInsets.all(16),
                shape: RoundedRectangleBorder(
                    borderRadius: FusionTheme.borderRadius,
                    side: BorderSide(
                        color: theme.colorScheme.onSurface, width: 0.1)),
                child: SizedBox.expand(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            AppLocalizations.of(context).labelCryptoAvailable(),
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 12,
                                color: theme.colorScheme.onSurface
                                    .withOpacity(0.9)),
                          ),
                        ),
                        BalancesCardItem(title: "Bitcoin", value: "0.00000"),
                        BalancesCardItem(title: "Bitcoin", value: "0.00000"),
                        BalancesCardItem(title: "Bitcoin", value: "0.00000"),
                        BalancesCardItem(title: "Bitcoin", value: "0.00000"),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: LimitedBox(
                maxHeight: 24,
                maxWidth: 24,
                child: FloatingActionButton(
                  mini: true,
                  heroTag: 'info_fab_tag',
                  child: SizedBox(
                    width: 15,
                    height: 15,
                    child: SvgPicture.asset("assets/images/icons/ic_dollar.svg",
                        placeholderBuilder: (BuildContext context) => Container(
                            padding: const EdgeInsets.all(2.0),
                            child: PlatformCircularProgressIndicator())),
                  ),
                  onPressed: () {},
                  elevation: 1,
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
                  onPressed: () {},
                  elevation: 1,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _buildBalancesAvailableCard(String title, String value) {
    return ListTile(
      leading: Icon(Icons.info),
      title: Text(title),
      trailing: Row(
        children: <Widget>[Icon(Icons.info), Text(value)],
      ),
    );
  }

  Widget _buildBtcIcon(@required String asset) => Padding(
        padding: const EdgeInsets.all(1.0),
        child: Center(
          child: SizedBox(
            width: 14,
            height: 14,
            child: SvgPicture.asset(asset,
                semanticsLabel: asset,
                placeholderBuilder: (BuildContext context) => Container(
                    padding: const EdgeInsets.all(30.0),
                    child: PlatformCircularProgressIndicator())),
          ),
        ),
      );

  Widget _buildRewardsCard(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(RewardInformationPage.navId);
      },
      child: Card(
          color: theme.colorScheme.surface,
          margin: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(
              borderRadius: FusionTheme.borderRadius,
              side: BorderSide(color: theme.colorScheme.onSurface, width: 0.1)),
          child: ListTile(
            leading: Icon(Icons.info),
            title:
                AutoSizeText(AppLocalizations.of(context).labelTotalReward()),
            trailing: AutoSizeText("0.00"),
          )),
    );
  }
}

class TransanctionHistoryItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // TODO: implement build
    return Text("NAme OF Receiver");
  }
}
