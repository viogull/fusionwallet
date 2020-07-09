import 'package:flutter/material.dart';
import 'package:fusion_wallet/localizations.dart';
import 'package:fusion_wallet/ui/components/custom/fusion_scaffold.dart';
import 'package:slide_popup_dialog/slide_dialog.dart';

class ChangeAccountNameDialog extends StatefulWidget {
  @override
  _ChangeAccountNameState createState() => new _ChangeAccountNameState();
}

class _ChangeAccountNameState extends State<ChangeAccountNameDialog> {
  final _formKey = GlobalKey<FormState>();

  final _accountNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    final nameForm = Form(
        key: _formKey,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: _accountNameController,
                validator: (value) {
                  if (value.isEmpty) {
                    return AppLocalizations.of(context)
                        .inputAccountNameHelperText();
                  }
                  return null;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText:
                      AppLocalizations.of(context).inputAccountNameHelperText(),
                  labelStyle: TextStyle(
                    color: (theme.colorScheme.onSurface),
                  ),
                ),
              )
            ]));

    return SafeArea(
        child: SlideDialog(
      backgroundColor: theme.colorScheme.surface,
      pillColor: theme.colorScheme.secondary,
      child: LimitedBox(
        maxHeight: 300,
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
              child:
                  Text(AppLocalizations.of(context).menuItemEditAccountName()),
            ),

            Flexible(
              flex: 4,
              child: nameForm,
            ),
            //LimitedBox(maxHeight: 50,),
            Flexible(
              flex: 5,
              child: RaisedButton(
                child: Text(AppLocalizations.of(context).labelSave()),
                onPressed: () {},
              ),
            ),
            SizedBox(height: 5.0),
          ],
        ),
      ),
    ));
  }

  @override
  void dispose() {
    _accountNameController.dispose();
    super.dispose();
  }
}
