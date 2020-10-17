import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fusion_wallet/localizations.dart';
import 'package:fusion_wallet/ui/components/custom/button.dart';
import 'package:fusion_wallet/ui/components/custom/scaffold.dart';

import 'bloc.dart';
import 'event.dart';

class IntroPage extends StatelessWidget {
  static const String navId = '/IntroPage';

  final bool additionalAccount;

  IntroPage({this.additionalAccount = false});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    final bg = Image.asset(
      ('assets/images/backgrounds/bg_greeting.png'),
      fit: BoxFit.cover,
      height: MediaQuery.of(context).size.height * 0.75,
      width: MediaQuery.of(context).size.width
    );

    final logo = Image.asset(('assets/images/icon.png'),
        fit: BoxFit.contain, height: 100.0, width: 100.0
        //width: MediaQuery.of(context).size.width,
        );

    final someText1 = GestureDetector(
        child: Container(
          height: 20,
//      alignment: Alignment.topCenter,
          child: Text(
            AppLocalizations.of(context).appName(),
            style: TextStyle(
              color: (theme.colorScheme.onPrimary),
            ),
          ),
        ),
        onTap: () {});

    final buttonCreateAccount = Container(
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

    final buttonRecoverFromPassphrase = Container(
      width: MediaQuery.of(context).size.width,
      child: FusionButton(
        text: AppLocalizations.of(context).buttonRecoverFromPassphrase(),
        onPressed: () {
          BlocProvider.of<AuthenticationBloc>(context)
              .add(AccountStartRecoverEvent());
        },
        expandedWidth: true,
      ),
    );

    return FusionScaffold(
        child: Stack(
      children: [
      bg,
      Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            SizedBox(height: 60),
            LimitedBox(maxHeight: 90),
            Flexible(
              child: logo,
              flex: 6,
            ),

            Flexible(
              flex: 6,
              child: someText1,
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 3),
           Padding(
             padding: const EdgeInsets.symmetric(vertical: 32,  horizontal: 20),
             child: Column(
               children: [
                 buttonCreateAccount,
                 Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: Text(
                     AppLocalizations.of(context)
                         .labelAlreadyHaveAccount(),
                     style: TextStyle(
                       color: (theme.colorScheme.onSurface),
                     ),
                   ),
                 ),
                 buttonRecoverFromPassphrase
               ],
             ),
           )
          ],
        ),
      ),
      ],
    ),
        hideToolbar: true);
  }
}
