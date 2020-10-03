


import 'package:auto_size_text/auto_size_text.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fusion_wallet/core/models/withdraw_invoice.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../localizations.dart';
import '../../theme.dart';

class InvoiceItem extends StatelessWidget {

  final WithdrawInvoice data;

  const InvoiceItem({this.data});


  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final width =  MediaQuery.of(context).size.width  * 0.95;
    final height = width * 0.45;

    var statusColor = Colors.yellow;

    final icon = (data.completed) ? Icon(FlutterIcons.check_ant, color: Colors.green) :
        Icon(FlutterIcons.error_mdi, color: Colors.red);

    if (data.status == 'rejected')
      statusColor = Colors.red;
    else if(data.status == 'accepted')
      statusColor = Colors.green;
    else
      statusColor = Colors.yellow;


    final date = DateTime.parse(data.createdAt);

    return Card(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        elevation: 4,
        shape: RoundedRectangleBorder(
            borderRadius: FusionTheme.borderRadius,
            side: BorderSide(
                color: colorScheme.onError, width: 0.1)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: ExpandablePanel(
          header:  Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              AutoSizeText("${data.qty.toString()}  ",  style: GoogleFonts.robotoCondensed(), minFontSize: 20,),
              AutoSizeText(data.coin, style: GoogleFonts.robotoCondensed(color: colorScheme.primary), minFontSize: 20,)
            ],
          ),
          collapsed: Text("${date.hour}:${date.minute}\n${date.day}.${date.month}.${date.year}",
            softWrap: true, maxLines: 2, overflow: TextOverflow.ellipsis,
          style: TextStyle(color: colorScheme.onSurface.withOpacity(0.4)),),
          expanded: Container(
              width: width,
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(FlutterIcons.arrow_up_evi, color: Colors.red),
                            Text("${data.qty.toString()}  "),
                            Text(data.coin)
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(FlutterIcons.arrow_down_evi, color: Colors.green),
                            Text(data.estimation.value.toStringAsPrecision(6) + "  "),
                            Text(data.fiatCurrency)
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text(AppLocalizations.of(context).invoiceStatusLabel(), style: GoogleFonts.cabinCondensed()),
                              Text("${data.status}", style: GoogleFonts.cabinCondensed(color: statusColor),),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Column(
                      children: [
                        AutoSizeText(AppLocalizations.of(context).cardLabelAddition()
                            + ' **${data.card.substring(13, 15)}', textAlign: TextAlign.end,),
                      ],
                    ),
                  )
                ],
              )),
          tapHeaderToExpand: true,
          hasIcon: true,
        ),
      ),
    );


  }
}