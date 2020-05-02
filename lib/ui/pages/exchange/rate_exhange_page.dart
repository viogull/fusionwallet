import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fusion_wallet/localizations.dart';

class RateExchangePage extends StatefulWidget {
  static const String navId = '/RateExchangePage';
  @override
  _RateExchangePageState createState() => new _RateExchangePageState();
}

class _RateExchangePageState extends State<RateExchangePage> {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    final background = SvgPicture.asset(
      ('assets/images/backgrounds/bg_primary.svg'),
      fit: BoxFit.fill,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
    );

    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: <Widget>[
            background,
            Container(
              padding: EdgeInsets.only(
                left: 24.0,
                right: 24.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  AppBar(
                    title: Text(
                        AppLocalizations.of(context).toolbarExchangeTitle()),
                    backgroundColor: Colors.transparent,
                    centerTitle: true,
                    elevation: 0,
                    iconTheme: IconThemeData(
                        color: Theme.of(context).colorScheme.primary),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                          // top: BorderSide(width: 1, color: Colors.white),
                          bottom: BorderSide(width: 1, color: Colors.white)),
                    ),
                    margin: const EdgeInsets.only(
                        bottom: 10, top: 30, left: 22, right: 22),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Flexible(
                              flex: 1,
                              child: SizedBox(
                                width: 20,
                              ),
                            ),
                            Flexible(
                              flex: 1,
                              child: Text("Продажа"),
                            ),
                            Flexible(
                              flex: 1,
                              child: Text("Покупка"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
