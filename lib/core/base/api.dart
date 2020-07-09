import 'package:fusion_wallet/core/base/results/account_rename_result.dart';
import 'package:meta/meta.dart';

import 'results/account_creation_result.dart';
import 'results/delegate_result.dart';
import 'results/receive_result.dart';
import 'results/referal_result.dart';
import 'results/send_result.dart';
import 'results/ubond_result.dart';
import 'results/withdraw_result.dart';

abstract class BaseApiAddons {
  Future<AccountCreationResult> createAccount();
  Future<List<dynamic>> createPassphrase();
  Future<dynamic> recoverFromSeed(String seed);
  Future<AccountRenameResult> renameAccount({String name});
  Future<AccountDeletionResult> deleteAccount({String name});

  Future<SendResult> send();
  Future<MultisendResult> multisend();
  Future<RequestResult> request();
  Future<DelegateResult> delegate();
  Future<UbondResult> unbond();
  Future<dynamic> push();
  Future<WithdrawResult> withdraw();

  Future<String> getAddress();
  Future<String> getQrData({String address});
  Future<String> getPassphrase();
  Future<ReferalResult> showReferalLink();

  Future<AccountRewardResult> getAccountRewardsInfo();
  Future<AccountsListResult> getAccountsList();
  Future<HistoryResult> getHistory();

  Future<HistoryResult> getNotifications();
  Future<SendFeedbackResult> sendFeedback();
}

class MultisendResult {}

class AccountDeletionResult {}

class AccountsListResult {}

class SendFeedbackResult {}

class HistoryResult {}

class AccountRewardResult {}



class WalletCurrency {
  final String iconUrl;
  final String name;
  final String symbol;
   final num qty;

  const WalletCurrency({@required this.symbol, @required this.qty,
    this.name, this.iconUrl
  });
}

class RewardsData {
  const RewardsData({
    @required num earned, num pending
  });
}


class Transanction {
  final num datetime;
  final num qty;
  final String from;
  final String to;

  const Transanction({
    @required this.qty, @required this.from, @required this.to, @required this.datetime
  });

}



abstract class BaseRepository {
  Future<List<WalletCurrency>> getAvailableCurrencies();
  Future<RewardsData> getRewards();
  Future<List<Transanction>> getTransanctionsHistory({String accountName, num startDate, num endDate});
  Future<List<String>> getAddresses();


}