import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fusion_wallet/localizations.dart';
import 'package:fusion_wallet/ui/components/custom/fusion_button.dart';
import 'package:fusion_wallet/ui/pages/auth/passphrase/share.dart';
import 'package:share/share.dart';

enum PassphraseWidgetState { SHOW, VERIFY }

class PassphraseWidget extends StatefulWidget {
  final List<String> items;
  final bool showOnlyMode;

  static var templateData = [
    "James Web",
    "Enterprise",
    "Hubble",
    "Kepler",
    "Juno",
    "Casini",
    "Columbia",
    "Challenger",
    "Huygens",
    "Galileo",
    "Apollo",
    "Spitzer",
    "WMAP",
    "Swift",
    "Atlantis",
    "Joe",
    "Barbaroe",
    "Hugo",
    "Davis",
    "John",
    "McCroy"
  ];

  PassphraseWidget(this.items, [this.showOnlyMode]);

  @override
  State<StatefulWidget> createState() {
    items.shuffle();
    return _PassphraseWidgetState();
  }
}

class _PassphraseWidgetState extends State<PassphraseWidget> {
  bool isSelectable = true;
  int _verificationStage = -1;

  int _selected = -1;

  String get mnemonicQrData => widget.items.join(" ");

  set(selectionIndex) {
    if (selectionIndex == _selected) _selected = -1;
  }

  @override
  Widget build(BuildContext context) {
    return (_verificationStage == -1)
        ? _buildPassphrasePage(context)
        : _buildQuestionPage(context, _verificationStage);
  }

  Widget _buildPassphrasePage(BuildContext context) {
    return Column(
      children: <Widget>[
        Flexible(
          flex: 2,
          child: Center(
            child: Text(
              AppLocalizations.of(context).labelBackupPassphraseSubtitle(),
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
        ),
        Flexible(
          flex: 8,
          child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
              child: Card(
                color: Theme.of(context).colorScheme.primary,
                elevation: 12,
                margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 16),
                child: Center(
                  child: LimitedBox(
                    child: Column(
                      children: <Widget>[
                        new GridView.builder(
                          itemCount: widget.items.length,
                          shrinkWrap: true,
                          padding: EdgeInsets.all(8),
                          physics: BouncingScrollPhysics(),
                          gridDelegate:
                              new SliverGridDelegateWithFixedCrossAxisCount(
                                  mainAxisSpacing: 12,
                                  crossAxisCount: 3,
                                  childAspectRatio: 3),
                          itemBuilder: (BuildContext context, int index) {
                            return new GestureDetector(
                              child: LimitedBox(
                                maxWidth:
                                    (MediaQuery.of(context).size.width / 7),
                                child: new Container(
                                  alignment: Alignment.center,
                                  child: GestureDetector(
                                    child: Container(
                                      child: new Text(
                                        widget.items[index],
                                        maxLines: 1,
                                        style: TextStyle(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onPrimary)
                                            .copyWith(fontSize: 12),
                                      ),
                                    ),
                                    onTap: () {
                                      setState(() {
                                        _selected = index;
                                      });
                                    },
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
                                      content: new Text(widget.items[index]),
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Flexible(
                              flex: 1,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                      new MaterialPageRoute(
                                          builder: (context) =>
                                              ViewPassphraseDialog(
                                                  data: mnemonicQrData),
                                          fullscreenDialog: true));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 24, bottom: 16),
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
                                          placeholderBuilder: (BuildContext
                                                  context) =>
                                              Container(
                                                  padding: const EdgeInsets.all(
                                                      30.0),
                                                  child:
                                                      PlatformCircularProgressIndicator())),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Flexible(
                              flex: 7,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: FlatButton.icon(
                                    onPressed: () {
                                      Share.share(this.widget.items.toString());
                                    },
                                    icon: Container(
                                      alignment: Alignment.center,
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
                                    label: Text(
                                      AppLocalizations.of(context)
                                          .buttonShare(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .button
                                          .copyWith(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onPrimary),
                                    )),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              )),
        ),
        Flexible(
          flex: 2,
          child: Center(
            child: Card(
              elevation: 12,
              color: Theme.of(context).colorScheme.surface,
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                child: Text(
                  AppLocalizations.of(context).labelBackupPassphraseCaption(),
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1
                      .copyWith(fontSize: 12),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ),
        Flexible(
          flex: 2,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: 50,
            child: FusionButton(
                text: AppLocalizations.of(context).buttonVerifyRecoveryPhrase(),
                onPressed: () {
                  setState(() {
                    _verificationStage++;
                  });
                }),
          ),
        )
      ],
    );
  }

  Widget _buildQuestionPage(BuildContext context, int questionIndex) {
    return Column(
      children: <Widget>[
        Flexible(
          flex: 1,
          child: Center(
            child: Text(
              AppLocalizations.of(context).labelQuestionIndicatorTitle(
                  _verificationStage.toString(), "3"),
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
        ),
        Flexible(
          flex: 1,
          child: Center(
            child: Text(
              AppLocalizations.of(context)
                  .labelWordIndicatorSubtitle(Random().nextInt(20)),
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
        ),
        Flexible(
          flex: 10,
          child: SizedBox.expand(
            child: Column(
              children: <Widget>[
                Card(
                  color: Theme.of(context).colorScheme.primary,
                  elevation: 24,
                  margin:
                      const EdgeInsets.symmetric(vertical: 2, horizontal: 16),
                  child: Column(
                    children: <Widget>[
                      new GridView.builder(
                        itemCount: widget.items.length,
                        shrinkWrap: true,
                        padding: EdgeInsets.all(8),
                        physics: BouncingScrollPhysics(),
                        gridDelegate:
                            new SliverGridDelegateWithFixedCrossAxisCount(
                                mainAxisSpacing: 12,
                                crossAxisCount: 3,
                                childAspectRatio: 3),
                        itemBuilder: (BuildContext context, int index) {
                          return new GestureDetector(
                            child: LimitedBox(
                              maxWidth: (MediaQuery.of(context).size.width / 7),
                              child: new Container(
                                alignment: Alignment.center,
                                child: GestureDetector(
                                  child: Container(
                                    child: new Text(
                                      widget.items[index],
                                      maxLines: 1,
                                      style: TextStyle(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onPrimary)
                                          .copyWith(fontSize: 12),
                                    ),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      _selected = index;
                                    });
                                  },
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
                                    content: new Text(widget.items[index]),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Flexible(
                            flex: 1,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                    new MaterialPageRoute(
                                        builder: (context) =>
                                            ViewPassphraseDialog(
                                              data: widget.items.toString(),
                                            ),
                                        fullscreenDialog: true));
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 24, bottom: 16),
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
                          ),
                          Flexible(
                            flex: 7,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: FlatButton.icon(
                                  onPressed: () {
                                    Share.share(this.widget.items.toString());
                                  },
                                  icon: Container(
                                    alignment: Alignment.center,
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
                                  label: Text(
                                    AppLocalizations.of(context).buttonShare(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .button
                                        .copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onPrimary),
                                  )),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        Flexible(
          flex: 1,
          child: Container(),
        ),
      ],
    );
  }
}
