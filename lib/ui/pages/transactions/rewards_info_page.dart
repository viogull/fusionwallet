import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fusion_wallet/localizations.dart';
import 'package:fusion_wallet/ui/theme.dart';
import 'package:fusion_wallet/ui/components/custom/fusion_scaffold.dart';

class RewardInformationPage extends StatelessWidget {
  static const String navId = "/reward/info";

  @override
  Widget build(BuildContext context) {
    double cardWidth = MediaQuery.of(context).size.width * 0.8;
    return FusionScaffold(
      title: AppLocalizations.of(context).toolbarRewards(),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 32),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: FusionTheme.borderRadius,
                      side: BorderSide(
                          color: Theme.of(context).colorScheme.onSurface,
                          width: 0.15)),
                  color: Theme.of(context).colorScheme.surface,
                  child: Container(
                    width: cardWidth,
                    height: cardWidth * 0.4,
                    child: Column(
                      children: <Widget>[
                        Flexible(
                          flex: 2,
                          child: Center(
                            child: AutoSizeText(AppLocalizations.of(context)
                                .labelTotalRewardTitle()
                                .toString()
                                .toUpperCase()),
                          ),
                        ),
                        Divider(
                          height: 1,
                        ),
                        Flexible(
                          flex: 5,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  height: 48,
                                  width: 48,
                                  child: SvgPicture.asset(
                                    "assets/images/icons/ic_bitcoin.svg",
                                    semanticsLabel:
                                        "assets/images/icons/ic_bitcoin.svg",
                                    fit: BoxFit.fill,
                                    color:
                                        Theme.of(context).colorScheme.onSurface,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: AutoSizeText(
                                  "0.00",
                                  minFontSize: 48,
                                  maxLines: 1,
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 32),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: FusionTheme.borderRadius,
                      side: BorderSide(
                          color: Theme.of(context).colorScheme.onSurface,
                          width: 0.15)),
                  color: Theme.of(context).colorScheme.surface,
                  child: Container(
                    width: cardWidth,
                    height: cardWidth * 0.4,
                    child: Column(
                      children: <Widget>[
                        Flexible(
                          flex: 2,
                          child: Center(
                            child: AutoSizeText(AppLocalizations.of(context)
                                .labelPendingRewardTitle()
                                .toString()
                                .toUpperCase()),
                          ),
                        ),
                        Divider(
                          height: 1,
                        ),
                        Flexible(
                          flex: 5,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  height: 48,
                                  width: 48,
                                  child: SvgPicture.asset(
                                    "assets/images/icons/ic_bitcoin.svg",
                                    semanticsLabel:
                                        "assets/images/icons/ic_bitcoin.svg",
                                    fit: BoxFit.fill,
                                    color:
                                        Theme.of(context).colorScheme.onSurface,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: AutoSizeText(
                                  "0.00",
                                  minFontSize: 48,
                                  maxLines: 1,
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: AutoSizeText(
                  AppLocalizations.of(context).labelPendingRewardSubtitle(),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: AutoSizeText(
                  AppLocalizations.of(context).labelRewardsCaption(),
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
