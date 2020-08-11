import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:fusion_wallet/localizations.dart';
import 'package:fusion_wallet/ui/widgets.dart';

class TermsConditions extends StatefulWidget {
  static const String navId = '/TermsConditions';
  @override
  _TermsConditionsState createState() => new _TermsConditionsState();
}

class _TermsConditionsState extends State<TermsConditions> {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);


    return FusionScaffold(
      title: AppLocalizations.of(context).toolbarTermsConditionsTitle(),
      child: Center(
        child: PlatformCircularProgressIndicator(),
      ),
    );
  }
}
