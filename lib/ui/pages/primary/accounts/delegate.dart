import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fusion_wallet/core/models.dart';
import 'package:fusion_wallet/core/models/delegate_ubound_tx_request.dart';
import 'package:fusion_wallet/localizations.dart';
import 'package:fusion_wallet/ui/components/custom/fusion_button.dart';
import 'package:fusion_wallet/ui/components/custom/fusion_scaffold.dart';
import 'package:fusion_wallet/ui/theme.dart';
import 'package:fusion_wallet/ui/tools/flasher.dart';

import '../../../../inject.dart';
import 'bloc_loader.dart';

class DelegateFormBloc extends FormBloc<String, String> {

  static const DEFAULT_DELEGATE_PUBKEY = "Mp4926c68cec9b85d743810c801c35c33bd3d1e74ae0a801e4e08998e656835727";


  final logger = injector.get<Logger>();

  Account _account;

  final pubkeyBloc = TextFieldBloc(
    initialValue: DEFAULT_DELEGATE_PUBKEY
  );
  final stakeBloc = TextFieldBloc(validators: [FieldBlocValidators.required]);

  final coinBloc = SelectFieldBloc<String, dynamic>(items: ['BIP', 'USDT']);


  DelegateFormBloc() {
    addFieldBlocs(fieldBlocs: [pubkeyBloc, coinBloc, stakeBloc]);

    pubkeyBloc.updateInitialValue(DEFAULT_DELEGATE_PUBKEY);
    stakeBloc.updateValue("0.00");
  }




  @override
  void onSubmitting() async {

    final stake = stakeBloc.value;
    final coin = coinBloc.value;

    final pubkey = pubkeyBloc.value;

    logger.d("Delegating with  $stake $coin to $pubkey");
    try {
      if(_account == null)
          emitFailure();
      final delegateRequest = await injector.get<MinterRest>().delegate(
          DelegateUboundTxRequest(publicKey: pubkey,
              coin: coin, stake: stake, gasCoin: 'BIP'), _account.hash);

      logger.d("Response from node -> $delegateRequest");
      if (delegateRequest != null) {
        final response = (delegateRequest as String);
        emitSuccess(successResponse: response.toString());
      } else {
        emitFailure(failureResponse: '');
      }
    }on Exception catch (exception) {
      emitFailure(failureResponse: exception.toString());
    }
    emitFailure();
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

//                              Theme(
//                                data: Theme.of(context),
//                                child: TextFieldBlocBuilder(
//                                  textFieldBloc: pushBloc.name,
//                                  keyboardType: TextInputType.name,
//                                  maxLines: 1,
//                                  decoration: InputDecoration(
//                                      contentPadding:
//                                      const EdgeInsets.symmetric(
//                                          horizontal: 16, vertical: 4),
//                                      labelText: AppLocalizations.of(context)
//                                          .labelSender(),
//                                      border: inputBorder(context),
//                                      enabled: true,
//                                      helperText: AppLocalizations.of(context).exampleCardFrom,
//                                      enabledBorder: inputBorder(context)),
//                                ),
//                              ),
//                              Theme(
//                                data: Theme.of(context),
//                                child:  DropdownFieldBlocBuilder<String>(
//                                  selectFieldBloc: pushBloc.coin,
//                                  showEmptyItem: false,
//                                  decoration: InputDecoration(
//                                      labelText: AppLocalizations.of(context).currency,
//                                      contentPadding:
//                                      const EdgeInsets.symmetric(
//                                          horizontal: 16, vertical: 4),
//                                      border: inputBorder(context),
//                                      enabled: true,
//                                      enabledBorder: inputBorder(context)
//                                  ),
//                                  itemBuilder: (context, value) => value,
//                                ),
//                              ),
//
//                              Theme(
//                                data: Theme.of(context),
//                                child: TextFieldBlocBuilder(
//                                  textFieldBloc: pushBloc.qty,
//                                  keyboardType: TextInputType.numberWithOptions(
//                                      decimal: true),
//                                  decoration: InputDecoration(
//                                      contentPadding:
//                                      const EdgeInsets.symmetric(
//                                          horizontal: 12, vertical: 4),
//                                      helperStyle: TextStyle(
//                                          color: theme.colorScheme.onSurface),
//                                      helperText: AppLocalizations.of(context)
//                                          .enterAmount,
//                                      labelText: AppLocalizations.of(context).labelAmount(),
//                                      border: inputBorder(context),
//                                      enabledBorder: inputBorder(context)),
//                                ),
//                              ),
//                            ],
//                          ),
//                        ),
//                      ),
//                      Flexible(
//                        flex: 2,
//                        child: Padding(
//                          padding: const EdgeInsets.symmetric(
//                              vertical: 16, horizontal: 24),
//                          child: FusionButton(
//                              text: AppLocalizations.of(context)
//                                  .buttonPush()
//                                  .toString()
//                                  .toUpperCase(),
//                              onPressed: () {
//                                pushBloc.submit();
//                              },
//                              expandedWidth: true),
//                        ),
//                      )
//                    ],
//                  ),
//                ),
//              ),
//            ),
//          );




class DelegateFundsPage extends StatelessWidget {
  static const String navId = "/funds/delegate";

  BoxDecoration formDecoration(BuildContext context) => BoxDecoration(
      borderRadius: FusionTheme.borderRadius,
      border:
      Border.all(color: Theme.of(context).colorScheme.primary, width: 1));

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocProvider(
        create: (context) => DelegateFormBloc(),
        child: FormBlocListener<DelegateFormBloc, String, String>(
            onSubmitting: (context, state) {
              BlocLoader.show(context);
            }, onSuccess: (context, state) {
          BlocLoader.hide(context);

        }, onFailure: (context, state) {
          BlocLoader.hide(context);
          FlashHelper.errorBar(context, message: state.failureResponse);
        }, child: Builder(builder: (context) {
          final bloc = context.bloc<DelegateFormBloc>();
          return FusionScaffold(
            title: AppLocalizations.of(context).buttonDelegate(),
            child: SingleChildScrollView(
              physics: ClampingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.9,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Flexible(
                        flex: 8,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Theme(
                                data: theme,
                                child: TextFieldBlocBuilder(
                                  textFieldBloc: bloc.pubkeyBloc,
  suffixButton: SuffixButton.clearText,


style: TextStyle(fontSize: 16, color: Theme.of(context).colorScheme.onBackground.withOpacity(0.6)),
                                  decoration: InputDecoration(

                                      contentPadding: const EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 4),
                                      labelText: AppLocalizations.of(context).labelPubkeyOrDomain(),
                                      border: inputBorder(context),
                                      enabled: true,
                                      alignLabelWithHint: true,
                                      enabledBorder: inputBorder(context)),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Text(
                                    AppLocalizations.of(context).labelCoin(),
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        color: Theme.of(context).colorScheme.onSurface,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              Theme(
                                data: Theme.of(context),
                                child:  DropdownFieldBlocBuilder<String>(
                                  selectFieldBloc: bloc.coinBloc,
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
                                data: theme,
                                child: TextFieldBlocBuilder(
                                  style: TextStyle(fontSize: 16, color: Theme.of(context).colorScheme.onBackground.withOpacity(0.6)),
                                  textFieldBloc: bloc.stakeBloc,
                                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                                  decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 2),
                                      labelText: AppLocalizations.of(context)
                                          .inputFundsStakeHint(),
                                      suffix: buildTextFieldMaxButton(context),

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
                          padding: const EdgeInsets.all(8.0),
                          child: FusionButton(
                            text: AppLocalizations.of(context)
                                .buttonDelegate()
                                .toString(),
                            onPressed: () {
                              bloc.submit();
                            },
                            expandedWidth: true,
                          ),
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

  Widget buildTextFieldMaxButton(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 3),
        width: 36,
        margin: const EdgeInsets.all(4),
        decoration: BoxDecoration(
            borderRadius: FusionTheme.borderRadius,
            border: Border.all(color: Theme.of(context).colorScheme.primary)),
        child: Center(
          child: AutoSizeText(
            AppLocalizations.of(context)
                .inputMaxAmountSuffix()
                .toString()
                .toUpperCase(),
            maxFontSize: 12,
            style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
          ),
        ),
      );

  inputBorder(BuildContext context) => OutlineInputBorder(
      gapPadding: 4,
      borderRadius: FusionTheme.borderRadius,
      borderSide: BorderSide(color: Theme.of(context).colorScheme.primary));

  buildScanQrEndIcon(BuildContext context) => LimitedBox(
    maxWidth: 20,
    maxHeight: 20,
    child: Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: SvgPicture.asset("assets/images/icons/ic_qrcodescan.svg",
                width: 16, height: 16),
          ),
        ),
  );
}
