import 'package:flutter/material.dart';
import 'package:fusion_wallet/localizations.dart';

import '../../fusion_scaffold.dart';

class FaqPage extends StatelessWidget {
  static const navId = "/faq";

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FusionScaffold(
      child: Container(),
      title: AppLocalizations.of(context).settingsItemFaq(),
    );
  }
}
