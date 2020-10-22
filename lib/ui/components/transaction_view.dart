import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fusion_wallet/core/pojo/transactions_response.dart';
import 'package:fusion_wallet/utils/io_tools.dart';
import 'package:fusion_wallet/utils/numbers.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../inject.dart';
import '../theme.dart';

class TransactionView extends StatelessWidget {
  final Transaction  transaction;
  final String requestedAddress;

  const TransactionView({this.transaction, this.requestedAddress});

  @override
  Widget build(BuildContext context) {
    bool isReceiving;
    if (transaction.data.to == requestedAddress)
      isReceiving = true;
    else
      isReceiving = false;
    var type;



    launchURL(url) async {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }
    return GestureDetector(
      onTap: () async {
        injector.get<HapticUtil>().success();
        FlashHelper.infoBar(context, message: "Link with transaction info was copied to clipboard.");
        final comment = "https://explorer.minter.network/transactions/${transaction.hash}";

        IOTools.setSecureClipboardItem(comment);
      },
      onLongPress: () async  {
        final comment = "https://explorer.minter.network/transactions/${transaction.hash}";
        debugPrint("Tx Url -> $comment");
        await launchURL(comment);

      },
      child: Card(
        elevation: 4,
        color: Theme.of(context).colorScheme.surface,
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 0.2, color: Colors.white),
          borderRadius: FusionTheme.borderRadius,
        ),
        margin: const EdgeInsets.symmetric(vertical:4, horizontal: 8),
        child:Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          child: Row(
            children: [
              Flexible(
                flex: 12,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        AutoSizeText(
                          this.transaction.from.substring(0, 12),
                          textAlign: TextAlign.start,
                          style: GoogleFonts.notoSans(fontWeight: FontWeight.bold),
                        ),



                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    LimitedBox(
                      maxWidth: MediaQuery.of(context).size.width * 0.6,
                      child: Row(
                        children: <Widget>[
                          Container(
                            child: AutoSizeText(
                              this.transaction.timestamp,
                              maxFontSize: 12,
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(
                flex: 8,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
      Padding(
        padding: const EdgeInsets.all(4.0),
        child: SvgPicture.asset(
        ('assets/images/icons/ic_bitcoin.svg'),
        // color: Colors.white,
        fit: BoxFit.fill,
        height: 12,
        width: 12,
        ),
      ),
                      AutoSizeText(
                        this.transaction.data.value == null
                            ? "0.00"
                            : NumberUtil.sanitizeNumber(
                            this.transaction.data.value, maxDecimalDigits: 6),

                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: (isReceiving) ? Colors.green : Colors.red),
                      ),
                      AutoSizeText(
                        this.transaction.data.coin == null
                            ? " BIP"
                            : " ${this.transaction.data.coin.symbol}",
                        maxFontSize: 12,
                        textAlign: TextAlign.end,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
