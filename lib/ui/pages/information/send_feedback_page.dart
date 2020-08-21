import 'package:flutter/cupertino.dart';
import 'package:fusion_wallet/ui/components/custom/fusion_scaffold.dart';

import '../../../localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:fusion_wallet/localizations.dart';

import 'package:fusion_wallet/ui/components/custom/fusion_button.dart';

import '../pages.dart';

class SendFeedbackPage extends StatefulWidget {
  static const navId = "/feedback";
  @override
  _SendFeedbackPageState createState() => new _SendFeedbackPageState();
}

class _SendFeedbackPageState extends State<SendFeedbackPage> {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    final typeOfFeetback = BlocProvider(
      create: (context) => AllFieldsFormBloc(),
      child: Builder(
        builder: (context) {
          final formBloc = BlocProvider.of<AllFieldsFormBloc>(context);

          return FormBlocListener<AllFieldsFormBloc, String, String>(
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: theme.colorScheme.primary),
              ),
              height: 40.0,
              child: Container(
                margin: EdgeInsets.only(left: 24),
                child: DropdownFieldBlocBuilder<String>(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(0.0),
                    border: OutlineInputBorder(
//                    borderRadius: BorderRadius.zero,
                      borderSide: BorderSide.none,
                      gapPadding: 0.0,
                    ),
                  ),
                  selectFieldBloc: formBloc.typeOf,
                  itemBuilder: (context, value) => value,
                ),
              ),
            ),
          );
        },
      ),
    );

    final accountName = Container(
      alignment: Alignment.topLeft,
      margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 24.0),
      child: Text(
        AppLocalizations.of(context).labelAccount(),
        style: TextStyle(
          color: (theme.colorScheme.onSurface),
        ),
      ),
    );

    final noteLabel = Container(
      alignment: Alignment.topLeft,
      margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 24.0),
      child: Text(
        AppLocalizations.of(context).labelFeedbackNoteTitle(),
        style: TextStyle(
          color: (theme.colorScheme.onSurface),
        ),
      ),
    );

    final noteTextField = BlocProvider(
      create: (context) => AllFieldsFormBloc(),
      child: Builder(
        builder: (context) {
          final formBloc = BlocProvider.of<AllFieldsFormBloc>(context);

          return FormBlocListener<AllFieldsFormBloc, String, String>(
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: theme.colorScheme.primary),
              ),
              height: 180.0,
              child: Container(
                margin: EdgeInsets.only(
                  left: 24,
                ),
                child: TextFieldBlocBuilder(
                  minLines: 8,
                  maxLines: 15,
                  textAlign: TextAlign.start,
                  textFieldBloc: formBloc.text1,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(0.0),
                    border: OutlineInputBorder(
//                    borderRadius: BorderRadius.zero,
                      borderSide: BorderSide.none,
                      gapPadding: 0.0,
                    ),
                    hintText:
                        AppLocalizations.of(context).inputFeedbackCommentHint(),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );

    final emailLabel = Container(
      alignment: Alignment.topLeft,
      margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 24.0),
      child: Text(
        AppLocalizations.of(context).labelFeedbackEmailSubtitle(),
        style: TextStyle(
          color: (theme.colorScheme.onSurface),
        ),
      ),
    );

    final emailTextField = BlocProvider(
      create: (context) => AllFieldsFormBloc(),
      child: Builder(
        builder: (context) {
          final formBloc = BlocProvider.of<AllFieldsFormBloc>(context);

          return FormBlocListener<AllFieldsFormBloc, String, String>(
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: theme.colorScheme.primary),
              ),
              height: 40.0,
              child: Container(
                margin: EdgeInsets.only(left: 24),
                child: TextFieldBlocBuilder(
                  maxLines: 1,
                  textAlign: TextAlign.left,
                  textFieldBloc: formBloc.text1,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(0.0),
                    border: OutlineInputBorder(
//                    borderRadius: BorderRadius.zero,
                      borderSide: BorderSide.none,
                      gapPadding: 0.0,
                    ),
                    hintText: AppLocalizations.of(context)
                        .labelFeedbackEmailSubtitle(),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );

    final sendButton = Container(
      height: 50,
      width: MediaQuery.of(context).size.width,
      child: FusionButton(
          text: AppLocalizations.of(context).buttonSend(),
          onPressed: () {
            Navigator.pushNamed(context, AddContactPage.navId);
          }),
    );

    return FusionScaffold(
      title: AppLocalizations.of(context).settingsItemSendFeedback(),
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(
                left: 24.0,
                right: 24.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  //LimitedBox (maxHeight: 60,),
                  Flexible(
                    flex: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        accountName,
                        typeOfFeetback,
                      ],
                    ),
                  ),
                  Flexible(
                    flex: 5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        noteLabel,
                        noteTextField,
                      ],
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        emailLabel,
                        emailTextField,
                      ],
                    ),
                  ),

                  Flexible(
                    flex: 3,
                    child: sendButton,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AllFieldsFormBloc extends FormBloc<String, String> {
  final typeOf = SelectFieldBloc(
    items: ['Type of Feedback'],
  );
  final text1 = TextFieldBloc();

  AllFieldsFormBloc() {
    addFieldBlocs(fieldBlocs: [
      typeOf,
      text1,
    ]);
  }

  @override
  void onSubmitting() async {
    try {
      await Future<void>.delayed(Duration(milliseconds: 500));

      emitSuccess(canSubmitAgain: true);
    } catch (e) {
      emitFailure();
    }
  }
}
