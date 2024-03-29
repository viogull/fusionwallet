import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fusion_wallet/ui/theme.dart';

class BalancesCardItem extends StatelessWidget {
  final String title;
  final String value;
  final String valueUsd;
  bool showUsd = false;

  BalancesCardItem({@required this.title, @required this.value, this.valueUsd,  this.showUsd});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * 0.5;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
      child: LimitedBox(
        maxWidth: width,
        maxHeight: 32,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Flexible(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: SizedBox(
                  width: 16,
                  height: 16,
                  child: SvgPicture.asset(
                      (showUsd)
                          ? "assets/images/icons/ic_dollar.svg"
                          : "assets/images/icons/ic_bitcoin.svg",
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withOpacity(0.7),
                      placeholderBuilder: (BuildContext context) => Container(
                          padding: const EdgeInsets.all(24.0),
                          child: PlatformCircularProgressIndicator())),
                ),
              ),
            ),
            Flexible(
              flex: 10,
              child: Center(
                child: Text(
                  title,
                  style: FusionTheme.subtitleTextStyle.copyWith(fontSize: 24),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Flexible(
                flex: 10,
                child: Text(showUsd ? valueUsd : value,
                    textAlign: TextAlign.start,
                    style:
                        FusionTheme.subtitleTextStyle.copyWith(fontSize: 24)))
          ],
        ),
      ),
    );
  }
}
