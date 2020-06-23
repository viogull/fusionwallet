import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fusion_wallet/localizations.dart';
import 'package:fusion_wallet/ui/components/custom/fusion_button.dart';
import 'package:fusion_wallet/ui/pages/auth/password_creation_page.dart';
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

    final currency1 = Container(
      margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: theme.colorScheme.primary),
      ),
      height: 30.0,
      child: Center(
        child: LimitedBox(
          maxWidth: MediaQuery.of(context).size.width,
          maxHeight: 35,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
            child: GestureDetector(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Flexible(
                    flex: 3,
                    child: Row(
                      children: <Widget>[
                        SvgPicture.asset(
                          ('assets/images/icons/ic_bitcoin.svg'),
                          // color: Colors.white,
                          fit: BoxFit.fill,
                          height: 12,
                          width: 12,
                          // height: MediaQuery.of(context).size.height,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.02,
                        ),
                        Text(
                          "Currency 1 ",
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 7,
                  ),
                  Flexible(
                    flex: 1,
                    child: Text(
                      '0.00',
                      textAlign: TextAlign.right,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    final currency2 = Container(
      margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: theme.colorScheme.primary),
      ),
      height: 30.0,
      child: Center(
        child: LimitedBox(
          maxWidth: MediaQuery.of(context).size.width,
          maxHeight: 35,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
            child: GestureDetector(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Flexible(
                    flex: 3,
                    child: Row(
                      children: <Widget>[
                        SvgPicture.asset(
                          ('assets/images/icons/ic_bitcoin.svg'),
                          // color: Colors.white,
                          fit: BoxFit.fill,
                          height: 12,
                          width: 12,
                          // height: MediaQuery.of(context).size.height,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.02,
                        ),
                        Text(
                          "Currency 2 ",
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 7,
                  ),
                  Flexible(
                    flex: 1,
                    child: Text(
                      '0.00',
                      textAlign: TextAlign.right,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    final currency3 = Container(
      margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: theme.colorScheme.primary),
      ),
      height: 30.0,
      child: Center(
        child: LimitedBox(
          maxWidth: MediaQuery.of(context).size.width,
          maxHeight: 35,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
            child: GestureDetector(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Flexible(
                    flex: 3,
                    child: Row(
                      children: <Widget>[
                        SvgPicture.asset(
                          ('assets/images/icons/ic_bitcoin.svg'),
                          // color: Colors.white,
                          fit: BoxFit.fill,
                          height: 12,
                          width: 12,
                          // height: MediaQuery.of(context).size.height,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.02,
                        ),
                        Text(
                          "Currency 3 ",
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 7,
                  ),
                  Flexible(
                    flex: 1,
                    child: Text(
                      '0.00',
                      textAlign: TextAlign.right,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    final convertButton = Container(
      height: 50,
      width: MediaQuery.of(context).size.width,
      child: FusionButton(AppLocalizations.of(context).buttonConvert(), () {
        Navigator.pushNamed(context, ConvertExchangePage.navId);
      }),
    );

    final rateButton = Container(
      height: 50,
      width: MediaQuery.of(context).size.width,
      child: FusionButton(AppLocalizations.of(context).buttonRate(), () {
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
      margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 00.0),
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
      child: FusionButton(AppLocalizations.of(context).buttonBuy(), () {
        Navigator.pushNamed(context, PasswordCreationPage.navId);
      }),
    );

    final buyButton2 = Container(
      height: 50,
      width: MediaQuery.of(context).size.width * 0.30,
      child: FusionButton(AppLocalizations.of(context).buttonBuy(), () {}),
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
                  flex: 1,
                  child: myCoinLabel,
                ),
                Flexible(
                  flex: 1,
                  child: currency1,
                ),
                Flexible(
                  flex: 1,
                  child: currency2,
                ),
                Flexible(
                  flex: 1,
                  child: currency3,
                ),
                SizedBox(
                  height: 15,
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
