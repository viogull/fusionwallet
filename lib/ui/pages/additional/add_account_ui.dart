import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'add_account_bloc.dart';
import 'add_account_intro.dart';
import 'add_account_mnemonic.dart';
import 'add_account_name.dart';
import 'add_account_recover.dart';
import 'add_account_states.dart';

class AddAccountUi extends StatelessWidget {
  AddAccountUi({
    Key key,
  }) : super(key: key);
  static const navId = "/add_account";

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => AddAccountBloc(),
        child: BlocBuilder<AddAccountBloc, AddAccountState>(
          builder: (context, state) {
            debugPrint("Current State -> $state");
            if (state is AddAccountInitialState) {
              return AddAccountIntroPage();
            }
            if (state is AddAccountRecoveryState) {
              return AddAccountRecoveryPage();
            }
            if (state is AddAccountMnemonicState) {
              return AddAccountMnemonicPage();
            }
            if (state is AddAccountNameState) {
              return AddAccountNamePage();
            } else if (state is AddAccountFinishedState) {
              Navigator.of(context).pop();
            } else
              return AddAccountIntroPage();
          },
        ));
  }
}
