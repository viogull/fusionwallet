import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fusion_wallet/theme/fusion_theme.dart';

typedef SettingsBaseCallBack = void Function();

class FusionPreference extends StatelessWidget {
  final String title;
  final SettingsBaseCallBack onClick;

  FusionPreference({@required this.title, @required this.onClick});

  @override
  Widget build(BuildContext context) {
    final cardWidth = MediaQuery.of(context).size.width * 0.95;
    final cardHeight = cardWidth * 0.15;

    return GestureDetector(
      onTap: () {
        onClick.call();
      },
      child: Card(
        elevation: 3,
        color: Theme.of(context).colorScheme.surface,
        shape: RoundedRectangleBorder(borderRadius: FusionTheme.borderRadius),
        child: Container(
          width: cardWidth,
          height: cardHeight,
          padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Flexible(
                flex: 4,
                child: Text(title),
              ),
              Flexible(
                flex: 1,
                child: Icon(
                  CupertinoIcons.right_chevron,
                  size: 24,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
