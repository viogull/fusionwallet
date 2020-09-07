import 'package:auto_size_text/auto_size_text.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fusion_wallet/core/models.dart';
import 'package:fusion_wallet/core/models/coin_list_response.dart';
import 'package:fusion_wallet/core/state_container.dart';
import 'package:fusion_wallet/localizations.dart';
import 'package:fusion_wallet/ui/components/custom/fusion_button.dart';
import 'package:fusion_wallet/ui/components/custom/fusion_scaffold.dart';
import 'package:fusion_wallet/ui/pages/convert_form_store.dart';
import 'package:fusion_wallet/ui/pages/convertation_bloc.dart';
import 'package:fusion_wallet/ui/theme.dart';
import 'package:mobx/mobx.dart';

import 'primary.dart';



class ConvertPageArguments {
  final AddressData balancesData;
  final MinterCoin coinsList;

  const ConvertPageArguments({this.balancesData, this.coinsList});
}

class ConvertPage extends StatefulWidget {


  ConvertPage({this.balances, this.coins});


  AddressData balances;
  MinterCoin coins;
  static const String navId = '/ConvertExchangePage';

  @override
  _ConvertState createState()=>_ConvertState();


}

class _ConvertState extends State<ConvertPage> {


  final ConvertFormStore store = ConvertFormStore();


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
    store.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final account = StateContainer.of(context).selectedAccount;
    return FusionScaffold(
      title: AppLocalizations.of(context).toolbarConvertTitle(),
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
                  child:                       _buildBalancesDropdown(context)
                  ,
                ),
                Flexible(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.symmetric(
                            vertical: 0.0, horizontal: 20.0),
                        child: Text(
                          AppLocalizations.of(context)
                              .labelAmount(),
                          style: TextStyle(
                            color: (theme.colorScheme.onSurface),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                            vertical: 0.0, horizontal: 0.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                              color: theme.colorScheme.primary),
                        ),
                        height: 40.0,
                        child: Container(
                          margin: EdgeInsets.only(left: 24),
                          child: Row(
                            children: <Widget>[
                              Flexible(
                                flex: 6,
                                child: TextFormField(
                                    initialValue: store.valueToSell,
                                      onChanged: (value ) => store.selectValueToSell(value),
                                    decoration: InputDecoration(
                                        contentPadding:
                                        EdgeInsets.all(0.0),
                                        border: OutlineInputBorder(
//                    borderRadius: BorderRadius.zero,
                                          borderSide:
                                          BorderSide.none,
                                          gapPadding: 0.0,
                                        ),
                                        hintText: store.valueToSell),
                                  ),
                                ),

                              Flexible(
                                flex: 1,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.circular(5),
                                    border: Border.all(
                                        color: theme
                                            .colorScheme.primary),
                                  ),
                                  padding:
                                  const EdgeInsets.symmetric(
                                      vertical: 3,
                                      horizontal: 0),
                                  height: 25,
                                  width: 39,
                                  child: InkWell(
                                      child: GestureDetector(
                                        child: Text(
                                          AppLocalizations.of(context)
                                              .inputMaxAmountSuffix(),
                                          textAlign: TextAlign.center,
                                        ),
                                      )),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  flex: 2,
                  child:                      _buildCoinsDropdown(context)

                ),
                Flexible(
                  flex: 2,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Card(
                      borderOnForeground: false,
                      elevation: 16,
                      color:
                      Theme.of(context).colorScheme.surface,
                      shape: RoundedRectangleBorder(
                        borderRadius: FusionTheme.borderRadius,
                      ),
                      margin: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 0),
                      child: LimitedBox(
                        maxWidth:
                        MediaQuery.of(context).size.width,
                        maxHeight: 35,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 6, horizontal: 24),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                AppLocalizations.of(context)
                                    .labelConvertWillGet(),
                                textAlign: TextAlign.left,
                              ),
                              Observer(
                                builder: (_) => Text(
                                  store.willGet,
                                  textAlign: TextAlign.right,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
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
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        AutoSizeText(AppLocalizations.of(context)
                            .labelConvertTransanctionFee()),
                        Observer(builder: (_) => Text(store.fee))
                      ],
                    ),
                  ),
                ),

                Flexible(
                  flex: 2,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: FusionButton(
                      text: AppLocalizations.of(context)
                          .buttonConvert(),
                      onPressed: () {
                        store.exchange(
                          StateContainer.of(context).selectedAccount.mnemonic
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ));
  }


  Widget _buildCoinsDropdown(BuildContext context) {
    return Container(
      child: Observer(
        builder: (_) {
          final future = store.coins;
          if(future.status == FutureStatus.fulfilled)
          {
            final currencies = future.result as List<String>;
            return DropdownSearch<String>(
                mode: Mode.MENU,
                showSelectedItem: true,
                selectedItem: store.coinToBuy,
                items: currencies,

                label:AppLocalizations.of(context)
                    .labelConvertCoinWant(),
                onChanged: (value) => store.selectCoinToBuy(value));
          }

          else return PlatformCircularProgressIndicator();


        },
      ),
    );
  }

  Widget _buildBalancesDropdown(BuildContext context) {
    return Container(
      child: Observer(
        builder: (_) {
          final future = store.balances;
          logger.d("Future Status ${future.status}");
          if(future.status == FutureStatus.fulfilled)
              {
                final balances = future.result as AddressData;
                logger.d("Balances length ${balances.data.balances.length}");
                return DropdownSearch<String>(
                    mode: Mode.MENU,
                    showSelectedItem: true,
                    selectedItem: store.coinToSell,

                    items: balances.data.balances.map((e) => e.coin).toList(),
                    label:AppLocalizations.of(context)
                        .labelConvertCoinHave(),
                    onChanged: (value) => store.selectCoinToSell(value));
              }

          else return PlatformCircularProgressIndicator();


        },
      ),
    );
  }
}
