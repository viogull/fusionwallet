import 'dart:ffi';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fusion_wallet/inject.dart';
import 'package:fusion_wallet/ui/theme.dart';
import 'package:fusion_wallet/utils/haptic.dart';
import 'package:google_fonts/google_fonts.dart';

typedef FusionButtonTapCallBack = void Function();

class FusionTextField extends StatelessWidget {
  final String text;
  final String value;
  final Widget icons;


  FusionTextField(
      {@required this.text,
        this.value,
        this.icons
      });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final fullWidth = MediaQuery.of(context).size.width ;


    final double height = 35;
    return Container(
      width: fullWidth,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: theme.colorScheme.primary),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Flexible(
            flex: 3,
            child: Row(
              children: <Widget>[
                _icon(context),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.02,
                ),

                AutoSizeText(
                  text,
                  textAlign: TextAlign.left,
                  maxFontSize: 20,
                  maxLines: 1,
                  style: GoogleFonts.openSans().copyWith(
                    color: (theme.colorScheme.onSurface),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 7,
          ),
          Flexible(
            flex: 1,
            child: AutoSizeText(
              value,
              textAlign: TextAlign.left,
              maxFontSize: 20,
              maxLines: 1,
              style: GoogleFonts.openSans().copyWith(
                color: (theme.colorScheme.onSurface),
              ),
            ),
          ),
        ],
      ),



    );
  }
}

@override
Widget _icon(BuildContext context) {
  final icon = "assets/images/icons/ic_bitcoin.svg";

  return SvgPicture.asset(
    icon,
    color: Theme.of(context).textTheme.bodyText1.color,
    fit: BoxFit.fill,
    height: 12,
    width: 12,
  );




}