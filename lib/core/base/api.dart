import 'package:fusion_wallet/core/base/results/account_rename_result.dart';

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
