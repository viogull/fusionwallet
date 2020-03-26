import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_svg/svg.dart';

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
      color: Theme.of(context).primaryColor,
      elevation: 24,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: Column(
        children: <Widget>[
          new GridView.builder(
            itemCount: widget.items.length,
            shrinkWrap: true,
            padding: EdgeInsets.all(32),
            physics: BouncingScrollPhysics(),
            gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 16, crossAxisCount: 3, childAspectRatio: 3),
            itemBuilder: (BuildContext context, int index) {
              return new GestureDetector(
                child: new Card(
                  elevation: 0,
                  child: LimitedBox(
                    maxWidth: (MediaQuery.of(context).size.width / 7),
                    child: new Container(
                      color: (isSelected && _selected == index)
                          ? Theme.of(context).colorScheme.onPrimary
                          : Theme.of(context).primaryColor,
                      alignment: Alignment.center,
                      child: GestureDetector(
                        child: Container(
                          child: new Text(
                            widget.items[index],
                            maxLines: 1,
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.onPrimary),
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
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: SizedBox(
                    width: 22,
                    height: 22,
                    child: SvgPicture.asset(
                        "assets/images/icons/ic_qrcodescan.svg",
                        semanticsLabel: "assets/images/icons/ic_qrcodescan.svg",
                        color: Theme.of(context).colorScheme.onPrimary,
                        placeholderBuilder: (BuildContext context) => Container(
                            padding: const EdgeInsets.all(30.0),
                            child: PlatformCircularProgressIndicator())),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
