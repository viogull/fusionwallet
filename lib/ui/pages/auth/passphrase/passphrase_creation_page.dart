import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fusion_wallet/ui/components/custom/fusion_button.dart';
import 'package:fusion_wallet/ui/pages/auth/account_creation_page.dart';
import 'package:fusion_wallet/ui/pages/auth/passphrase/passphrase_widget.dart';
import 'package:fusion_wallet/ui/theme/fusion_theme.dart';
import 'package:share/share.dart';

import '../../../../localizations.dart';
import 'share_qr_page.dart';

class PassphraseCreationPage extends StatefulWidget {
  static String navId = "/passphrase/creation";
  final List<String> items = PassphraseWidget.templateData;

  @override
  State<StatefulWidget> createState() {
    return _PassphraseCreationPageState();
  }
}

class _PassphraseCreationPageState extends State<PassphraseCreationPage> {
  int _verificationStage;

  bool _isConfirmed = false;

  @override
  void initState() {
    if (_verificationStage == null) _verificationStage = -1;
    super.initState();

    debugPrint('Init Passphrase Screen, stage $_verificationStage}');

    if (_verificationStage > 2) {
      Navigator.of(context).pushNamed(AccountCreationNamePage.navId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SvgPicture.asset(
            "assets/images/backgrounds/bg_primary.svg",
            fit: BoxFit.fill,
          ),
        ),
        Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              title: Text(
                  AppLocalizations.of(context).toolbarRecoverFromSeedTitle()),
              backgroundColor: Colors.transparent,
              centerTitle: true,
              elevation: 0,
              iconTheme:
                  IconThemeData(color: Theme.of(context).colorScheme.primary),
            ),
            body: (this._verificationStage < 0)
                ? _showPassphraseView(context)
                : _showPassphraseQuestions(context, this._verificationStage))
      ],
    );
  }

  Widget _showPassphraseView(BuildContext context) => Column(children: <Widget>[
        Flexible(
          flex: 1,
          child: Center(
            child: Text(
              AppLocalizations.of(context).labelBackupPassphraseSubtitle(),
              style:
                  Theme.of(context).textTheme.subtitle1.copyWith(fontSize: 12),
            ),
          ),
        ),
        Flexible(
            flex: 10,
            child: Card(
                color: Theme.of(context).colorScheme.primary,
                elevation: 16,
                margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 16),
                child: Column(children: <Widget>[
                  new GridView.builder(
                    itemCount: widget.items.length,
                    shrinkWrap: true,
                    padding: EdgeInsets.all(4),
                    physics: BouncingScrollPhysics(),
                    gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
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
                                setState(() {});
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
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 2, horizontal: 24),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Flexible(
                            flex: 1,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                    new MaterialPageRoute(
                                        builder: (context) =>
                                            PassphraseShareQrPage(),
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
                                    Share.share(widget.items.toString(),
                                        subject: AppLocalizations.of(context)
                                            .toolbarSharePasshpraseQr()
                                            .toString());
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
                elevation: 4,
                color: Theme.of(context).colorScheme.surface,
                margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                child: Center(
                  child: Text(
                    AppLocalizations.of(context).labelBackupPassphraseCaption(),
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
          flex: 2,
          child: Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: 50,
              child: FusionButton(
                  AppLocalizations.of(context).buttonVerifyRecoveryPhrase(),
                  () {
                setState(() {
                  _verificationStage = _verificationStage + 1;
                });
              }),
            ),
          ),
        )
      ]);

  Widget _showPassphraseQuestions(BuildContext context, int verificationStage) {
    final randomPosition = Random().nextInt(widget.items.length);
    debugPrint(
        'Current question for index position $randomPosition, predictable choice -> ${widget.items[randomPosition]}');
    return Column(children: <Widget>[
      Flexible(
        flex: 3,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                AppLocalizations.of(context).labelQuestionIndicatorTitle(
                    (_verificationStage + 1).toString(), "3"),
                style: Theme.of(context)
                    .textTheme
                    .subtitle1
                    .copyWith(fontSize: 14),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                AppLocalizations.of(context)
                    .labelWordIndicatorSubtitle(randomPosition),
                style: Theme.of(context)
                    .textTheme
                    .subtitle1
                    .copyWith(fontSize: 14),
              ),
            )
          ],
        ),
      ),
      Flexible(
          flex: 10,
          child: Card(
              elevation: 0,
              color: Theme.of(context).colorScheme.surface,
              margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 16),
              child: Column(children: <Widget>[
                new GridView.builder(
                  itemCount: widget.items.length,
                  shrinkWrap: true,
                  padding: EdgeInsets.all(4),
                  physics: BouncingScrollPhysics(),
                  gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: 12,
                      crossAxisCount: 3,
                      childAspectRatio: 3),
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                        child: Container(
                            alignment: Alignment.center,
                            child: GestureDetector(
                              child: Stack(
                                children: <Widget>[
                                  ClipRRect(
                                      borderRadius: FusionTheme.borderRadius,
                                      child: Container(
                                        width:
                                            (MediaQuery.of(context).size.width /
                                                5),
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 2, horizontal: 2),
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        child: new Text(
                                          widget.items[index],
                                          maxLines: 1,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onPrimary,
                                          ).copyWith(fontSize: 12),
                                        ),
                                      ))
                                ],
                              ),
                            )),
                        onTap: () async {
                          debugPrint("Tapped on word ${widget.items[index]}");
                          if (index == randomPosition) {
                            if (_verificationStage == 2) {
                              Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text('Succesfully saved passhprase'),
                              ));
                              Navigator.of(context)
                                  .pushNamed(AccountCreationNamePage.navId);
                            } else {
                              setState(() {
                                _verificationStage = _verificationStage + 1;
                              });
                            }
                          } else {
                            if (_verificationStage > 0) {
                              Scaffold.of(context).showSnackBar(SnackBar(
                                content:
                                    Text('Incorrect word. Please try again'),
                              ));
                              setState(() {
                                _verificationStage = -1;
                              });
                            }
                          }
                        });
                  },
                ),
              ]))),
      Flexible(
        flex: 1,
        child: Container(),
      ),
      Flexible(
        flex: 2,
        child: Center(),
      ),
    ]);
  }
}
