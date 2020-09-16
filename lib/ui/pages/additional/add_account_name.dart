import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fusion_wallet/localizations.dart';
import 'package:fusion_wallet/ui/components/custom/button.dart';
import 'package:fusion_wallet/ui/components/custom/scaffold.dart';
import 'package:fusion_wallet/ui/pages/auth/conditions.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:styled_text/styled_text.dart';

import '../../theme.dart';
import '../pages.dart';
import 'add_account_bloc.dart';
import 'add_account_events.dart';

class AccountNamingFormBloc extends FormBloc<String, String> {
  final accountName = TextFieldBloc();

  final applyTermsBloc = BooleanFieldBloc();

  AccountNamingFormBloc() {
    addFieldBlocs(fieldBlocs: [accountName, applyTermsBloc]);
  }

  @override
  void onSubmitting() async {
    if (applyTermsBloc.value) {
      debugPrint("Saving ${accountName.value} name to settings.");
      if (accountName.value.isNotEmpty) {
        emitSuccess(successResponse: accountName.value);
      } else {
        emitFailure();
      }
    }
  }
}

class AddAccountNamePage extends StatelessWidget {
  static const navId = "/account/changename";
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AccountNamingFormBloc(),
      child: Builder(
        builder: (context) {
          final bloc = context.bloc<AccountNamingFormBloc>();

          final logo = SvgPicture.asset(
            ('assets/images/icons/ic_man.svg'),
            placeholderBuilder: (context) => CircularProgressIndicator(),
            height: 200.0,
          );

          final ThemeData theme = Theme.of(context);

          final loginButton = Container(
            width: MediaQuery.of(context).size.width,
            child: FusionButton(
                text: AppLocalizations.of(context).buttonNext(),
                onPressed: () {
                  // Finishing account creation
                  bloc.submit();
                }),
          );

          return FormBlocListener<AccountNamingFormBloc, String, String>(
              onSubmitting: (context, state) {
                LoadingDialog.show(context);
              },
              onSuccess: (context, state) {
                LoadingDialog.hide(context);
                BlocProvider.of<AddAccountBloc>(context).add(
                    AddAccountFinishingEvent(name: bloc.accountName.value));
              },
              onFailure: (context, state) {
                LoadingDialog.hide(context);

                Scaffold.of(context).showSnackBar(
                    SnackBar(content: Text(state.failureResponse)));
              },
              child: FusionScaffold(
                  title: AppLocalizations.of(context).toolbarNewAccountTitle(),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        //LimitedBox (maxHeight: 60,),
                        //LimitedBox (maxHeight: 60,),
                        SizedBox(
                          height: 5,
                        ),
                        Flexible(
                          flex: 7,
                          child: logo,
                        ),
                        Flexible(
                          flex: 4,
                          child: TextFieldBlocBuilder(
                            textFieldBloc: bloc.accountName,
                            keyboardType: TextInputType.name,
                            autofocus: true,
                            decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 16, horizontal: 12),
                                border: OutlineInputBorder(
                                    borderRadius: FusionTheme.borderRadius,
                                    borderSide: BorderSide(
                                        color: theme.colorScheme.onSurface
                                            .withOpacity(0.5))),
                                labelText:
                                    AppLocalizations.of(context).labelName()),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),

                        Flexible(
                          flex: 4,
                          child: CheckboxFieldBlocBuilder(
                              booleanFieldBloc: bloc.applyTermsBloc,
                              body: Container(
                                alignment: Alignment.centerLeft,
                                width: double.infinity,
                                child: StyledText(
                                  text:
                                      "<link>${AppLocalizations.of(context).checkboxTermsConditions()}</link>",
                                  styles: {
                                    'link': ActionTextStyle(
                                      decoration: TextDecoration.underline,
                                      onTap: (TextSpan text,
                                              Map<String, String> attrs) =>
                                          {
                                        showCupertinoModalBottomSheet(
                                            context: context,
                                            builder: (context) {
                                              return TermsConditions();
                                            })
                                      },
                                    ),
                                  },
                                ),
                              )),
                        ),

                        // LimitedBox(maxHeight: 30,),

                        //LimitedBox(maxHeight: 50,),
                        SizedBox(height: 5.0),
                        Flexible(
                          flex: 5,
                          child: loginButton,
                        )
                      ],
                    ),
                  )));
        },
      ),
    );
  }
}
