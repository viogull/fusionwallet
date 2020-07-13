import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fusion_wallet/localizations.dart';
import 'package:fusion_wallet/core/state_container.dart';
import 'package:fusion_wallet/ui/theme.dart';
import 'package:fusion_wallet/ui/components/custom/fusion_button.dart';
import 'package:fusion_wallet/ui/components/custom/fusion_scaffold.dart';
import 'package:share/share.dart';

import '../../pages/auth/passphrase/share_qr_page.dart';

class PassphraseViewWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final words =
        StateContainer.of(context).selectedAccount.mnemonic.split(" ");
    return FusionScaffold(
        title: AppLocalizations.of(context).toolbarViewPasshraseTitle(),
        child: Expanded(
          child: Column(
            children: <Widget>[
              Flexible(
                  flex: 4,
                  child: Card(
                      color: Theme.of(context).colorScheme.primary,
                      elevation: 6,
                      shape: RoundedRectangleBorder(
                          borderRadius: FusionTheme.borderRadius),
                      margin: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 24),
                      child: LimitedBox(
                        maxHeight: 300,
                        child: Column(children: <Widget>[
                          Flexible(
                            flex: 8,
                            child: new GridView.builder(
                              itemCount: (words.length),
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
                                      child: GestureDetector(
                                        child: Container(
                                          child: new Text(
                                            words[index],
                                            maxLines: 1,
                                            style: TextStyle(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .onPrimary)
                                                .copyWith(
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w700),
                                          ),
                                        ),
                                        onTap: () {},
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
                          ),
                          Flexible(
                            flex: 8,
                            child: Container(),
                          ),
                          Flexible(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 1, horizontal: 4),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
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
                                                          data: StateContainer
                                                                  .of(context)
                                                              .selectedAccount
                                                              .mnemonic),
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
                                                            const EdgeInsets
                                                                .all(30.0),
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
                                              Share.share(
                                                  StateContainer.of(context)
                                                      .selectedAccount
                                                      .mnemonic);
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
                                            tooltip:
                                                AppLocalizations.of(context)
                                                    .buttonShare())),
                                  ]),
                            ),
                          ),
                        ]),
                      ))),
              Flexible(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: FusionButton(
                      text: AppLocalizations.of(context).labelOk(),
                      expandedWidth: true,
                      onPressed: () {
                        Navigator.of(context).pop();
                      }),
                ),
              )
            ],
          ),
        ));
  }
}
