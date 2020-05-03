import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fusion_wallet/state_container.dart';

class FusionScaffold extends StatelessWidget {
  final Widget child;
  final String title;
  final Drawer drawer;
  final SliverAppBar appBar;

  FusionScaffold({@required this.child, this.title, this.drawer, this.appBar});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    debugPrint(theme.toString());
    final background = StateContainer.of(context).darkModeEnabled
        ? "assets/images/backgrounds/bg_primary.svg"
        : "assets/images/backgrounds/bg_primary_light.svg";

    return Stack(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SvgPicture.asset(
            background,
            fit: BoxFit.fill,
          ),
        ),
        SafeArea(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            drawer: drawer,
            body: SafeArea(
              child: NestedScrollView(
                  headerSliverBuilder:
                      (BuildContext context, bool innerBoxIsScrolled) {
                    return <Widget>[
                      SliverOverlapAbsorber(
                          handle:
                              NestedScrollView.sliverOverlapAbsorberHandleFor(
                                  context),
                          sliver: (appBar == null)
                              ? buildDefaultAppBar(theme)
                              : appBar),
                    ];
                  },
                  body: child),
            ),
          ),
        )
      ],
    );
  }

  Widget buildDefaultAppBar(ThemeData theme) => SliverAppBar(
        elevation: 4,
        stretch: true,
        floating: true,
        pinned: false,
        primary: true,
        automaticallyImplyLeading: (title != null),
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: theme.colorScheme.primary),
        centerTitle: true,
        title: (title == null)
            ? null
            : AutoSizeText(
                title,
                style: theme.textTheme.headline6
                    .copyWith(color: theme.colorScheme.onSurface, fontSize: 17),
              ),
      );
}
