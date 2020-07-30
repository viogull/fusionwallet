import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fusion_wallet/localizations.dart';
import 'package:fusion_wallet/ui/components/custom/fusion_button.dart';
import 'package:fusion_wallet/ui/components/custom/fusion_text_field.dart';
import 'package:fusion_wallet/ui/pages/auth/account_name.dart';
import 'package:fusion_wallet/ui/pages/auth/intro.dart';

import 'package:fusion_wallet/ui/pages/auth/pincode.dart';
import 'package:fusion_wallet/ui/pages/auth/recover_account_page.dart';
import 'package:fusion_wallet/ui/pages/exchange/convert_funds_page.dart';
import 'package:fusion_wallet/ui/pages/exchange/rate_exhange_page.dart';

class ExchangePage extends StatefulWidget {
  static const String navId = '/ExchangePage';
  @override
  _ExchangePageState createState() => new _ExchangePageState();
}

class _ExchangePageState extends State<ExchangePage> {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);



    final myCoinLabel = Container(
      alignment: Alignment.topLeft,
      margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 00.0),
      child: Text(
        AppLocalizations.of(context).labelExchangeCoins(),
        style: TextStyle(
          color: (theme.colorScheme.onSurface),
        ),
      ),
    );

    final currency1 =
    FusionTextField(
      text: "Currency 1", value: "0.00",
    );
    final currency2 =
    FusionTextField(
      text: "Currency 2", value: "0.00",
    );

    final currency3 =
        FusionTextField(
          text: "Currency 3", value: "0.00",
        );

    final convertButton = Container(
      height: 50,
      width: MediaQuery.of(context).size.width,
      child: FusionButton(text: AppLocalizations.of(context).buttonConvert(), onPressed: () {
        Navigator.pushNamed(context, ConvertExchangePage.navId);
      }),
    );

    final rateButton = Container(
      height: 50,
      width: MediaQuery.of(context).size.width,
      child: FusionButton(text: AppLocalizations.of(context).buttonRate(), onPressed: () {
        Navigator.pushNamed(context, RateExchangePage.navId);
      }),
    );

    final cashBalance = Center(
      child: Text(
        AppLocalizations.of(context).labelExchangeUseCash(),
        style: TextStyle(
          color: (theme.colorScheme.onSurface),
        ),
      ),
    );

    final simplex = Container(
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
      child: Text(
        AppLocalizations.of(context).labelExchangeSimplex(),
        style: TextStyle(
          color: (theme.colorScheme.onSurface),
        ),
      ),
    );

    final buyButton1 = Container(
      height: 50,
      width: MediaQuery.of(context).size.width * 0.30,
      child: FusionButton(text: AppLocalizations.of(context).buttonBuy(),onPressed: () {
        Navigator.pushNamed(context, IntroPage.navId);
      }),
    );

    final buyButton2 = Container(
      height: 50,
      width: MediaQuery.of(context).size.width * 0.30,
      child: FusionButton(text: AppLocalizations.of(context).buttonBuy(), onPressed: () {}),
    );

    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
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
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  myCoinLabel,
                  currency1,
                  currency2,
                  currency3
                ],
              ),
            ),
            Flexible(
              flex: 1,
              child: convertButton,
            ),
            SizedBox(
              height: 10,
            ),
            Flexible(
              flex: 1,
              child: rateButton,
            ),
            SizedBox(
              height: 10,
            ),
            Flexible(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  cashBalance,
                  buyButton1,
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Flexible(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  simplex,
                  buyButton2,
                ],
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