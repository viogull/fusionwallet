import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:fusion_wallet/localizations.dart';
import 'package:fusion_wallet/ui/widgets.dart';

class TermsConditionsPage extends StatefulWidget {
  static const String navId = '/TermsConditions';
  @override
  _TermsConditionsPageState createState() => new _TermsConditionsPageState();
}

class _TermsConditionsPageState extends State<TermsConditionsPage> {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

//    final buttonIcon = Align(
//      alignment: Alignment.bottomCenter,
//      child: Container(
//        width: MediaQuery.of(context).size.width * 0.8,
//        height: 50,
//        child: FusionButton(AppLocalizations.of(context).buttonShare(), () {}),
//      ),
//    );

    return FusionScaffold(
      title: AppLocalizations.of(context).toolbarTermsConditionsTitle(),
      child: Center(
        child: PlatformCircularProgressIndicator(),
      ),
    );
  }
}

//class MyCustomAppBar extends StatelessWidget implements PreferredSizeWidget {
//  final double height;
//  final bool defaultAppBar;
//
//  const MyCustomAppBar({
//    Key key,
//    @required this.height,
//    this.defaultAppBar = true,
//  }) : super(key: key);
//
//  @override
//  Widget build(BuildContext context) {
//    final ThemeData theme = Theme.of(context);
//    return Column(children: [
//      Container(
//        child: AppBar(
//          backgroundColor: Colors.transparent,
//          elevation: 0,
//          leading: IconButton(
//            onPressed: () {
//              Navigator.pop(context);
//            },
//            icon: SvgPicture.asset(
//              'assets/images/icons/ic_next.svg',
//              height: 24.0,
//            ),
//          ),
//          title: Text(
//            AppLocalizations.of(context).toolbarTermsConditionsTitle(),
//            style: TextStyle(
//              color: theme.colorScheme.onSurface,
//            ),
//          ),
//        ),
//      )
//    ]);
//  }
//
//  @override
//  Size get preferredSize => Size.fromHeight(height);
//}
