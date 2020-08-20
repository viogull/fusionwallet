import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fusion_wallet/core/minter_rest.dart';
import 'package:fusion_wallet/core/models/create_push_link_request.dart';
import 'package:fusion_wallet/core/models/create_push_link_response.dart';
import 'package:fusion_wallet/localizations.dart';
import 'package:fusion_wallet/ui/components/custom/fusion_button.dart';
import 'package:fusion_wallet/ui/components/custom/fusion_scaffold.dart';
import 'package:fusion_wallet/ui/pages/pushing/share_push.dart';
import 'package:fusion_wallet/ui/theme.dart';
import 'package:fusion_wallet/utils/vault.dart';
import 'package:logger/logger.dart';

import '../../../../inject.dart';
import 'bloc_loader.dart';

class PushFormBloc extends FormBloc<String, String> {


  final logger = injector.get<Logger>();

  final name = TextFieldBloc();
  final qty = TextFieldBloc(validators: [FieldBlocValidators.required]);

  final coin = SelectFieldBloc<String, dynamic>(items: ['BIP', 'USDT']);


  PushFormBloc() {
    addFieldBlocs(fieldBlocs: [name, qty, coin]);
  }




  @override
  void onSubmitting() async {

    final amount = qty.value;
    final receiverName = name.value;
    logger.d("Creating new push link with ${coin.value} $amount to $receiverName");
    final createPushLinkReq = await injector.get<MinterRest>().createPushLink(
        CreatePushLinkRequest(coin: coin.value, value: amount, payload: receiverName),
        receiverName,
        "");
    logger.d("Response from Pusher -> $createPushLinkReq");
    if (createPushLinkReq is CreatePushLinkResponse) {
      final response = createPushLinkReq;
      emitSuccess(successResponse: response.toJson().toString());
    } else {
      emitFailure(failureResponse: '');
    }
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
    return BlocProvider(
        create: (context) => PushFormBloc(),
        child: FormBlocListener<PushFormBloc, String, String>(
            onSubmitting: (context, state) {
          BlocLoader.show(context);
        }, onSuccess: (context, state) {
          BlocLoader.hide(context);
          Navigator.of(context).push(new MaterialPageRoute(
              builder: (context) => SharePush(
                  CreatePushLinkResponse.fromJson(state.successResponse)),
              fullscreenDialog: true));
        }, onFailure: (context, state) {
          BlocLoader.hide(context);
        }, child: Builder(builder: (context) {
          final pushBloc = context.bloc<PushFormBloc>();

          return SafeArea(
            child: FusionScaffold(
              title: AppLocalizations.of(context).buttonPush(),
              child: SingleChildScrollView(
                physics: ClampingScrollPhysics(),
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
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 4),
                                      labelText: AppLocalizations.of(context)
                                          .labelSender(),
                                      border: inputBorder(context),
                                      enabled: true,
                                      helperText: AppLocalizations.of(context).exampleCardFrom,
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
                                  keyboardType: TextInputType.numberWithOptions(
                                      decimal: true),
                                  decoration: InputDecoration(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 12, vertical: 4),
                                      helperStyle: TextStyle(
                                          color: theme.colorScheme.onSurface),
                                      helperText: AppLocalizations.of(context)
                                          .enterAmount,
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
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 16, horizontal: 24),
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
            ),
          );
        })));
  }




  inputBorder(BuildContext context) => OutlineInputBorder(
      gapPadding: 4,
      borderRadius: FusionTheme.borderRadius,
      borderSide: BorderSide(color: Theme.of(context).colorScheme.primary));
}