import 'package:auto_size_text/auto_size_text.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:fusion_wallet/core/models.dart';
import 'package:fusion_wallet/core/models/coin_list_response.dart';
import 'package:fusion_wallet/core/state_container.dart';
import 'package:fusion_wallet/inject.dart';
import 'package:fusion_wallet/localizations.dart';
import 'package:fusion_wallet/ui/components/custom/button.dart';
import 'package:fusion_wallet/ui/components/custom/scaffold.dart';
import 'package:fusion_wallet/ui/pages/convert_form_store.dart';
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
  final log  = injector.get<Logger>();

  ReactionDisposer _disposer;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 700), () {
      store.fetchInitials(address:
      StateContainer.of(context).selectedAccount.address) ;});
    store.setupEstimationCalculators();
    _disposer = reaction(
            (_) => store.messagesStream.value,
            (result) => Future.delayed(Duration(milliseconds: 800), () {
              log.d("Occured some action ${(result as InformationMessage).message}");
      FlashHelper.successBar( context, message:  (result as InformationMessage).message);
    }));
  }

  @override
  void dispose() {
    store.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return FusionScaffold(
      title: AppLocalizations.of(context).toolbarConvertTitle(),
      child: Container(
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
              child:  _buildBalancesDropdown(context)
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
                child:   _buildCoinsDropdown(context)

            ),
            Flexible(
              flex: 2,
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Card(
                  borderOnForeground: false,
                  elevation: 4,
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
                          Flexible(
                            flex: 1,
                            child: AutoSizeText(
                              AppLocalizations.of(context)
                                  .labelConvertWillGet(),
                              maxFontSize: 14,
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: Observer(
                              builder: (_) => Text(
                                store.willGet,
                                textAlign: TextAlign.right,
                              ),
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
                    Flexible(
                      flex: 1,
                      child: AutoSizeText(AppLocalizations.of(context)
                          .labelConvertTransanctionFee(), maxFontSize: 14,),
                    ),
                    Flexible(flex: 1, child: Observer(builder: (_) => Text(store.fee)))
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
      ));
  }


  Widget _buildCoinsDropdown(BuildContext context) {
    return Container(
      child: Observer(
        builder: (_) {
          final future = store.coins;
          if(future == null ) {
            return PlatformCircularProgressIndicator();
          }
          if(future.status == FutureStatus.fulfilled)
          {
            final currencies = future.result as List<String>;
            return DropdownSearch<String>(
                mode: Mode.MENU,
                showSelectedItem: true,
                selectedItem: store.coinToBuy,
                showSearchBox: true,
                popupBarrierColor: Theme.of(context).colorScheme.surface.withOpacity(0.2),
                dropDownButton: Icon(FlutterIcons.arrow_drop_down_mdi, color: Theme.of(context).colorScheme.primary,),
                popupBackgroundColor: Theme.of(context).colorScheme.surface.withOpacity(0.8),
                emptyBuilder: (context) => Container(
                  child: Center(
                    child: PlatformCircularProgressIndicator(),
                  ),
                ),
                loadingBuilder: (context) => Container(
                  child: Center(
                    child: PlatformCircularProgressIndicator(),
                  ),
                ),
                items: currencies,

                label:AppLocalizations.of(context)
                    .labelConvertCoinWant(),
                onChanged: (value) => store.selectCoinToBuy(value));
          } else if(future.status ==  FutureStatus.rejected) {
           return PlatformCircularProgressIndicator();
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
                    selectedItem: store.coinToSell,
popupShape: OutlineInputBorder(
  borderRadius: FusionTheme.borderRadius
),
                    dropdownBuilderSupportsNullItem: true,
                    dropDownButton: Icon(FlutterIcons.arrow_drop_down_mdi, color: Theme.of(context).colorScheme.primary,),
                    items: balances.data.balances.map((e) => e.coin.symbol).toList(),

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
