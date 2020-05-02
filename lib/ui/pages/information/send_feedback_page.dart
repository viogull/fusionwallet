import 'package:flutter/cupertino.dart';

import '../../../localizations.dart';
import '../../fusion_scaffold.dart';

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
