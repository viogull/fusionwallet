import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../core/models.dart';
import '../../../inject.dart';
import '../../../localizations.dart';
import '../../theme.dart';
import '../../widgets.dart';
import '../pages.dart';
import '../primary.dart';
import 'share.dart';



class PushFormBloc extends FormBloc<String, String> {

  final String sendFrom;


  final logger = injector.get<Logger>();

  final name = TextFieldBloc();
  final qty = TextFieldBloc(validators: [FieldBlocValidators.required]);

  final coin = SelectFieldBloc<String, dynamic>(items: ['BIP', 'USDT']);


  PushFormBloc({@required this.sendFrom}) {
    logger.d("From mnemonic $sendFrom");
    addFieldBlocs(fieldBlocs: [name, qty, coin]);
  }


  @override
  Future<Function> close() {
    name.close();
    qty.close();
    coin.close();
    super.close();
  }

  @override
  void onSubmitting() async {

    final amount = qty.value;
    final receiverName = name.value;
    logger.d("Creating new push link with ${coin.value} $amount to $receiverName");

    final req = await injector.get<MinterRest>()
        .createPushLink(txData: CreatePushLinkRequest(coin: coin.value,
        value: amount, payload: receiverName,sendFrom: sendFrom),
      receiver: receiverName, sender: receiverName );

    logger.d(req);

    if (req is CreatePushLinkResponse) {
      logger.d("Response from Push API. ${req.push_id}.\n Url: ${req.url}\m Shortified:${req.shortUrl}" );

      final response = req;
      logger.d("Generating new deeplink from input data");
      final shortUrl = await _createDynamicLink(response);
      logger.d("Dynamic Link Result ->  $shortUrl");
      emitSuccess(successResponse: shortUrl);
    } else {
      emitFailure(failureResponse: 'Error. Insufficient costs.');
    }
  }

  Future<String> _createDynamicLink(CreatePushLinkResponse _data) async {

    final params = DynamicLinkParameters(
      uriPrefix: 'https://fusiongroup.page.link',
      link: Uri.parse(_data.shortUrl),
      androidParameters: AndroidParameters(
        packageName: "com.fusiongroup.fusion.wallet",
        minimumVersion: 0,
      ),
      dynamicLinkParametersOptions: DynamicLinkParametersOptions(
        shortDynamicLinkPathLength: ShortDynamicLinkPathLength.short,
      ),
      iosParameters: IosParameters(
        bundleId: "com.fusiongroup.wallet",
        appStoreId: '1526215694'
      ),
    );
    final short =  await params.buildShortLink();
    return short.shortUrl.toString();
  }

  @override
  void onLoading() async {
    injector.get<Vault>().getAccounts().then((accounts) async  {
      if(accounts.isNotEmpty) {
        logger.d("Not empty accounts.");
        final balances =
          await injector.get<MinterRest>().fetchAddressData(address: accounts[0].address);
        logger.d(balances);
      }
    }
    ).catchError((onError) => logger.e(onError));
  }
}

class PushFundsPage extends StatelessWidget {
  static const String navId = "/funds/push";

  BoxDecoration formDecoration(BuildContext context) => BoxDecoration(
      borderRadius: FusionTheme.borderRadius,
      border:
          Border.all(color: Theme.of(context).colorScheme.primary, width: 1));

  Widget buildBitcoinEndIcon(
          BuildContext context, String qtyText, MainAxisAlignment alignment) =>
      LimitedBox(
        maxWidth: MediaQuery.of(context).size.width / 10,
        child: Row(
          mainAxisAlignment: alignment,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: SvgPicture.asset(
                ('assets/images/icons/ic_bitcoin.svg'),
                // color: Colors.white,
                fit: BoxFit.fitWidth,
                height: 12,
                width: 12,
              ),
            ),
            Text(
              qtyText,
              style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
              textAlign: TextAlign.right,
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final memo = StateContainer.of(context).selectedAccount.mnemonic;
    logger.d("Memo $memo");
    return BlocProvider(
        create: (context) => PushFormBloc( ),
        child: FormBlocListener<PushFormBloc, String, String>(
            onSubmitting: (context, state) {
          BlocLoadingIndicator.show(context);
        }, onSuccess: (context, state) async {
          BlocLoadingIndicator.hide(context);

            showCupertinoModalBottomSheet(context: context, builder: (context) {
              return SharePush( shortDeeplink: state.successResponse);
            });

        }, onFailure: (context, state) {
          BlocLoadingIndicator.hide(context);
        }, child: Builder(builder: (context) {
          final pushBloc = context.bloc<PushFormBloc>();

          return
           FusionScaffold(
              title: AppLocalizations.of(context).buttonPush(),
              child: SingleChildScrollView(
                physics: NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.all(8),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.9,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Flexible(
                        flex: 8,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[

                              Theme(
                                data: Theme.of(context),
                                child: TextFieldBlocBuilder(
                                  textFieldBloc: pushBloc.name,
                                  keyboardType: TextInputType.name,
                                  maxLines: 1,
                                  decoration: InputDecoration(
                                    labelStyle: TextStyle(
                                      color: Theme.of(context).colorScheme.onBackground
                                    ),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 4),
                                      labelText: AppLocalizations.of(context)
                                          .labelSender(),
                                      border: inputBorder(context),
                                      enabled: true,
                                      enabledBorder: inputBorder(context)),
                                ),
                              ),
                              Theme(
                                data: Theme.of(context),
                                child:  DropdownFieldBlocBuilder<String>(
                                  selectFieldBloc: pushBloc.coin,
                                  showEmptyItem: false,
                                  decoration: InputDecoration(
                                    labelText: AppLocalizations.of(context).currency,
                                      contentPadding:
                                      const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 4),
                                      border: inputBorder(context),
                                      enabled: true,
                                      enabledBorder: inputBorder(context)
                                  ),
                                  itemBuilder: (context, value) => value,
                                ),
                              ),

                              Theme(
                                data: Theme.of(context),
                                child: TextFieldBlocBuilder(
                                  textFieldBloc: pushBloc.qty,
                                  keyboardType: TextInputType.numberWithOptions(decimal: true, signed: true),
                                  decoration: InputDecoration(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 12, vertical: 4),
                                      helperStyle: TextStyle(
                                          color: theme.colorScheme.onSurface),
                                      labelText: AppLocalizations.of(context).labelAmount(),
                                      border: inputBorder(context),
                                      enabledBorder: inputBorder(context)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 6,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 32, horizontal: 24),
                          child: FusionButton(
                              text: AppLocalizations.of(context)
                                  .buttonPush()
                                  .toString()
                                  .toUpperCase(),
                              onPressed: () {
                                pushBloc.submit();
                              },
                              expandedWidth: true),
                        ),
                      )
                    ],
                  ),
                ),
              ),

          );
        })));
  }



  inputBorder(BuildContext context) => OutlineInputBorder(
      gapPadding: 4,
      borderRadius: FusionTheme.borderRadius,
      borderSide: BorderSide(color: Theme.of(context).colorScheme.primary));
}
