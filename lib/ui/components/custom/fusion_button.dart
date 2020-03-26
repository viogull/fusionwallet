




import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fusion_wallet/ui/theme/fusion_theme.dart';

typedef FusionButtonTapCallBack = void Function();

class FusionButton extends StatelessWidget{

  final String text;
  final FusionButtonTapCallBack onPressed;
  final Icon icons;

  FusionButton(this.text, [this.onPressed, this.icons]);



  @override
  Widget build(BuildContext context) {

    final ThemeData theme = Theme.of(context);
    return
      Container(

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.white),
        ),
         child:  PlatformButton(

            android: (_) => FusionTheme.buttonAndroidTheme,
            ios: (_) => FusionTheme.buttonIOSTheme,
            color: theme.primaryColor,
            onPressed: this.onPressed,


           child: Text(text,
                style: TextStyle(color: (theme.brightness == Brightness.dark)?
                FusionTheme.dark.colorScheme.onPrimary: FusionTheme.light.colorScheme.onPrimary),),





),
    );

  }
}