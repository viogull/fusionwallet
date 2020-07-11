import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fusion_wallet/localizations.dart';
import 'package:fusion_wallet/theme/fusion_theme.dart';
import 'package:fusion_wallet/ui/components/custom/fusion_button.dart';
import 'package:fusion_wallet/ui/components/custom/fusion_scaffold.dart';

class AllFieldsFormBloc extends FormBloc<String, String> {
  final select1 = SelectFieldBloc(
    items: ['BIP (12345.00)', 'BIP (1232345.00)'],
  );

  final select2 = SelectFieldBloc(
    items: ['BIP (15.00)', 'BIP (145.00)'],
  );

  final text1 = TextFieldBloc();

  AllFieldsFormBloc() {
    addFieldBlocs(fieldBlocs: [
      select1,
      select2,
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

class ConvertExchangePage extends StatefulWidget {
  static const String navId = '/ConvertExchangePage';
  @override
  _ConvertExchangePageState createState() => new _ConvertExchangePageState();
}

class _ConvertExchangePageState extends State<ConvertExchangePage> {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);



    final coinContainer = BlocProvider(
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
              child: DropdownFieldBlocBuilder<String>(

                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(0.0) ,
                  border: OutlineInputBorder(
//                    borderRadius: BorderRadius.zero,
                    borderSide: BorderSide.none,
                    gapPadding: 0.0,
                  ),
                ),
                selectFieldBloc: formBloc.select1,
                itemBuilder: (context, value) => value,
              ),
            ),
          );
        },
      ),
    );


    final coinWantContainer = BlocProvider(
      create: (context) => AllFieldsFormBloc(),
      child: Builder(
        builder: (context) {
          final formBloc = BlocProvider.of<AllFieldsFormBloc>(context);

          return FormBlocListener<AllFieldsFormBloc, String, String>(
            child: Container(
             // margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: theme.colorScheme.primary),
              ),
              height: 40.0,
              child: DropdownFieldBlocBuilder<String>(

                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(0.0) ,
                  border: OutlineInputBorder(
//                    borderRadius: BorderRadius.zero,
                    borderSide: BorderSide.none,
                    gapPadding: 0.0,
                  ),
                ),
                selectFieldBloc: formBloc.select2,
                itemBuilder: (context, value) => value,
              ),
            ),
          );
        },
      ),
    );

    final coinWant = BlocProvider(
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
              child:Row(
                children: <Widget>[
                  Flexible(
                    flex: 6,
                    child: TextFieldBlocBuilder(
                          textFieldBloc: formBloc.text1,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(0.0) ,
                              border: OutlineInputBorder(
//                    borderRadius: BorderRadius.zero,
                                borderSide: BorderSide.none,
                                gapPadding: 0.0,
                              ),

                            labelText: "0.00"

                          ),
                        ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: theme.colorScheme.primary),
                      ),
                      padding:
                      const EdgeInsets.symmetric(vertical: 3, horizontal: 0),
                      height: 25,
                      width: 39,
                      child: InkWell(
                          child: GestureDetector(
                            child: Text(
                              AppLocalizations.of(context).inputMaxAmountSuffix(),
                              textAlign: TextAlign.center,
                            ),
                          )),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );


    final coinHaveLabel = Container(
      alignment: Alignment.topLeft,
      margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
      child: Text(
        AppLocalizations.of(context).labelConvertCoinHave(),
        style: TextStyle(
          color: (theme.colorScheme.onSurface),
        ),
      ),
    );


    final amountLabel = Container(
      alignment: Alignment.topLeft,
      margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
      child: Text(
        AppLocalizations.of(context).labelAmount(),
        style: TextStyle(
          color: (theme.colorScheme.onSurface),
        ),
      ),
    );




    final coinWantLabel = Container(
      alignment: Alignment.topLeft,
      margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
      child: Text(
        AppLocalizations.of(context).labelConvertCoinWant(),
        style: TextStyle(
          color: (theme.colorScheme.onSurface),
        ),
      ),
    );



    final getCard = Container(
      width: MediaQuery.of(context).size.width,
      child: Card(
        borderOnForeground: false,
        elevation: 16,
        color: Theme.of(context).colorScheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: FusionTheme.borderRadius,
        ),
        margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
        child: LimitedBox(
          maxWidth: MediaQuery.of(context).size.width,
          maxHeight: 35,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  AppLocalizations.of(context).labelConvertWillGet(),
                  textAlign: TextAlign.left,
                ),
                Text(
                  '123',
                  textAlign: TextAlign.right,
                ),
              ],
            ),
          ),
        ),
      ),
    );

    final convertButton = Container(
      height: 50,
      width: MediaQuery.of(context).size.width,
      child: FusionButton(AppLocalizations.of(context).buttonConvert(), () {
        Navigator.pushNamed(context, ConvertExchangePage.navId);
      }),
    );

    return FusionScaffold(
      title:AppLocalizations.of(context).toolbarConvertTitle(),
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
                        coinHaveLabel,
                        coinContainer,
                      ],
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        amountLabel,
                        coinWant
                      ],
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        coinWantLabel,
                        coinWantContainer,
                      ],
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: getCard,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Flexible(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 6, horizontal: 24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(AppLocalizations.of(context)
                              .labelConvertTransanctionFee()),
                          Text("123.00 BIP")
                        ],
                      ),
                    ),
                  ),

                  Flexible(
                    flex: 2,
                    child: convertButton,
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
