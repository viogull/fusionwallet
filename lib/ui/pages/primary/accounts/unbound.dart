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
import 'package:fusion_wallet/utils/flasher.dart';

import '../../../../inject.dart';
import 'bloc_loader.dart';

class UboundFormBloc extends FormBloc<String, String> {

  static const DEFAULT_DELEGATE_PUBKEY = "Mp4926c68cec9b85d743810c801c35c33bd3d1e74ae0a801e4e08998e656835727";


  final logger = injector.get<Logger>();

  Account _account;

  final pubkeyBloc = TextFieldBloc(
      initialValue: DEFAULT_DELEGATE_PUBKEY
  );
  final stakeBloc = TextFieldBloc(validators: [FieldBlocValidators.required]);

  final coinBloc = SelectFieldBloc<String, dynamic>(items: ['BIP', 'USDT']);


  UboundFormBloc() {
    addFieldBlocs(fieldBlocs: [pubkeyBloc, coinBloc, stakeBloc]);

    pubkeyBloc.updateInitialValue(DEFAULT_DELEGATE_PUBKEY);
  }




  @override
  void onSubmitting() async {

    final stake = stakeBloc.value;
    final coin = coinBloc.value;

    final pubkey = pubkeyBloc.value;

    logger.d("Delegating with  $stake $coin to $pubkey");
    try {
      if(_account == null)
        emitFailure(failureResponse: " ");
      else {
        final request = await injector.get<MinterRest>().ubound(
            DelegateUboundTxRequest(publicKey: pubkey,
                coin: coin, stake: stake, gasCoin: 'BIP'), _account.hash);

        logger.d("Response from node -> $request");
        if (request != null) {
          final response = (request as String);
          emitSuccess(successResponse: " ");
        } else {
          emitFailure(failureResponse: 'D');
        }
      }
    }on Exception catch (exception) {
      emitFailure(failureResponse: "DD");
    }
    emitFailure(failureResponse: "ss");
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


class UboundFundsPage extends StatelessWidget {
  static const String navId = "/funds/ubound";

  BoxDecoration formDecoration(BuildContext context) => BoxDecoration(
      borderRadius: FusionTheme.borderRadius,
      border:
      Border.all(color: Theme.of(context).colorScheme.primary, width: 1));

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocProvider(
        create: (context) => UboundFormBloc(),
        child: FormBlocListener<UboundFormBloc, String, String>(
            onSubmitting: (context, state) {
              BlocLoader.show(context);
            }, onSuccess: (context, state) {
          BlocLoader.hide(context);

        }, onFailure: (context, state) {
          BlocLoader.hide(context);
          FlashHelper.errorBar(context, message: state.failureResponse);
        }, child: Builder(builder: (context) {
          final bloc = context.bloc<UboundFormBloc>();
          return FusionScaffold(
            title: AppLocalizations.of(context).buttonUnbound(),
            child: SingleChildScrollView(
              physics: ClampingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 0.86,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Flexible(
                        flex: 7,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8),
                                child: Theme(
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
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8),
                                child: Theme(
                                  data: Theme.of(context),
                                  child:  DropdownFieldBlocBuilder<String>(

                                    selectFieldBloc: bloc.coinBloc,
                                    showEmptyItem: false,
                                    decoration: InputDecoration(
                                        prefixIcon: _buildUsdEndIcon(context),
                                        prefixIconConstraints: BoxConstraints(
                                            maxWidth: 24,
                                            maxHeight: 24
                                        ),
                                        labelText: AppLocalizations.of(context).labelCoin(),
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
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8),
                                child: Theme(
                                  data: theme,
                                  child: TextFieldBlocBuilder(
                                    style: TextStyle( color: Theme.of(context).colorScheme.onBackground.withOpacity(0.6)),
                                    textFieldBloc: bloc.stakeBloc,
                                    maxLines: 1,
                                    maxLength: 8,
                                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                                    decoration: InputDecoration(
                                        alignLabelWithHint: true,
                                        contentPadding: const EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 4),
                                        labelText: AppLocalizations.of(context)
                                            .inputFundsStakeHint(),
                                        suffix: buildTextFieldMaxButton(context),

                                        border: inputBorder(context),
                                        enabledBorder: inputBorder(context)),
                                  ),
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
                                .buttonUnbound()
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

  Widget _buildUsdEndIcon(BuildContext context) =>  Padding(
    padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
    child: SvgPicture.asset("assets/images/icons/ic_dollar.svg",
        color: Theme.of(context).colorScheme.onBackground,
        fit: BoxFit.fill,
        width: 24, height: 24
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
