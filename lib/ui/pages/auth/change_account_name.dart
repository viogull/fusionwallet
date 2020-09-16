import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fusion_wallet/core/abstract/preferences.dart';
import 'package:fusion_wallet/core/models.dart';
import 'package:fusion_wallet/localizations.dart';
import 'package:fusion_wallet/ui/components/custom/button.dart';
import 'package:hive/hive.dart';

import '../../../inject.dart';
import '../../theme.dart';
import '../../widgets.dart';

class AccountNamingFormBloc extends FormBloc<String, String> {
  // ignore: close_sinks

  final logger = injector.get<Logger>();

  final accountName = TextFieldBloc();

  AccountNamingFormBloc() {
    addFieldBlocs(fieldBlocs: [accountName]);
    var initialName = Hive.box<Preferences>(preferencesBox).get(0).name;
    logger.d("Initial name: $initialName");
    accountName.updateInitialValue(initialName);
  }

  @override
  void onSubmitting() async {
    debugPrint("Saving ${accountName.value} name to settings.");
    Box<Preferences> prefs = Hive.box(preferencesBox);
    final preferences = prefs.getAt(0);

    if (accountName.value.isNotEmpty) {
      preferences.name = accountName.value;
      logger.d(
          "Current Account -> ${Hive.box<Account>(accountsBox).getAt(0).uuid}");
      preferences.save();
      emitSuccess();
    } else {
      emitFailure();
    }
  }
}

class ChangeAccountNameForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 16,
      child: SafeArea(
        bottom: true,
        top: true,
        minimum: const EdgeInsets.all(8),
        child: Container(
          color: Colors.transparent,
          child: BlocProvider(
            create: (context) => AccountNamingFormBloc(),
            child: Builder(
              builder: (context) {
                final bloc = context.bloc<AccountNamingFormBloc>();
                final theme = Theme.of(context);
                return FormBlocListener<AccountNamingFormBloc, String, String>(
                    onSubmitting: (context, state) {
                      LoadingDialog.show(context);
                    },
                    onSuccess: (context, state) {
                      LoadingDialog.hide(context);
                      FlashHelper.successBar(context,
                          message: AppLocalizations.of(context)
                              .flashOperationSuccess());
                      Navigator.of(context).pop();
                    },
                    onFailure: (context, state) {
                      LoadingDialog.hide(context);
                      FlashHelper.successBar(context,
                          message: state.failureResponse);
                    },
                    child: Material(
                        color: Colors.transparent,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              //LimitedBox (maxHeight: 60,),
                              SizedBox(
                                height: 10,
                              ),
                              // LimitedBox(maxHeight: 30,),
                              Flexible(
                                flex: 2,
                                child: Text(AppLocalizations.of(context)
                                    .menuItemEditAccountName()),
                              ),
                              Flexible(
                                  flex: 4,
                                  child: TextFieldBlocBuilder(
                                    textFieldBloc: bloc.accountName,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      labelText: AppLocalizations.of(context)
                                          .labelName(),
                                      prefixIcon: Icon(AntDesign.user),
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: theme.colorScheme.onSurface
                                                  .withOpacity(0.5)),
                                          borderRadius:
                                              FusionTheme.borderRadius),
                                    ),
                                  )),
                              //LimitedBox(maxHeight: 50,),
                              SizedBox(height: 5.0),
                              Flexible(
                                flex: 5,
                                child: FusionButton(
                                  expandedWidth: true,
                                  text:
                                      AppLocalizations.of(context).labelSave(),
                                  onPressed: () {
                                    bloc.submit();
                                  },
                                ),
                              )
                            ],
                          ),
                        )));
              },
            ),
          ),
        ),
      ),
    );
  }
}

class LoadingDialog extends StatelessWidget {
  static void show(BuildContext context, {Key key}) => showDialog<void>(
        context: context,
        useRootNavigator: false,
        barrierDismissible: false,
        builder: (_) => LoadingDialog(key: key),
      ).then((_) => FocusScope.of(context).requestFocus(FocusNode()));

  static void hide(BuildContext context) => Navigator.pop(context);

  LoadingDialog({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Center(
        child: Card(
          child: Container(
            width: 80,
            height: 80,
            padding: EdgeInsets.all(12.0),
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
