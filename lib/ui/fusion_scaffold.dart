import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fusion_wallet/localizations.dart';
import 'package:google_fonts/google_fonts.dart';

import 'theme/fusion_theme.dart';

class FusionScaffold extends StatelessWidget {
  final Widget child;
  final String title;

  FusionScaffold({@required this.child, this.title});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Stack(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SvgPicture.asset(
            "assets/images/backgrounds/bg_primary.svg",
            fit: BoxFit.fill,
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: NestedScrollView(
              physics: const BouncingScrollPhysics(),
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverOverlapAbsorber(
                    handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                        context),
                    sliver: SliverAppBar(
                      elevation: 4,
                      stretch: true,
                      floating: true,
                      pinned: false,
                      primary: true,
                      automaticallyImplyLeading: (title != null),
                      backgroundColor: Colors.transparent,
                      centerTitle: true,
                      title: (title == null) ? null : AutoSizeText(
                        title,
                        style: GoogleFonts.notoSans()
                            .copyWith(color: theme.colorScheme.onSurface),
                      ),
                    ),
                  ),
                ];
              },
              body: child),
        )
      ],
    );
  }
}
