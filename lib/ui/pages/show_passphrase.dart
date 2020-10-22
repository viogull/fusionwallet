import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fusion_wallet/ui/components/custom/button.dart';
import 'package:share/share.dart';

import '../../localizations.dart';
import '../widgets.dart';
import 'auth/share_passphrase.dart';

class ShowPassphraseUi extends StatelessWidget {
  final String mnemonic;

  const ShowPassphraseUi({this.mnemonic});

  @override
  Widget build(BuildContext context) {
    final words =
        StateContainer.of(context).selectedAccount.mnemonic.split(" ");
    return FusionScaffold(
      child: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Container(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: <
              Widget>[
            Flexible(
              flex: 1,
              child: Center(
                child: Text(
                  AppLocalizations.of(context).labelBackupPassphraseSubtitle(),
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1
                      .copyWith(fontSize: 15),
                ),
              ),
            ),
            Flexible(
                flex: 3,
                child: Card(
                    color: Theme.of(context).colorScheme.primary,
                    elevation: 6,
                    margin:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                    child: Column(children: <Widget>[
                      Container(height: 8, width: double.infinity),
                      new GridView.builder(
                        itemCount: (mnemonic.split(" ").length),
                        shrinkWrap: true,
                        padding: EdgeInsets.all(4),
                        physics: BouncingScrollPhysics(),
                        gridDelegate:
                            new SliverGridDelegateWithFixedCrossAxisCount(
                                mainAxisSpacing: 10,
                                crossAxisCount: 3,
                                childAspectRatio: 3),
                        itemBuilder: (BuildContext context, int index) {
                          return new GestureDetector(
                            child: LimitedBox(
                              maxWidth: (MediaQuery.of(context).size.width / 4),
                              child: new Container(
                                alignment: Alignment.center,
                                child: Bounce(
                                  duration: Duration(milliseconds: 400),
                                  child: Container(
                                    child: new AutoSizeText(
                                      words[index],
                                      maxLines: 1,
                                      style: TextStyle(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onPrimary)
                                          .copyWith(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                  onPressed: () {},
                                ),
                              ),
                            ),
                            onTap: () {
                              showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  child: new CupertinoAlertDialog(
                                    title: new Column(
                                      children: <Widget>[
                                        new Text("GridView"),
                                        new Icon(
                                          Icons.favorite,
                                          color: Colors.red,
                                        ),
                                      ],
                                    ),
                                    content: new Text(words[index]),
                                    actions: <Widget>[
                                      new FlatButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: new Text("OK"))
                                    ],
                                  ));
                            },
                          );
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 24),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Flexible(
                                flex: 1,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        new MaterialPageRoute(
                                            builder: (context) =>
                                                ViewPassphraseDialog(
                                                    data: mnemonic),
                                            fullscreenDialog: true));
                                  },
                                  child: Center(
                                    child: SizedBox(
                                      width: 24,
                                      height: 24,
                                      child: SvgPicture.asset(
                                          "assets/images/icons/ic_qr.svg",
                                          semanticsLabel:
                                              "assets/images/icons/ic_qr.svg",
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onPrimary,
                                          placeholderBuilder:
                                              (BuildContext context) => Container(
                                                  padding:
                                                      const EdgeInsets.all(30.0),
                                                  child:
                                                      PlatformCircularProgressIndicator())),
                                    ),
                                  ),
                                ),
                              ),
                              Flexible(
                                flex: 3,
                                child: Container(),
                              ),
                              Flexible(
                                  flex: 1,
                                  child: IconButton(
                                      onPressed: () {
                                        Share.share(mnemonic);
                                      },
                                      icon: SizedBox(
                                        width: 24,
                                        height: 24,
                                        child: SvgPicture.asset(
                                          "assets/images/icons/ic_shareicon.svg",
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onPrimary,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      tooltip: AppLocalizations.of(context)
                                          .buttonShare())),
                            ]),
                      ),
                    ]))),
            Flexible(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: Card(
                    elevation: 1,
                    color: Theme.of(context).colorScheme.surface,
                    margin:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 24),
                    child: Center(
                      child: Text(
                        AppLocalizations.of(context)
                            .labelBackupPassphraseCaption(),
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(fontSize: 10),
                        textAlign: TextAlign.center,
                      ),
                    )),
              ),
            ),
            Flexible(
              flex: 1,
              child: Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: FusionButton(
                      text: AppLocalizations.of(context).buttonClose(),
                      onPressed: () {
                        Navigator.of(context).pop();
                      }),
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
