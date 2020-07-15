import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fusion_wallet/core/abstract/preferences.dart';
import 'package:fusion_wallet/core/models.dart';
import 'package:fusion_wallet/localizations.dart';
import 'package:fusion_wallet/ui/components/custom/fusion_button.dart';
import 'package:fusion_wallet/ui/components/custom/fusion_scaffold.dart';
import 'package:hive/hive.dart';

class AccountNamingFormBloc extends FormBloc<String, String> {
  // ignore: close_sinks
  final accountName = TextFieldBloc();

  AccountNamingFormBloc() {
    addFieldBlocs(fieldBlocs: [accountName]);
  }

  @override
  void onSubmitting() async {
    debugPrint("Saving ${accountName.value} name to settings.");
    Box<Preferences> prefs = Hive.box(preferencesBox);
    final preferences = prefs.getAt(0);
    if (accountName.value.isNotEmpty) {
      preferences.name = accountName.value;
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
    return BlocProvider(
      create: (context) => AccountNamingFormBloc(),
      child: Builder(
        builder: (context) {
          final bloc = context.bloc<AccountNamingFormBloc>();

          return FormBlocListener<AccountNamingFormBloc, String, String>(
              onSubmitting: (context, state) {
                LoadingDialog.show(context);
              },
              onSuccess: (context, state) {
                LoadingDialog.hide(context);

                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) => SuccessScreen()));
              },
              onFailure: (context, state) {
                LoadingDialog.hide(context);

                Scaffold.of(context).showSnackBar(
                    SnackBar(content: Text(state.failureResponse)));
              },
              child: Material(
                  child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
                            labelText: AppLocalizations.of(context).labelName(),
                            prefixIcon: Icon(AntDesign.user),
                          ),
                        )),
                    //LimitedBox(maxHeight: 50,),
                    SizedBox(height: 5.0),
                    Flexible(
                      flex: 5,
                      child: FusionButton(
                        text: AppLocalizations.of(context).labelSave(),
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

class SuccessScreen extends StatelessWidget {
  SuccessScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.tag_faces, size: 100),
            SizedBox(height: 10),
            Text(
              'Success',
              style: TextStyle(fontSize: 54, color: Colors.black),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            RaisedButton.icon(
              onPressed: () {},
              icon: Icon(Icons.replay),
              label: Text('AGAIN'),
            ),
          ],
        ),
      ),
    );
  }
}
