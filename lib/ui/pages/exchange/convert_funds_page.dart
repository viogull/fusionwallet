import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fusion_wallet/localizations.dart';
import 'package:fusion_wallet/theme/fusion_theme.dart';
import 'package:fusion_wallet/ui/components/custom/fusion_button.dart';

class AllFieldsFormBloc extends FormBloc<String, String> {
  final select1 = SelectFieldBloc(
    items: ['BIP (12345.00)', 'BIP (1232345.00)'],
  );

  AllFieldsFormBloc() {
    addFieldBlocs(fieldBlocs: [
      select1,
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

    final background = SvgPicture.asset(
      ('assets/images/backgrounds/bg_primary.svg'),
      fit: BoxFit.fill,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
    );

    final blll = BlocProvider(
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
              height: 70.0,
              child: DropdownFieldBlocBuilder<String>(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
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

    final coinContainer = Container(
      margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: theme.colorScheme.primary),
      ),
      height: 30.0,
      child: Center(
        child: LimitedBox(
          maxWidth: MediaQuery.of(context).size.width,
          maxHeight: 35,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 24),
            child: GestureDetector(
              child: Row(
                children: <Widget>[
                  Text(
                    "BIP(12345.00)",
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
          ),
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

    final amountContainer = Container(
      margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: theme.colorScheme.primary),
      ),
      height: 30.0,
      child: Center(
        child: LimitedBox(
          maxWidth: MediaQuery.of(context).size.width,
          maxHeight: 35,
          child: Padding(
            padding: const EdgeInsets.only(left: 24, right: 4),
            child: GestureDetector(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "0.00",
                    textAlign: TextAlign.left,
                  ),
                  Container(
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
                ],
              ),
            ),
          ),
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

    final coinWantContainer = Container(
      margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: theme.colorScheme.primary),
      ),
      height: 30.0,
      child: Center(
        child: LimitedBox(
          maxWidth: MediaQuery.of(context).size.width,
          maxHeight: 35,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 24),
            child: GestureDetector(
              child: Row(
                children: <Widget>[
                  Text(
                    "BIP(12345.00)",
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
          ),
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
      child: FusionButton(text: AppLocalizations.of(context).buttonConvert(), onPressed:  () {
        Navigator.pushNamed(context, ConvertExchangePage.navId);
      }),
    );

    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: <Widget>[
            background,
            Container(
              padding: EdgeInsets.only(
                left: 24.0,
                right: 24.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  AppBar(
                    title: Text(
                        AppLocalizations.of(context).toolbarConvertTitle()),
                    backgroundColor: Colors.transparent,
                    centerTitle: true,
                    elevation: 0,
                    iconTheme: IconThemeData(
                        color: Theme.of(context).colorScheme.primary),
                  ),

                  //LimitedBox (maxHeight: 60,),
                  Flexible(
                    flex: 1,
                    child: coinHaveLabel,
                  ),
                  Flexible(
                    flex: 1,
                    child: coinContainer,
                  ),
                  Flexible(
                    flex: 1,
                    child: amountLabel,
                  ),
                  Flexible(
                    flex: 1,
                    child: amountContainer,
                  ),
                  Flexible(
                    flex: 1,
                    child: coinWantLabel,
                  ),
                  Flexible(
                    flex: 1,
                    child: coinWantContainer,
                  ),
                  Flexible(
                    flex: 2,
                    child: getCard,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Flexible(
                    flex: 3,
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
                  SizedBox(
                    height: 20,
                  ),
                  Flexible(
                    flex: 3,
                    child: convertButton,
                  ),
                  SizedBox(
                    height: 50,
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
