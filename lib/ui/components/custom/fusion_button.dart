import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:fusion_wallet/theme/fusion_theme.dart';

typedef FusionButtonTapCallBack = void Function();

class FusionButton extends StatelessWidget {
  final String text;
  final FusionButtonTapCallBack onPressed;
  final Icon icons;
  final bool expandedWidth;

  FusionButton(this.text, this.onPressed, [this.icons, this.expandedWidth]);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.all(8),
      width: 100,
      height: 45,
      decoration: BoxDecoration(
        borderRadius: FusionTheme.borderRadius,
        border: Border.all(color: Theme.of(context).colorScheme.surface),
      ),
      child: PlatformButton(
        android: (_) => FusionTheme.buttonAndroidTheme,
        ios: (_) => FusionTheme.buttonIOSTheme,
        color: theme.colorScheme.primary,
        onPressed: this.onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          child: AutoSizeText(
            text,
            textAlign: TextAlign.center,
            minFontSize: 10,
            maxLines: 1,
            style: TextStyle(
              color: (theme.colorScheme.onPrimary),
            ),
          ),
        ),
      ),
    );
  }
}
