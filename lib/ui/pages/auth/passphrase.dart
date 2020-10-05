import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fusion_wallet/core/minter_channel.dart';
import 'package:fusion_wallet/core/state_container.dart';
import 'package:fusion_wallet/ui/components/custom/button.dart';
import 'package:fusion_wallet/ui/components/custom/scaffold.dart';
import 'package:fusion_wallet/ui/pages/auth/account_name.dart';
import 'package:fusion_wallet/ui/pages/popups/dialog.dart';
import 'package:fusion_wallet/ui/theme.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:share/share.dart';

import '../../../inject.dart';
import '../../../localizations.dart';
import '../pages.dart';
import 'event.dart';
import 'share_passphrase.dart';

class PassphraseCreationPage extends StatefulWidget {
  static String navId = "/passphrase/creation";

  @override
  State<StatefulWidget> createState() {
    return _PassphraseCreationPageState();
  }
}

class _PassphraseCreationPageState extends State<PassphraseCreationPage> {
  int _verificationStage;

  @override
  void initState() {
    if (_verificationStage == null) _verificationStage = -1;
    super.initState();

    debugPrint('Init Passphrase Screen, stage $_verificationStage}');

    if (_verificationStage > 2) {
      Navigator.of(context).pushNamed(AccountCreationNameForm.navId);
    }
  }

  List<String> cachedWords;
  String cachedMnemonic;
  String cachedPublicKey;
  String cachedSeed;
  String cachedAddress;
  String cachedPrivateKey;

  @override
  Widget build(BuildContext context) {
    return FusionScaffold(
        //title: AppLocalizations.of(context).toolbarSharePasshpraseQr(),
        hideToolbar: false,
        child: (this._verificationStage < 0)
            ? _showPassphraseView(context)
            : _showPassphraseQuestions(
                context, cachedMnemonic, this._verificationStage));
  }

  Widget _showPassphraseView(BuildContext context) => FutureBuilder(
      future: injector.get<MinterChannel>().generateAddressData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          List<String> words;
          String mnemonic = (snapshot.data['mnemonic'] as String);
          if (mnemonic != null) {
            words = mnemonic.split(" ");
            cachedSeed = (snapshot.data['seed'] as String);
            cachedAddress = (snapshot.data['address'] as String);
            cachedPublicKey = (snapshot.data['public_key'] as String);
            cachedPrivateKey = (snapshot.data['private_key'] as String);
          }

          return Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: <
                    Widget>[
              Flexible(
                flex: 1,
                child: Center(
                  child: Text(
                    AppLocalizations.of(context)
                        .labelBackupPassphraseSubtitle(),
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
                      margin: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 16),
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
                                maxWidth:
                                    (MediaQuery.of(context).size.width / 4),
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
                                    onPressed: () {
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
                                            placeholderBuilder: (BuildContext
                                                    context) =>
                                                Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            30.0),
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
                      margin: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 24),
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
                        text: AppLocalizations.of(context)
                            .buttonVerifyRecoveryPhrase(),
                        onPressed: () {
                          setState(() {
                            _verificationStage++;
                            cachedMnemonic = mnemonic;
                            cachedWords = words;
                          });
                        }),
                  ),
                ),
              )
            ]),
          );
        } else
          return Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: PlatformCircularProgressIndicator(),
                ),
                Text(AppLocalizations.of(context).generatingWalletMessage())
              ],
            ),
          );
      });

  Widget _showPassphraseQuestions(
      BuildContext context, String mnemonic, int verificationStage) {
    final originWords = mnemonic.split(" ");
    final randomPosition = Random().nextInt(originWords.length);
    final shuffledWords = new List();
    shuffledWords.addAll(originWords);
    shuffledWords.shuffle();
//    beyond river whale six edit tiger inner member cover govern erase beyond
    return Column(children: <Widget>[
      Flexible(
        flex: 3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                AppLocalizations.of(context).labelQuestionIndicatorTitle(
                    (_verificationStage + 1).toString(), "3"),
                textAlign: TextAlign.center,
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
                    .labelWordIndicatorSubtitle(randomPosition + 1),
                textAlign: TextAlign.center,
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
          flex: 12,
          child: Card(
              elevation: 0,
              color: Colors.transparent,
              margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 16),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new GridView.builder(
                      itemCount: originWords.length,
                      shrinkWrap: true,
                      padding: EdgeInsets.all(4),
                      physics: BouncingScrollPhysics(),
                      gridDelegate:
                          new SliverGridDelegateWithFixedCrossAxisCount(
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
                                          borderRadius:
                                              FusionTheme.borderRadius,
                                          child: Container(
                                            width: (MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                4.5),
                                            height: 50,
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 2, horizontal: 2),
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                            child: Center(
                                              child: Card(
                                                color: Colors.transparent,
                                                elevation: 0,
                                                borderOnForeground: false,
                                                child: Container(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .primary,
                                                  width: 75,
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 4,
                                                        horizontal: 12),
                                                    child: new AutoSizeText(
                                                      shuffledWords[index],
                                                      maxFontSize: 12,
                                                      maxLines: 1,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .onPrimary,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ))
                                    ],
                                  ),
                                )),
                            onTap: () async {
                              // isolate mansion armor helmet have empty visit water analyst matter cactus cancel

                              debugPrint(
                                  "Tapped Index [ $index on word ${shuffledWords[index]}");

                              final tappedWord = shuffledWords[index];
                              final expectableWord =
                                  originWords[randomPosition];
                              debugPrint(
                                  "Selected [$tappedWord], expect. $expectableWord");

                              if (tappedWord == expectableWord) {
                                if (_verificationStage == 2) {
                                  StateContainer.of(context)
                                      .persistPassphrase(mnemonic);
                                  final blocCtx = context;
                                  FlashHelper.successBar(
                                    context,
                                    message: AppLocalizations.of(context)
                                        .copiedSuccesfullyMessage(),
                                  );
                                  Navigator.of(context)
                                      .push(new MaterialPageRoute(
                                          builder: (_) => PopupDialogWidget(
                                                title: AppLocalizations.of(
                                                        context)
                                                    .popupPassVerifiedTitle(),
                                                subtitle: AppLocalizations.of(
                                                        context)
                                                    .popupPassVerifiedBody(),
                                                asset:
                                                    "assets/images/icons/ic_verified.svg",
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                  BlocProvider.of<
                                                              AuthenticationBloc>(
                                                          blocCtx)
                                                      .add(PassphraseVerifiedEvent(
                                                          mnemonic: mnemonic,
                                                          seed: cachedSeed,
                                                          address:
                                                              cachedAddress,
                                                          publicKey:
                                                              cachedPublicKey,
                                                          privateKey:
                                                              cachedAddress));
                                                },
                                              ),
                                          fullscreenDialog: true));
                                } else {
                                  setState(() {
                                    _verificationStage = _verificationStage + 1;
                                  });
                                }
                              } else {
                                FlashHelper.errorBar(context,
                                    message: AppLocalizations.of(context)
                                        .flashIncorrectWordMessage());
                                if (_verificationStage > 0) {
                                  FlashHelper.errorBar(context,
                                      message: AppLocalizations.of(context)
                                          .flashIncorrectWordMessage());
//                                  setState(() {
//                                    _verificationStage = -1;
//                                  });
                                }
                              }
                            });
                      },
                    ),
                  ]))),
      Flexible(
        // major smooth alarm moon sport multiply radar badge palace head payment ready
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
