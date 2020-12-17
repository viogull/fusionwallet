import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fusion_wallet/core/models.dart';
import 'package:fusion_wallet/localizations.dart';
import 'package:fusion_wallet/ui/components/custom/button.dart';
import 'package:fusion_wallet/ui/pages/convert.dart';
import 'package:fusion_wallet/ui/pages/rates.dart';
import 'package:fusion_wallet/utils/numbers.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../inject.dart';
import '../widgets.dart';

class ExchangePage extends StatelessWidget {
  static const String navId = '/ExchangePage';

  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Container(
      height: MediaQuery
          .of(context)
          .size
          .height,
      width: MediaQuery
          .of(context)
          .size
          .width,
      child: Container(
        padding: EdgeInsets.only(
          left: 24.0,
          right: 24.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            //LimitedBox (maxHeight: 60,),
            Flexible(
              flex: 1,
              child: Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                child: Text(
                  AppLocalizations.of(context).labelExchangeCoins(),
                  style: TextStyle(
                    color: (theme.colorScheme.onSurface),
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 4,
              child: Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                child: FutureBuilder(
                  future: injector.get<MinterRest>().fetchAddressData(address: StateContainer.of(context).selectedAccount.address),
                  builder: (context, snaphot) {
                    if(snaphot.connectionState == ConnectionState.waiting) {
                      return Center(child: PlatformCircularProgressIndicator());
                    } else if(snaphot.connectionState == ConnectionState.done && snaphot.hasData == true) {
                      final data = snaphot.data as AddressData;
                      List<Widget> balances = List();
                      data.data.balances.forEach((element) {
                        balances.add( Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: theme.colorScheme.primary),
                            ),
                            child: Center(
                              child: LimitedBox(
                                maxWidth: MediaQuery
                                    .of(context)
                                    .size
                                    .width,
                                maxHeight: 35,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 6, horizontal: 4),
                                  child: GestureDetector(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: <Widget>[
                                        Flexible(
                                          flex: 3,
                                          child:  Container(
                                            child: Row(
                                              children: <Widget>[
                                                SvgPicture.asset(
                                                  ('assets/images/icons/ic_bitcoin.svg'),
                                                  // color: Colors.white,
                                                 height: 16,
                                                  width: 16,
                                                ),
                                                SizedBox(
                                                  width: MediaQuery
                                                      .of(context)
                                                      .size
                                                      .width *
                                                      0.02,
                                                ),
                                                Text(
                                                  element.coin.symbol,
                                                  style: GoogleFonts.robotoCondensed(color: theme.colorScheme.onBackground, fontSize: 18),
                                                  textAlign: TextAlign.left,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 7,
                                        ),
                                        Flexible(
                                          flex: 2,
                                          child: Text(
                                           NumberUtil.sanitizeNumber(element.amount),
                                            textAlign: TextAlign.right,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),);
                      });
                      return Expanded(
                        child: Column(
                          children: balances,
                        ),
                      );
                    } else {
                      return PlatformCircularProgressIndicator();
                    }
                  },
                ),
              ),
            ),

            Flexible(
              flex:4,
              child: Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                child: FusionButton(
                    text: AppLocalizations.of(context).buttonConvert(),
                    onPressed: () async {
                      Navigator.of(context).pushNamed(ConvertPage.navId);
                    }),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Flexible(
              flex: 2,
              child: Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                child: FusionButton(
                    text: AppLocalizations.of(context).buttonRate(),
                    onPressed: () {
                      Navigator.pushNamed(context, RateExchangePage.navId);
                    }),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Flexible(
              flex: 2,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Flexible(
                      flex: 1,
                      child: Text(
                          AppLocalizations.of(context).labelExchangeUseCash(),
                          style: TextStyle(
                            color: (theme.colorScheme.onSurface),

                          ),
                        ),

                    ),
                    Flexible(
                      flex: 1,
                      child: Container(
                        alignment: Alignment.centerRight,
                        child: FusionButton(
                            text: AppLocalizations.of(context).buttonBuy(),
                            onPressed: () {

                            }),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Flexible(
              flex: 2,
              child: Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Flexible(
                      flex:  1,
                      child: Container(
                        alignment: Alignment.centerLeft,
                        margin:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                        child: Text(
                          AppLocalizations.of(context).labelExchangeSimplex(),
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: (theme.colorScheme.onSurface),
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                        flex: 1,
                      child: Container(
                        alignment: Alignment.centerRight,
                        child: FusionButton(
                            text: AppLocalizations.of(context).buttonBuy(),
                            onPressed: () {}),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 60,
            ),
          ],
        ),
      ),
    );
  }
}
