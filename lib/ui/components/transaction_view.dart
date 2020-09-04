import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fusion_wallet/core/models/transaction.dart';
import 'package:fusion_wallet/utils/numbers.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme.dart';

class TransactionView extends StatelessWidget {
  final Transaction transaction;
  final String requestedAddress;

  const TransactionView({this.transaction, this.requestedAddress});

  @override
  Widget build(BuildContext context) {
    bool isReceiving;
    if (transaction.data.to == requestedAddress)
      isReceiving = true;
    else
      isReceiving = false;

    return Card(
      borderOnForeground: false,
      elevation: 4,
      color: Theme.of(context).colorScheme.surface,
      shape: RoundedRectangleBorder(
        side: BorderSide(width: 0.2, color: Colors.white),
        borderRadius: FusionTheme.borderRadius,
      ),
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              height: 8,
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  AutoSizeText(
                    this.transaction.from.substring(0, 12),
                    textAlign: TextAlign.start,
                    style: GoogleFonts.notoSans(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3,
                  ),
                  SvgPicture.asset(
                    ('assets/images/icons/ic_bitcoin.svg'),
                    // color: Colors.white,
                    fit: BoxFit.fill,
                    height: 12,
                    width: 12,
                  ),
                  Row(
                    children: [
                      AutoSizeText(
                        this.transaction.data.value == null
                            ? "0.00"
                            : NumberUtil.sanitizeNumber(
                                this.transaction.data.value),
                        minFontSize: 12,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: (isReceiving) ? Colors.green : Colors.red),
                      ),
                      AutoSizeText(
                        this.transaction.data.coin == null
                            ? " BIP"
                            : " ${this.transaction.data.coin}",
                        minFontSize: 12,
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: <Widget>[
                Container(
                  child: AutoSizeText(
                    this.transaction.timestamp,
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
