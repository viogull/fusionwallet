import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fusion_wallet/localizations.dart';
import 'package:fusion_wallet/ui/pages/auth/passphrase/share_qr_page.dart';
import 'package:share/share.dart';

enum PassphraseWidgetState { SHOW, VERIFY }

class PassphraseWidget extends StatefulWidget {
  final List<String> items;

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

  PassphraseWidget(this.items);

  @override
  State<StatefulWidget> createState() {
    items.shuffle();
    return _PassphraseWidgetState();
  }
}

class _PassphraseWidgetState extends State<PassphraseWidget> {
  int _selected = -1;
  set(selectionIndex) {
    if (selectionIndex == _selected) _selected = -1;
  }

  @override
  Widget build(BuildContext context) {
    bool isSelected = (_selected > 0) ? true : false;

    return Card(
      color: Theme.of(context).colorScheme.primary,
      elevation: 24,
      margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 16),
      child: Column(
        children: <Widget>[
          new GridView.builder(
            itemCount: widget.items.length,
            shrinkWrap: true,
            padding: EdgeInsets.all(8),
            physics: BouncingScrollPhysics(),
            gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 12, crossAxisCount: 3, childAspectRatio: 3),
            itemBuilder: (BuildContext context, int index) {
              return new GestureDetector(
                child: LimitedBox(
                  maxWidth: (MediaQuery.of(context).size.width / 7),
                  child: new Container(
                    color: (isSelected && _selected == index)
                        ? Theme.of(context).colorScheme.onPrimary
                        : Theme.of(context).colorScheme.primary,
                    alignment: Alignment.center,
                    child: GestureDetector(
                      child: Container(
                        child: new Text(
                          widget.items[index],
                          maxLines: 1,
                          style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary)
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
                    Navigator.of(context).push(new MaterialPageRoute(
                        builder: (context) => PassphraseShareQrPage(),
                        fullscreenDialog: true));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 24, bottom: 16),
                    child: Center(
                      child: SizedBox(
                        width: 24,
                        height: 24,
                        child: SvgPicture.asset("assets/images/icons/ic_qr.svg",
                            semanticsLabel: "assets/images/icons/ic_qr.svg",
                            color: Theme.of(context).colorScheme.onPrimary,
                            placeholderBuilder: (BuildContext context) =>
                                Container(
                                    padding: const EdgeInsets.all(30.0),
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
                        Share.share(this.widget.items.toString(),
                            subject: AppLocalizations.of(context)
                                .toolbarSharePasshpraseQr()
                                .toString());
                      },
                      icon: Container(
                        alignment: Alignment.center,
                        width: 24,
                        height: 24,
                        child: SvgPicture.asset(
                          "assets/images/icons/ic_shareicon.svg",
                          color: Theme.of(context).colorScheme.onPrimary,
                          fit: BoxFit.fill,
                        ),
                      ),
                      label: Text(
                        AppLocalizations.of(context).buttonShare(),
                        style: Theme.of(context).textTheme.button.copyWith(
                            color: Theme.of(context).colorScheme.onPrimary),
                      )),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
