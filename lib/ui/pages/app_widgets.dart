import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fusion_wallet/ui/blocs/theme_bloc.dart';
import 'package:fusion_wallet/ui/theme/fusion_theme.dart';
import 'package:fusion_wallet/ui/theme/theme_event.dart';
import 'package:fusion_wallet/utils/prefs.dart';

import '../../localizations.dart';
import 'auth/passphrase/passphrase_widget.dart';
import 'popups/popup_page.dart';

class AppWidgetsPage extends StatelessWidget {
  static String navId = "/widgets";
  final Prefs prefs = Prefs();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
      ),
      body: SizedBox.expand(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SwitchListTile.adaptive(
              value: false,
              onChanged: (value) async {
                BlocProvider.of<ThemeBloc>(context).add(ThemeChanged(
                    theme: (value == true)
                        ? FusionThemes.dark
                        : FusionThemes.light));
              },
              title: Text(AppLocalizations.of(context).settingsItemUiTheme()),
            ),
            PassphraseWidget(PassphraseWidget.templateData),
            Padding(
              padding: const EdgeInsets.all(4),
              child: RaisedButton(
                child: Text('Show Verification Popup'),
                onPressed: () {
                  // ignore: missing_return
                  Navigator.of(context).push(new MaterialPageRoute(
                      builder: (context) {
                        return PopupDialogWidget(
                            AppLocalizations.of(context)
                                .popupPassVerifiedTitle(),
                            "assets/images/icons/ic_verified.svg",
                            AppLocalizations.of(context)
                                .popupPassVerifiedBody());
                      },
                      fullscreenDialog: true));
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4),
              child: RaisedButton(
                child: Text('Show Modal Popup'),
                onPressed: () {
                  // ignore: missing_return
                  showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Container(
                          height: 400,
                          width: double.infinity,
                          child: Container(),
                        );
                      });
                },
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(4),
                child: ButtonBar(
                  children: <Widget>[
                    FlatButton(
                      child: Text('English'),
                      onPressed: () {},
                    ),
                    FlatButton(
                      child: Text('Russian'),
                      onPressed: () {},
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
