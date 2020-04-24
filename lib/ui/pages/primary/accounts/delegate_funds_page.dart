import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../localizations.dart';
import '../../../fusion_scaffold.dart';

class DelegateFundsPage extends StatelessWidget {
  static const String navId = "/funds/delegate";

  @override
  Widget build(BuildContext context) {
    return FusionScaffold(
      title: AppLocalizations.of(context).toolbarSendTitle(),
      child: Center(
        child: SvgPicture.asset("assets/images/icons/ic_bitcoin.svg"),
      ),
    );
  }
}
