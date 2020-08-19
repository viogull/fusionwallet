
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fusion_wallet/core/models/transaction.dart';
import 'package:fusion_wallet/core/models/transanctions_response.dart';

import '../../../localizations.dart';
import '../../theme.dart';

class TransactionsView extends StatelessWidget {
  final TransactionsResponse data;

  TransactionsView({@required this.data});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * 0.5;
    return Card(
      child: Container(
        width: 500,
        height: 300,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: AutoSizeText(
                AppLocalizations.of(context).labelTransanctionsHistoryTitle(),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                child: ListView.builder(itemBuilder: (context, index) => _buildItem(transaction: data.data[index], ), itemCount: data.data.length,)
            )
          ],
        ),
      ),
    );

  }


  Widget _buildItem({BuildContext context, @required Transaction transaction}) {
    final cardWidth = MediaQuery.of(context).size.width * 0.95;
    final cardHeight = cardWidth * 0.15;

    return Card(
      elevation: 3,
      color: Theme.of(context).colorScheme.surface,
      shape: RoundedRectangleBorder(borderRadius: FusionTheme.borderRadius),
      child: Container(
        width: cardWidth,
        height: cardHeight,
        padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Flexible(
              flex: 4,
              child: Text(transaction.data.to),
            ),
            Flexible(
                flex: 1,
                child: Row(
                  children: [
                    SizedBox(
                      width: 16,
                      height: 16,
                      child: SvgPicture.asset(
                          "assets/images/icons/ic_bitcoin.svg",
                          color: Theme.of(context)
                              .colorScheme
                              .onBackground,
                          placeholderBuilder: (BuildContext context) => Container(
                              padding: const EdgeInsets.all(24.0),
                              child: PlatformCircularProgressIndicator())),
                    ),
                    AutoSizeText(transaction.data.value)
                  ],
                )
            )
          ],
        ),
      ),
    );
  }
}
