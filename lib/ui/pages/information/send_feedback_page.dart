import 'package:flutter/cupertino.dart';
import 'package:fusion_wallet/ui/components/custom/fusion_scaffold.dart';

import '../../../localizations.dart';

class SendFeedbackPage extends StatelessWidget {
  static const navId = "/feedback";

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FusionScaffold(
      child: Container(),
      title: AppLocalizations.of(context).settingsItemSendFeedback(),
    );
  }
}
