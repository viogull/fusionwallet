import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fusion_wallet/localizations.dart';
import 'package:fusion_wallet/ui/components/custom/fusion_button.dart';
import 'package:fusion_wallet/ui/components/custom/fusion_scaffold.dart';
import 'package:fusion_wallet/ui/pages/auth/terms_conditions_page.dart';

class AllFieldsFormBloc extends FormBloc<String, String> {

  final text1 = TextFieldBloc();


  AllFieldsFormBloc() {
    addFieldBlocs(fieldBlocs: [
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


class AccountCreationNamePage extends StatefulWidget {
  static const String navId = '/AccountCreationName';
  @override
  _AccountCreationNamePageState createState() =>
      new _AccountCreationNamePageState();
}

class _AccountCreationNamePageState extends State<AccountCreationNamePage> {
  bool _rememberMeFlag = false;
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);



    final logo = SvgPicture.asset(
      ('assets/images/icons/ic_man.svg'),
      placeholderBuilder: (context) => CircularProgressIndicator(),
      height: 200.0,
    );

    final text = Container(
      alignment: Alignment.topLeft,
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      child: Text(
        AppLocalizations.of(context).inputAccountNameHelperText(),
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
              child: Center(

                child: TextFieldBlocBuilder(
                  maxLines: 1,
                  textAlign: TextAlign.left,
                  textFieldBloc: formBloc.text1,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(0.0) ,
                    border: OutlineInputBorder(
//                    borderRadius: BorderRadius.zero,
                      borderSide: BorderSide.none,
                      gapPadding: 0.0,
                    ),
                    hintText: AppLocalizations.of(context).inputAccountNameHintText(),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
    final loginButton = Container(
      height: 50,
      width: MediaQuery.of(context).size.width,
      child: FusionButton(AppLocalizations.of(context).buttonNext(), () {}),
    );

    final checkBox = Container(
        margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                GestureDetector(
                  child: Row(
                    children: <Widget>[
                      Transform.scale(
                        scale: 1.8,
                        child: Checkbox(
                          checkColor: theme.colorScheme.onPrimary,
                          value: _rememberMeFlag,
                          onChanged: (value) => setState(() {
                            _rememberMeFlag = !_rememberMeFlag;
                          }),
                        ),
                      ),
                      SizedBox(width: 15.0),
                      GestureDetector(
                        child: Text(
                          AppLocalizations.of(context)
                              .checkboxTermsConditions(),
                          style: TextStyle(
                            color: (theme.colorScheme.onSurface),
                          ),
                        ),
                        onTap: () {
                          Navigator.pushNamed(
                              context, TermsConditionsPage.navId);
                        },
                      )
                    ],
                  ),
                  onTap: () => setState(() {
                    _rememberMeFlag = !_rememberMeFlag;
                  }),
                ),
              ],
            ),
          ],
        ));

    return FusionScaffold(
      title: AppLocalizations.of(context).toolbarNewAccountTitle(),
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
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[

                  //LimitedBox (maxHeight: 60,),
                  SizedBox(
                    height: 5,
                  ),
                  Flexible(
                    flex: 7,
                    child: logo,
                  ),
//                  SizedBox(height: 10 ,),
                  // LimitedBox(maxHeight: 30,),
                  Flexible(
                    flex: 4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        text,
                        emailTextField
                      ],
                    ),
                  ),

                  Flexible(
                    flex: 2,
                    child: checkBox,
                  ),

                  Flexible(
                    flex: 5,
                    child: loginButton,
                  ),
                  SizedBox(height: 5.0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


