import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../localizations.dart';
import '../../widgets.dart';

class AccessLockedUi extends StatelessWidget {
  static const navId = "/accessLocked";

  @override
  Widget build(BuildContext context) {
    return new FusionScaffold(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(AppLocalizations.of(context).accessBlocked(),
                    style: GoogleFonts.openSansCondensed(
                        fontSize: 20,
                        color: Theme.of(context).colorScheme.error),
                    textAlign: TextAlign.center),
              ),
            )),
        Flexible(
          flex: 8,
          child: GestureDetector(
            onTap: () {},
            child: Center(
              child: Image.asset(
                "assets/images/icon.png",
                width: 98,
                height: 98,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ],
    ));
  }
}
