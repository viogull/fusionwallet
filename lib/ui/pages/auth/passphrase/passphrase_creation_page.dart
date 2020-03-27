import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fusion_wallet/ui/components/custom/fusion_button.dart';

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
  int _verificationStage = -1;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: SvgPicture.asset(
              "assets/images/backgrounds/bg_primary.svg",
              fit: BoxFit.fill,
            ),
          ),
          PlatformScaffold(
            backgroundColor: Colors.transparent,
            appBar: PlatformAppBar(
              android: (_) => MaterialAppBarData(
                  centerTitle: true,
                  elevation: 0,
                  iconTheme: IconThemeData(
                      color: Theme.of(context).colorScheme.primary),
                  backgroundColor: Colors.transparent),
              title: Text(
                (_verificationStage == -1)
                    ? AppLocalizations.of(context).toolbarNewAccountTitle()
                    : "",
                style:
                    TextStyle(color: Theme.of(context).colorScheme.onSurface),
              ),
            ),
            body: _buildPassphraseView(context),
          )
        ],
      ),
    );
  }

  Widget _buildPassphraseView(BuildContext context) {
    if (this._verificationStage == -1) {
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
            flex: 14,
            child: SizedBox.expand(
              child: Column(
                children: <Widget>[
                  PassphraseWidget(PassphraseWidget.templateData),
                ],
              ),
            ),
          ),
          Flexible(
            flex: 2,
            child: Center(
              child: Card(
                elevation: 12,
                color: Theme.of(context).colorScheme.surface,
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
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
                  AppLocalizations.of(context).buttonVerifyRecoveryPhrase(),
                  () {
                setState(() {
                  _verificationStage++;
                });
              }),
            ),
          )
        ],
      );
    } else
      return _buildPassphraseQuestion(context);
  }

  Widget _buildPassphraseQuestion(BuildContext context) {
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
                  .labelWordIndicatorSubtitle(Random().nextInt(21).toString()),
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
        ),
        Flexible(
          flex: 12,
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
          child: Container(),
        ),
      ],
    );
  }
}
