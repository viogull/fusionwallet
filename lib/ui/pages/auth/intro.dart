import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fusion_wallet/localizations.dart';
import 'package:fusion_wallet/ui/components/custom/fusion_button.dart';
import 'package:fusion_wallet/ui/components/custom/fusion_scaffold.dart';

import 'package:fusion_wallet/ui/pages/auth/recover_account_page.dart';
import 'package:fusion_wallet/ui/pages/v2/bloc.dart';
import 'package:fusion_wallet/ui/pages/v2/event.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: IntroPage(),
    ));

class IntroPage extends StatelessWidget {
  static const String navId = '/IntroPage';
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    final logo = Image.asset(
      ('assets/images/icon.png'),
      fit: BoxFit.fill,
      height: 100.0,
      //width: MediaQuery.of(context).size.width,
    );

    final someText1 = Container(
      height: 20,
//      alignment: Alignment.topCenter,
      child: Text(
        "Some greeting text",
        style: TextStyle(
          color: (theme.colorScheme.onPrimary),
        ),
      ),
    );

    final someText2 = Container(
//      alignment: Alignment.topCenter,
      height: 20,
      child: Text(
        "Some greeting text",
        style: TextStyle(
          color: (theme.colorScheme.onPrimary),
        ),
      ),
    );

    final buttonCreateAccount = Container(
      height: 50,
      width: MediaQuery.of(context).size.width,
      child: FusionButton(
        text: AppLocalizations.of(context).buttonCreateAccount(),
        onPressed: () {
          BlocProvider.of<AuthenticationBloc>(context)
              .add(AccountCreateWalletEvent());
        },
        expandedWidth: true,
      ),
    );

    final labelAlreadyHaveAccount = Container(
      height: 20,
//      alignment: Alignment.topCenter,
      child: Text(
        AppLocalizations.of(context).labelAlreadyHaveAccount(),
        style: TextStyle(
          color: (theme.colorScheme.onSurface),
        ),
      ),
    );

    final buttonRecoverFromPassphrase = Container(
      height: 50,
      width: MediaQuery.of(context).size.width,
      child: FusionButton(
        text: AppLocalizations.of(context).buttonRecoverFromPassphrase(),
        onPressed: () {
          Navigator.of(context).pushNamed(RecoverAccountPage.navId);
        },
        expandedWidth: true,
      ),
    );

    return FusionScaffold(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          SizedBox(height: 60),
          LimitedBox(maxHeight: 90),
          Flexible(
            child: logo,
            flex: 6,
          ),
          SizedBox(height: 20),
          Flexible(
            child: someText2,
            flex: 2,
          ),
          SizedBox(height: 20),
          Flexible(
            flex: 4,
            child: someText1,
          ),
          SizedBox(height: 180),
          LimitedBox(maxHeight: 230),
          Flexible(
            child: buttonCreateAccount,
            flex: 5,
          ),
          SizedBox(height: 5),
          Flexible(
            child: labelAlreadyHaveAccount,
            flex: 2,
          ),
          SizedBox(height: 5),
          Flexible(flex: 5, child: buttonRecoverFromPassphrase),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
