import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:fusion_wallet/ui/theme/fusion_theme.dart';

typedef FusionButtonTapCallBack = void Function();

class FusionButton extends StatelessWidget {
  final String text;
  final FusionButtonTapCallBack onPressed;
  final Icon icons;

  FusionButton(this.text, this.onPressed, [this.icons]);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        borderRadius: FusionTheme.borderRadius,
        border: Border.all(color: Theme.of(context).colorScheme.surface),
      ),
      child: PlatformButton(
        android: (_) => FusionTheme.buttonAndroidTheme,
        ios: (_) => FusionTheme.buttonIOSTheme,
        color: theme.colorScheme.primary,
        onPressed: this.onPressed,
        child: AutoSizeText(
          text.toUpperCase(),
          style: TextStyle(
              fontSize: 14,
            color: (theme.colorScheme.onPrimary),
          ),
        ),
      ),
    );
  }
}
