import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fusion_wallet/localizations.dart';
import 'package:fusion_wallet/ui/components/custom/fusion_button.dart';
import 'package:fusion_wallet/ui/components/custom/fusion_scaffold.dart';
import 'package:fusion_wallet/ui/pages/auth/terms_and_conditions.dart';
import 'package:fusion_wallet/ui/pages/v2/bloc.dart';
import 'package:fusion_wallet/ui/pages/v2/event.dart';

import '../../../main.dart';
import 'intro.dart';

class AccountCreationNamePage extends StatefulWidget {
  static const String navId = '/AccountCreationName';
  @override
  _AccountCreationNamePageState createState() =>
      new _AccountCreationNamePageState();
}

class _AccountCreationNamePageState extends State<AccountCreationNamePage> {
  final _formKey = GlobalKey<FormState>();

  final _accountNameController = TextEditingController();

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

    final loginButton = Container(
      height: 50,
      width: MediaQuery.of(context).size.width,
      child: FusionButton(
          text: AppLocalizations.of(context).buttonNext(),
          onPressed: () {
            // Finishing account creation
            BlocProvider.of<AuthenticationBloc>(context).add(
                AccountNameCreatedEvent(name: _accountNameController.text));
          }),
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
                          Navigator.of(context).push(new MaterialPageRoute(
                              builder: (_) => TermsConditionsPage(),
                              fullscreenDialog: true));
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

    return SafeArea(
      child: FusionScaffold(
        title: AppLocalizations.of(context).menuItemEditAccountName(),
        child: Container(
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
                flex: 2,
                child: text,
              ),

              Flexible(
                flex: 4,
                child: nameForm,
              ),
              SizedBox(
                height: 15,
              ),
              // LimitedBox(maxHeight:30 ,),
              Flexible(
                flex: 2,
                child: checkBox,
              ),
              SizedBox(
                height: 10,
              ),
              //LimitedBox(maxHeight: 50,),
              Flexible(
                flex: 5,
                child: loginButton,
              ),
              SizedBox(height: 5.0),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _accountNameController.dispose();
    super.dispose();
  }
}
