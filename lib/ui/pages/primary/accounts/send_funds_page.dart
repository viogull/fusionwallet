import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fusion_wallet/localizations.dart';
import 'package:fusion_wallet/ui/fusion_scaffold.dart';

class SendFundsPage extends StatelessWidget {
  static const String navId = "/funds/send";

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return FusionScaffold(
      title: AppLocalizations.of(context).toolbarSendTitle(),
      child: Center(
        child: SvgPicture.asset("assets/images/icons/ic_bitcoin.svg"),
      ),
    );
  }
}
