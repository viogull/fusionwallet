import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:fusion_wallet/core/minter_rest.dart';
import 'package:fusion_wallet/ui/components/custom/fusion_button.dart';
import 'package:fusion_wallet/ui/pages/primary/accounts/delegate.dart';
import 'package:fusion_wallet/ui/pages/primary/accounts/push_funds_page.dart';
import 'package:fusion_wallet/ui/pages/primary/accounts/rewards_info_page.dart';
import 'package:fusion_wallet/ui/pages/primary/accounts/send_funds_page.dart';
import 'package:fusion_wallet/ui/pages/primary/accounts/unbound_funds_page.dart';
import 'package:fusion_wallet/ui/pages/primary/share_address.dart';
import 'package:fusion_wallet/ui/theme.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import './../../core/abstract/wallet.dart';
import './../../main.dart';
import '../../core/state_container.dart';
import '../../inject.dart';
import '../../localizations.dart';
import '../components/lists/balances_card.dart';

class AccountsPage extends StatelessWidget {
  static const String navId = "/accounts";

  @override
  Widget build(BuildContext context) =>
      Observer(builder: (_) => _buildAccountsUi(context, wallet));

  Widget _buildAccountsUi(BuildContext context, Wallet wallet) =>
      AnimationLimiter(
          child: ListView.builder(
        itemCount: 5,
        itemBuilder: (BuildContext context, int index) {
          return AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 890),
            child: FadeInAnimation(
                child: _buildAccountsPageBodyItem(context, index)),
          );
        },
      ));

  Widget _buildAccountsPageBodyItem(BuildContext context, int index) {
    switch (index) {
      case 0:
        {
          return Column(children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '',
                style: TextStyle(fontSize: 10),
              ),
            ),
            ButtonBar(
              alignment: MainAxisAlignment.center,
              buttonHeight: 45,
              buttonMinWidth: 130,
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
                    showCupertinoModalBottomSheet(context: context, builder: (context, controller) {
                      return ShareAddressPage(
                          "Mx${StateContainer.of(context).selectedAccount.address}");
                    });
                    },
                    icon: Icon(Icons.arrow_downward),
                    color: FusionTheme.greenButtonColor(),
                    label: Text(AppLocalizations.of(context)
                        .buttonRequest()
                        .toString()
                        .toUpperCase()))
              ],
            )
          ]);
        }
        break;
      case 1:
        {
          return ButtonBar(
            alignment: MainAxisAlignment.center,
            buttonHeight: 45,
            buttonMinWidth: 130,
            buttonPadding:
                const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            children: <Widget>[
              RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: FusionTheme.borderRadius),
                onPressed: () {
                  Navigator.pushNamed(context, DelegateFundsPage.navId);
                },
                color: Theme.of(context).colorScheme.primary,
                child: Text(
                    AppLocalizations.of(context).buttonDelegate().toString()),
              ),
              RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: FusionTheme.borderRadius),
                  onPressed: () {
                    Navigator.pushNamed(context, UnboundFundsPage.navId);
                  },
                  color: Theme.of(context).colorScheme.primary,
                  child: Text(
                      AppLocalizations.of(context).buttonUnbound().toString()))
            ],
          );
        }
        break;
      case 2:
        {
          return ButtonBar(
            alignment: MainAxisAlignment.center,
            buttonHeight: 40,
            buttonMinWidth: 130,
            buttonPadding:
            const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            children: <Widget>[
              FusionButton(
                  text: AppLocalizations.of(context).buttonPush(),
                  onPressed: () {
                    Navigator.of(context).push(
                      new MaterialPageRoute(builder: (context) {
                        return PushFundsPage();
                      }, fullscreenDialog: true)
                    );
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
          return (StateContainer.of(context).selectedAccount.showRewards)
              ? _buildRewardsCard(context)
              : Container();
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
    return FutureBuilder(
      future: injector.get<MinterRest>().fetchAddressData(
          address: StateContainer.of(context).selectedAccount.address),
      builder: (context, snapshot) {
        debugPrint(
            'Connection State ${snapshot.connectionState}, has data : ${snapshot.hasData}');
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          var balances = snapshot.data.data.balances;
          if (balances.length > 0) {
            debugPrint("Rendering balances length ${balances.length}");
            return AccountBalancesCard(data: snapshot.data);
          } else
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              shape: RoundedRectangleBorder(
                  borderRadius: FusionTheme.borderRadius,
                  side: BorderSide(
                      color: theme.colorScheme.onSurface, width: 0.1)),
              child: Container(
                  height: 001, child: PlatformCircularProgressIndicator()),
            );
        } else {
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            shape: RoundedRectangleBorder(
                borderRadius: FusionTheme.borderRadius,
                side:
                    BorderSide(color: theme.colorScheme.onSurface, width: 0.1)),
            color: theme.colorScheme.surface,
            elevation: 4,
            child: Container(
                width: width,
                height: 100,
                child: Center(child: PlatformCircularProgressIndicator())),
          );
        }
      },
    );
  }

  Widget _buildRewardsCard(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(RewardInformationPage.navId);
      },
      child: Card(
          color: theme.colorScheme.surface,
          margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          shape: RoundedRectangleBorder(
              borderRadius: FusionTheme.borderRadius,
              side: BorderSide(color: theme.colorScheme.onSurface, width: 0.1)),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            child: ListTile(
              leading: Icon(Icons.info),
              title:
                  AutoSizeText(AppLocalizations.of(context).labelTotalReward()),
              trailing: AutoSizeText("0.00", minFontSize: 17,),
            ),
          )),
    );
  }
}

class TransanctionHistoryItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text("NAme OF Receiver");
  }
}
