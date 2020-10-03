



import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:fusion_wallet/core/models.dart';
import 'package:fusion_wallet/ui/components/custom/scaffold.dart';
import 'package:fusion_wallet/ui/pages/withdraw/card_formatter.dart';
import 'package:fusion_wallet/ui/pages/withdraw/withdrawal_store.dart';
import 'package:mobx/mobx.dart';

import '../../../inject.dart';
import '../../../localizations.dart';
import '../../theme.dart';
import '../../widgets.dart';

class CreateInvoiceUi extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CreateInvoiceUiState();
  }
}

class _CreateInvoiceUiState extends State<CreateInvoiceUi> {



  final WithdrawalStore store = WithdrawalStore();
  final logger  = injector.get<Logger>();


  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 700), () {
      store.fetchInitials(address:
      StateContainer.of(context).selectedAccount.address) ;});
    store.setupEstimationCalculators();

  }


  @override
  void dispose() {
   // store.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FusionScaffold(title: AppLocalizations.of(context).createInvoiceTitle(),
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      child: Column(
        children: [
          Flexible(flex: 1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(FlutterIcons.file_invoice_dollar_faw5s, color: Theme.of(context).colorScheme.primary, size: 32,),
              ),
             // AutoSizeText('Create an invoice to withdraw funds.')
            ],
          ),),
          Flexible(flex: 1, child: _buildNetworkDropdown(context)),
      Flexible(flex: 1, child: _buildBalancesDropdown(context)),
    Flexible(flex: 1, child: _buildAmountWidget(context)),
    Flexible(flex: 1, child: _buildFiatSelector(context)),
    Flexible(flex: 1, child: _buildCardInput(context)),
    Flexible(flex: 2, child: Observer(
        builder: (_) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
      store.estimation,
      textAlign: TextAlign.right,
    ),
        ),
    )),
    Flexible(flex: 1, child: Container(
      child: Center(
        child: FusionButton(text: AppLocalizations.of(context).createInvoiceBtn(),
            expandedWidth: true, onPressed: () {
                  store.post();
                  Navigator.of(context).pop();
              }),
      ),
    ))
        ],
      )
    ),);
  }

  Widget _buildNetworkDropdown(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: DropdownSearch<String>(
          mode: Mode.MENU,
          enabled: false,
          popupBackgroundColor: Theme.of(context).colorScheme.surface.withOpacity(0.8),
          popupBarrierColor: Theme.of(context).colorScheme.surface.withOpacity(0.2),
          showSelectedItem: true,
          selectedItem: store.network,
          popupShape: OutlineInputBorder(
              borderRadius: FusionTheme.borderRadius
          ),
          dropdownBuilderSupportsNullItem: true,
          dropDownButton: Icon(FlutterIcons.arrow_drop_down_mdi, color: Theme.of(context).colorScheme.primary,),
          items: ['Minter', 'ERC20'],
          label: AppLocalizations.of(context).chooseBlockchainLabel(),
          onChanged: (value) => store.selectNetwork(value)),
    );
  }

  Widget _buildBalancesDropdown(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Observer(
          builder: (_) {
            final future = store.balances;
            if(future == null)
              return PlatformCircularProgressIndicator();
            if(future.status == FutureStatus.fulfilled)
            {
              final balances = future.result as AddressData;
              logger.d("Balances length ${balances.data.balances.length}");
              return DropdownSearch<String>(
                  mode: Mode.MENU,
                  popupBackgroundColor: Theme.of(context).colorScheme.surface.withOpacity(0.8),
                  popupBarrierColor: Theme.of(context).colorScheme.surface.withOpacity(0.2),
                  showSelectedItem: true,
                  selectedItem: store.coin,
                  popupShape: OutlineInputBorder(
                      borderRadius: FusionTheme.borderRadius
                  ),
                  dropdownBuilderSupportsNullItem: true,
                  dropDownButton: Icon(FlutterIcons.arrow_drop_down_mdi, color: Theme.of(context).colorScheme.primary,),
                  items: balances.data.balances.map((e) => e.coin).toList(),
                  hint: AppLocalizations.of(context).coinWithdrawLabel(),
                  label:AppLocalizations.of(context)
                      .labelConvertCoinHave(),
                  onChanged: (value) => store.enterCoin(value));
            }

            else return PlatformCircularProgressIndicator();


          },
        ),
      ),
    );
  }

  Widget  _buildAmountWidget(BuildContext context) => Padding(
    padding: const EdgeInsets.all(8.0),
    child: TextFormField(
      initialValue: store.qty,
      onChanged: (value ) => store.inputQty(value),
      decoration: InputDecoration(
        alignLabelWithHint: true,
        labelText: AppLocalizations.of(context).amountWithdrawLabel(),
          contentPadding:
          EdgeInsets.symmetric(vertical: 2, horizontal: 12),
          border: OutlineInputBorder(
//                    borderRadius: BorderRadius.zero,
            gapPadding: 0.0,
          ),
          helperText: AppLocalizations.of(context).maximumQtyLabel(store.maximum.toString()),
    ),
  ));

 Widget  _buildCardInput(BuildContext context) => Padding(
   padding: const EdgeInsets.all(8.0),
   child: TextFormField(
     initialValue: store.card,
     onFieldSubmitted: (value ) => store.enterCard(value),
     inputFormatters: [MaskedTextInputFormatter(
       mask: 'xxxx-xxxx-xxxx-xxxx',
       separator: '-',
     ),],
     decoration: InputDecoration(
         contentPadding:
         EdgeInsets.symmetric(vertical: 2,  horizontal: 12),
         border: OutlineInputBorder(
           borderRadius: FusionTheme.borderRadius,
           gapPadding: 0.0,
         ),
         alignLabelWithHint: true,
         labelText: AppLocalizations.of(context).cardNumberLabel()),
   ),
 );

  _buildFiatSelector(BuildContext context) =>  Padding(
    padding: const EdgeInsets.all(8.0),
    child: DropdownSearch<String>(
        mode: Mode.MENU,
        popupBackgroundColor: Theme.of(context).colorScheme.surface.withOpacity(0.8),
        popupBarrierColor: Theme.of(context).colorScheme.surface.withOpacity(0.2),
        showSelectedItem: true,
        selectedItem: store.fiat,
        popupShape: OutlineInputBorder(
            borderRadius: FusionTheme.borderRadius
        ),
        dropdownBuilderSupportsNullItem: true,
        dropDownButton: Icon(FlutterIcons.arrow_drop_down_mdi, color: Theme.of(context).colorScheme.primary,),
        items: ['UAH', 'USD', 'RUB'],
        label: AppLocalizations.of(context).selectFiatHint(),
        onChanged: (value) => store.selectFiatCurrency(value)),
  );
  
}