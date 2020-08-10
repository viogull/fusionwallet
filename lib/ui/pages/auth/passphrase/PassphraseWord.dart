import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PassphraseWordWidget extends StatelessWidget {
  final String word;

  PassphraseWordWidget(this.word);

  @override
  Widget build(BuildContext context) {
    return LimitedBox(
      maxWidth: 100,
      maxHeight: 100,
      child: AutoSizeText(word,
          style:
              GoogleFonts.lato().copyWith(fontSize: 12, color: Colors.white)),
    );
  }
}
