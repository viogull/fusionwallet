import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../localizations.dart';
import '../../widgets.dart';
import 'add_account_bloc.dart';
import 'add_account_events.dart';

class AddAccountIntroPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    final bg = Image.asset(
      ('assets/images/backgrounds/bg_greeting.png'),
      fit: BoxFit.fitHeight,
      height: MediaQuery.of(context).size.height * 1,
      width: MediaQuery.of(context).size.width,
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
          BlocProvider.of<AddAccountBloc>(context)
              .add(AddAccountCreateNewEvent());
        },
        expandedWidth: true,
      ),
    );

    final buttonRecoverFromPassphrase = Container(
      width: MediaQuery.of(context).size.width,
      child: FusionButton(
        text: AppLocalizations.of(context).buttonRecoverFromPassphrase(),
        onPressed: () {
          BlocProvider.of<AddAccountBloc>(context)
              .add(AddAccountFromRecoverEvent());
        },
        expandedWidth: true,
      ),
    );

    return FusionScaffold(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              bg,
              Container(
                color: Colors.transparent,
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
                      child: GestureDetector(
                        onDoubleTap: () {},
                        child: Container(
                          height: 20,
//      alignment: Alignment.topCenter,
                          child: Text(
                            AppLocalizations.of(context)
                                .labelAlreadyHaveAccount(),
                            style: TextStyle(
                              color: (theme.colorScheme.onSurface),
                            ),
                          ),
                        ),
                      ),
                      flex: 2,
                    ),
                    SizedBox(height: 5),
                    Flexible(flex: 5, child: buttonRecoverFromPassphrase),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: FusionButton(
                        text: AppLocalizations.of(context).buttonClose(),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        expandedWidth: true,
                      ),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ],
          ),
        ),
        hideToolbar: true);
  }
}
