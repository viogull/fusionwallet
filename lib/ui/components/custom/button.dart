import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:fusion_wallet/inject.dart';
import 'package:fusion_wallet/ui/theme.dart';
import 'package:fusion_wallet/utils/haptic.dart';
import 'package:google_fonts/google_fonts.dart';

typedef FusionButtonTapCallBack = void Function();

class FusionButton extends RaisedButton {
  final String text;
  final FusionButtonTapCallBack onPressed;
  final Icon icons;
  final bool expandedWidth;

  final double _width2height = 280 / 45;

  FusionButton(
      {@required this.text,
      @required this.onPressed,
      this.icons,
      this.expandedWidth = false});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final fullWidth = MediaQuery.of(context).size.width * 0.85;
    final calculatedHeight = fullWidth / _width2height;

    final double height = 50;
    return Container(
      margin: const EdgeInsets.all(8),
      width: (expandedWidth) ? fullWidth : 120,
      height: (expandedWidth) ? calculatedHeight : height,
      decoration: BoxDecoration(borderRadius: FusionTheme.borderRadius),
      child: PlatformButton(
        material: (_, __) => FusionTheme.buttonAndroidTheme,
        cupertino: (_, __) => FusionTheme.buttonIOSTheme,
        color: theme.colorScheme.primary,
        onPressed: () {
          injector.get<HapticUtil>().impact();
          this.onPressed();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          child: AutoSizeText(
            text,
            textAlign: TextAlign.center,
            maxFontSize: 24,
            minFontSize: 14,
            maxLines: 1,
            style: GoogleFonts.openSans().copyWith(
              color: (theme.colorScheme.onPrimary),
            ),
          ),
        ),
      ),
    );
  }
}
