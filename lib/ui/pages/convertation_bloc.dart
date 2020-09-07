import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fusion_wallet/core/models.dart';
import 'package:fusion_wallet/core/models/coin_list_response.dart';
import 'package:fusion_wallet/core/models/estimate_response.dart';

import '../../inject.dart';

abstract class ConvertEvent extends Equatable {
  const ConvertEvent();
}

class ConvertInitialEvent extends ConvertEvent {
  const ConvertInitialEvent();
  @override
  // TODO: implement props
  List<Object> get props => ["InitialEvent"];
}

class RequestEstimateEvent extends ConvertEvent {
  final String coinToSell;
  final String coinToBuy;
  final String valueToSell;

  const RequestEstimateEvent(
      {this.coinToBuy, this.coinToSell, this.valueToSell});

  @override
  // TODO: implement props
  List<Object> get props => [" EstimateEvent $valueToSell $coinToSell --> $coinToBuy"];
}

class RequestConvertationEvent extends RequestEstimateEvent {
  List<Object> get props => ["RequestConvertation event "];

}


class ConvertLoadInitialsEvent extends ConvertEvent {
  @override
  // TODO: implement props
  List<Object> get props => ['Loading Initials'];
}


class ConvertChooseFromBalanceEvent extends ConvertEvent {
  final String currency;
  const ConvertChooseFromBalanceEvent(this.currency);

  @override
  // TODO: implement props
  List<Object> get props => [currency];
}

abstract class ConvertState {
  const ConvertState();
}

class ConvertationInitialState extends ConvertState {
}

class ConvertInitLoadedState extends ConvertState {
  final MinterCoin availableCoins;
  final AddressData availableBalances;

  ConvertInitLoadedState(this.availableCoins, this.availableBalances);
}

class ConvertationEstimatedState extends ConvertState {
  EstimateResponse estimateData;

  ConvertationEstimatedState(this.estimateData);
}

class ConvertBloc extends Bloc<ConvertEvent, ConvertState> {
  final Account account;

  final api = injector.get<MinterRest>();
  final log = injector.get<Logger>();
  
  
  AddressData balances;
  MinterCoin coins;

  ConvertBloc({this.account, this.balances, this.coins}) : super(ConvertInitLoadedState(coins, balances)) {

  }




  @override
  Stream<ConvertState> mapEventToState(ConvertEvent event) async* {
    log.d("New event ${event.props} -> -> -> ");

    yield ConvertInitLoadedState(coins, balances);

  }
}
