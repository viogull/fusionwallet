import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fusion_wallet/localizations.dart';

class PopupDialogWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final String asset;

  PopupDialogWidget(this.title, this.asset, this.subtitle);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: PlatformScaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          child: SizedBox.expand(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Flexible(
                  flex: 2,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    child: Text(
                      title,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                ),
                Flexible(
                  flex: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Container(
                      width: 100,
                      height: 100,
                      child: SizedBox.expand(
                        child: SvgPicture.asset(
                          asset,
                          semanticsLabel: 'Popup Icon',
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    child: Text(
                      subtitle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: PlatformButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(AppLocalizations.of(context).labelOk()),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
