import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import '../../../../localizations.dart';
import 'passphrase_widget.dart';

class PassphraseCreationPage extends StatefulWidget {
  static String navId = "/passphrase/creation";
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _PassphraseCreationPageState();
  }
}

class _PassphraseCreationPageState extends State<PassphraseCreationPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Flexible(
            flex: 1,
            child: new AppBar(
                centerTitle: true,
                backgroundColor: Colors.transparent,
                elevation: 0,
                iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
                title: new Text(
                  AppLocalizations.of(context).toolbarNewAccountTitle(),
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.onSurface),
                )),
          ),
          Flexible(
            flex: 1,
            child: Center(
              child: Text(
                  AppLocalizations.of(context).labelBackupPassphraseSubtitle()),
            ),
          ),
          Flexible(
            flex: 6,
            child: SizedBox.expand(
              child: Column(
                children: <Widget>[
                  PassphraseWidget(PassphraseWidget.templateData),
                ],
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Center(
              child: Card(
                child: Text(AppLocalizations.of(context)
                    .labelBackupPassphraseCaption()),
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Center(
              child: PlatformButton(
                child: Text(
                    AppLocalizations.of(context).buttonVerifyRecoveryPhrase()),
              ),
            ),
          )
        ],
      ),
    );
  }
}
