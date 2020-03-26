import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fusion_wallet/localizations.dart';
import 'package:fusion_wallet/ui/components/custom/fusion_button.dart';
import 'package:fusion_wallet/ui/theme/fusion_theme.dart';

class TermsConditionsPage extends StatefulWidget {
  static const String navId = '/TermsConditions';
  @override
  _TermsConditionsPageState createState() => new _TermsConditionsPageState();
}

class _TermsConditionsPageState extends State<TermsConditionsPage> {
  bool _rememberMeFlag = false;
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    final background = SvgPicture.asset(
      ('assets/images/backgrounds/bg_primary.svg'),
      fit: BoxFit.fill,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
    );

    final buttonIcon = Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 1.2, color: Colors.white),
        color: theme.primaryColor,
      ),
      height: 70,
      width: 90,
      child: FusionButton(AppLocalizations.of(context).buttonShare(), () {}),
    );

    return Scaffold(
      body: Container(
        child: Stack(
          children: <Widget>[
            background,
            Container(
              padding: EdgeInsets.only(
                left: 24.0,
                right: 24.0,
              ),
              child: Column(
                children: <Widget>[
                  MyCustomAppBar(
                    height: 80,
                  ),
                  buttonIcon,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyCustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  final bool defaultAppBar;

  const MyCustomAppBar({
    Key key,
    @required this.height,
    this.defaultAppBar = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Column(
      children: [
        Container(
          child: Padding(
              padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
              child: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: SvgPicture.asset(
                    'assets/images/icons/ic_next.svg',
                    height: 25.0,
                  ),
                ),
                title: Text(
                  AppLocalizations.of(context).toolbarTermsConditionsTitle(),
                  style: TextStyle(
                      color: (theme.brightness == Brightness.dark)
                          ? FusionTheme.dark.colorScheme.onPrimary
                          : FusionTheme.light.colorScheme.onPrimary),
                ),
              )),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
