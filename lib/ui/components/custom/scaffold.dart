import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fusion_wallet/core/state_container.dart';
import 'package:google_fonts/google_fonts.dart';

typedef AppBarBackButtonCallback = void Function(String destination);

class FusionScaffold extends StatelessWidget {
  final Widget child;
  final String title;
  final Drawer drawer;
  final AppBar appBar;
  final AppBarBackButtonCallback onBackClicked;
  final Widget appBarIcon;

  final bool hideDrawer;
  final bool hideToolbar;


  final Widget fab;

  FusionScaffold(
      {@required this.child,
      this.title,
      this.drawer,
      this.appBar,
      Container body,
      this.onBackClicked,
      this.hideDrawer = true,
      this.hideToolbar = false,
      this.appBarIcon,
      this.fab});

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
          bottom: false,
          maintainBottomViewPadding: true,
          top:false,
          child: Scaffold(
            backgroundColor: Colors.transparent,
            drawer: drawer,
            drawerEnableOpenDragGesture: true,
            appBar: _buildToolbar(context),
            resizeToAvoidBottomInset: true,
            floatingActionButton: (fab),
            body: child,
          ),
        ),
      ],
    );
  }

  Widget _buildDefaultAppBar(BuildContext context) {
    final theme = Theme.of(context);
    return AppBar(
      elevation: 0,
      automaticallyImplyLeading: true,
      backgroundColor: Colors.transparent,
      iconTheme: IconThemeData(color: theme.colorScheme.primary),
      centerTitle: true,
      leading: appBarIcon,
      title: (title == null)
          ? null
          : AutoSizeText(
              title,
              maxFontSize: 20,
              minFontSize: 17,
              style: GoogleFonts.robotoTextTheme()
                  .headline6
                  .copyWith(color: theme.colorScheme.onSurface, fontSize: 18),
            ),
    );
  }

  _buildToolbar(BuildContext context) {
    if (hideToolbar) {
      return null;
    } else {
      return this.appBar != null ? this.appBar : _buildDefaultAppBar(context);
    }
  }
}
