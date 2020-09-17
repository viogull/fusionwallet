import 'package:dio/dio.dart';
import 'package:fusion_wallet/core/abstract/account.dart';
import 'package:fusion_wallet/core/models/address_data_with_usd.dart';
import 'package:fusion_wallet/core/models/admin_notifications_response.dart';
import 'package:fusion_wallet/core/models/can_recover_request.dart';
import 'package:fusion_wallet/core/models/convert_request.dart';
import 'package:fusion_wallet/core/models/create_profile_request.dart';
import 'package:fusion_wallet/core/models/create_push_link_request.dart';
import 'package:fusion_wallet/core/models/create_push_link_response.dart';
import 'package:fusion_wallet/core/models/currency_prices_response.dart';
import 'package:fusion_wallet/core/models/delegate_ubound_tx_request.dart';
import 'package:fusion_wallet/core/models/erc20_balance_request.dart';
import 'package:fusion_wallet/core/models/estimate_request.dart';
import 'package:fusion_wallet/core/models/estimate_response.dart';
import 'package:fusion_wallet/core/models/eth_balance_response.dart';
import 'package:fusion_wallet/core/models/exchange_rate_response.dart';
import 'package:fusion_wallet/core/models/minter_coins_response.dart';
import 'package:fusion_wallet/core/models/multisend_request.dart';
import 'package:fusion_wallet/core/models/nonce_response.dart';
import 'package:fusion_wallet/core/models/profile_response.dart';
import 'package:fusion_wallet/core/models/recover_response.dart';
import 'package:fusion_wallet/core/models/send_tx_request.dart';
import 'package:fusion_wallet/core/models/spec_exchange_rates_response.dart';
import 'package:fusion_wallet/core/models/statistic_rewards_response.dart';
import 'package:fusion_wallet/core/models/transanctions_response.dart';
import 'package:hive/hive.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';

import './models.dart';
import '../inject.dart';
import 'models/coefficients_response.dart';
import 'models/push_transaction_result.dart';

enum MinterNetwork { Main, Test }

class MinterRest {
  final MinterNetwork networkType;

  static const fusionApiUrl = "https://api.fusion-push.cash";

//  static const fusionApiMirrorUrl =
//      "https://whispering-depths-02969.herokuapp.com";


  static const erc20ProjectId = "f7cbcc98baf84807b1ef700c8e278cd0";
  static const erc20Sec = "2c95173bd55e44e29e4e7823f5c0fd80";


  static const erc20MainnetUrl = "https://mainnet.infura.io/v3/$erc20ProjectId";



  static const explorerMainnetUrl =
      "https://explorer-api.minter.network/api/v1";
  static const explorerTestnetUrl =
      "https://testnet.explorer-api.minter.network/api/v1/";

  static const gateMainnetUrl = "https://gate-api.minter.network/api/v1/";
  static const gateTestnetUrl =
      "https://testnet.gate-api.minter.network/api/v1/";

  static const exchangeRatesUrl = "https://bipchange.org/api/";

  static specExchangeRatesUrl(String exchange) =>
      "https://bipchange.org/api/ex/$exchange";

  static MinterRest _instance = new MinterRest.internal();
  MinterRest.internal({this.networkType = MinterNetwork.Main});
  factory MinterRest() => _instance;

  static const ADDRESS_INFO_URL = explorerMainnetUrl + "addresses/";

  static final BaseOptions dioOptions = BaseOptions(
      baseUrl: explorerMainnetUrl,
      responseType: ResponseType.json,
      connectTimeout: 30000,
      receiveTimeout: 30000,
      validateStatus: (code) {
        if (code >= 200)
          return true;
        else
          return false;
      });

  static final BaseOptions fusionDioOptions = BaseOptions(
      baseUrl: fusionApiUrl,
      responseType: ResponseType.json,
      connectTimeout: 30000,
      receiveTimeout: 30000,
      validateStatus: (code) {
        if (code >= 200)
          return true;
        else
          return false;
      });

  static final BaseOptions erc20DioOptions = BaseOptions(
      baseUrl: erc20MainnetUrl,
      responseType: ResponseType.json,
      connectTimeout: 30000,
      receiveTimeout: 30000,
      validateStatus: (code) {
        if (code >= 200)
          return true;
        else
          return false;
      });

  final Dio dio = Dio(dioOptions);
  final Dio fusionDio = Dio(fusionDioOptions);
  final Dio erc20Dio = Dio(erc20DioOptions);

  void loadInterceptors() async {}

  final logger = injector.get<Logger>();


  Future<Erc20BalanceResponse> getEthBalance({String address}) async {
    try {
      Response response = await erc20Dio.post("",
          data: Erc20BalanceRequest(address).toJson(),
          options: Options(contentType: "application/json"));

      if (response.statusCode == 200 || response.statusCode == 201) {
        return Erc20BalanceResponse.fromJson(response.data);
      } else
        return null;
    } on DioError catch (exception) {
      if (exception == null) {
        if (exception == null ||
            exception.toString().contains('SocketException')) {
          throw Exception("Network Error");
        } else if (exception.type == DioErrorType.RECEIVE_TIMEOUT ||
            exception.type == DioErrorType.CONNECT_TIMEOUT) {
          throw Exception(
              "Could'nt connect, please ensure you have a stable network.");
        } else {
          return null;
        }
      }
    }
    return null;
  }


  Future<ProfileResponse> createProfile(CreateProfileRequest data) async {
    try {
      Response response = await fusionDio.post('/profile/create',
          data: data.toJson(),
          options: Options(contentType: "application/json"));

      if (response.statusCode == 200 || response.statusCode == 201) {
        return ProfileResponse.fromJson(response.data);
      } else
        return null;
    } on DioError catch (exception) {
      if (exception == null) {
        if (exception == null ||
            exception.toString().contains('SocketException')) {
          throw Exception("Network Error");
        } else if (exception.type == DioErrorType.RECEIVE_TIMEOUT ||
            exception.type == DioErrorType.CONNECT_TIMEOUT) {
          throw Exception(
              "Could'nt connect, please ensure you have a stable network.");
        } else {
          return null;
        }
      }
    }
    return null;
  }

  //get
  Future<ProfileResponse> fetchProfileData(String id, String hash) async {
    try {
      if (id == null || hash == null) {
        logger.e('Cannot fetch info for null address');
        return null;
      }

      logger.d('Fetching profile $id');
      // Adding Mx to get valid address
      final url = "$fusionApiUrl/profile/$id?hash=$hash";
      logger.d("Fetch Address Data Url $url");
      Response response = await fusionDio.get(url);

      if (response.statusCode == 200) {
        logger.d("Response status code " + response.statusCode.toString());
        final data =  ProfileResponse.fromJson(response.data);
        logger.e("Has Access ---> ${data.hasAccess}");
        return data;

      }
    } on DioError catch (exception) {
      if (exception == null) {
        if (exception == null ||
            exception.toString().contains('SocketException')) {
          throw Exception("Network Error");
        } else if (exception.type == DioErrorType.RECEIVE_TIMEOUT ||
            exception.type == DioErrorType.CONNECT_TIMEOUT) {
          throw Exception(
              "Could'nt connect, please ensure you have a stable network.");
        } else {
          return null;
        }
      }
      return null;
    }
    return null;
  }

  Future<MinterCoinsResponse> fetchMinterCoins() async {
    try {
      // Adding Mx to get valid address
      final url = "$fusionApiUrl/explorer/coins";
      logger.d("Fetch Minter Coins Data Url $url");
      Response response = await fusionDio.get(url);

      if (response.statusCode == 200) {
        return MinterCoinsResponse.fromJson(response.data);

      }
    } on DioError catch (exception) {
      if (exception == null) {
        if (exception == null ||
            exception.toString().contains('SocketException')) {
          throw Exception("Network Error");
        } else if (exception.type == DioErrorType.RECEIVE_TIMEOUT ||
            exception.type == DioErrorType.CONNECT_TIMEOUT) {
          throw Exception(
              "Could'nt connect, please ensure you have a stable network.");
        } else {
          return null;
        }
      }
      return null;
    }
    return null;
  }

  //put
  Future<dynamic> updateProfileData() {}

  Future<bool> send({SendTxRequest txData, String hash}) async {
    try {
      Response response = await fusionDio.post('/tx/send?hash=$hash',
          data: txData.toJson(),
          options: Options(contentType: "application/json"));

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else
        return false;
    } on DioError catch (exception) {
      if (exception == null) {
        if (exception == null ||
            exception.toString().contains('SocketException')) {
          throw Exception("Network Error");
        } else if (exception.type == DioErrorType.RECEIVE_TIMEOUT ||
            exception.type == DioErrorType.CONNECT_TIMEOUT) {
          throw Exception(
              "Could'nt connect, please ensure you have a stable network.");
        } else {
          return null;
        }
      }
    }
  }

  Future<bool> multisend({MultisendRequest request, String hash}) async {
    try {
      Response response = await fusionDio.post('/tx/v2/multisend?hash=$hash',
          data: request.toJson(),
          options: Options(contentType: "application/json"));

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else
        return false;
    } on DioError catch (exception) {
      if (exception == null) {
        if (exception == null ||
            exception.toString().contains('SocketException')) {
          throw Exception("Network Error");
        } else if (exception.type == DioErrorType.RECEIVE_TIMEOUT ||
            exception.type == DioErrorType.CONNECT_TIMEOUT) {
          throw Exception(
              "Could'nt connect, please ensure you have a stable network.");
        } else {
          return false;
        }
      }
    }
    return false;
  }

  Future<bool> delegate({DelegateUboundTxRequest txData, String hash}) async {
    try {
      Response response = await fusionDio.post('/tx/delegate?hash=$hash',
          data: txData.toJson(),
          options: Options(contentType: "application/json"));

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else
        return false;
    } on DioError catch (exception) {
      if (exception == null) {
        if (exception == null ||
            exception.toString().contains('SocketException')) {
          throw Exception("Network Error");
        } else if (exception.type == DioErrorType.RECEIVE_TIMEOUT ||
            exception.type == DioErrorType.CONNECT_TIMEOUT) {
          throw Exception(
              "Could'nt connect, please ensure you have a stable network.");
        } else {
          return null;
        }
      }
    }
  }

  Future<dynamic> ubound({DelegateUboundTxRequest txData, String hash}) async {
    try {
      Response response = await fusionDio.post('/tx/ubound?hash=$hash',
          data: txData.toJson(),
          options: Options(contentType: "application/json"));

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else
        return false;
    } on DioError catch (exception) {
      if (exception == null) {
        if (exception == null ||
            exception.toString().contains('SocketException')) {
          throw Exception("Network Error");
        } else if (exception.type == DioErrorType.RECEIVE_TIMEOUT ||
            exception.type == DioErrorType.CONNECT_TIMEOUT) {
          throw Exception(
              "Could'nt connect, please ensure you have a stable network.");
        } else {
          return null;
        }
      }
    }
  }

  Future<CreatePushLinkResponse> createPushLink(
      {CreatePushLinkRequest txData, String receiver, String sender}) async {
    try {
      Account _acc;
      String memo;
      Hive.box<Account>(accountsBox).values.forEach((element) {
        memo = element.mnemonic;
        logger.d(
            "Name ${element.name}, hash ${element.hash}, ${element.toString()}");
        if (element != null) _acc = element;
      });

      txData.sendFrom = memo;

      Response response = await fusionDio.post(
          "$fusionApiUrl/push/create?sender=${sender.isNotEmpty ? sender : _acc}&receiver=$receiver&creatorId=${_acc.seed}",
          data: txData.toJson(),
          options: Options(contentType: "application/json"));

      if (response.statusCode == 200 || response.statusCode == 201) {
        return CreatePushLinkResponse.fromJson(response.data);
      } else
        return null;
    } on DioError catch (exception) {
      if (exception == null) {
        if (exception == null ||
            exception.toString().contains('SocketException')) {
          throw Exception("Network Error");
        } else if (exception.type == DioErrorType.RECEIVE_TIMEOUT ||
            exception.type == DioErrorType.CONNECT_TIMEOUT) {
          throw Exception(
              "Could'nt connect, please ensure you have a stable network.");
        } else {
          return null;
        }
      }
    }
  }

  Future<bool> convert({ConvertRequest requestData}) async {
    try {
      Response response = await fusionDio.post('/tx/convert',
          data: requestData.toJson(),
          options: Options(contentType: "application/json"));

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else
        return false;
    } on DioError catch (exception) {
      if (exception == null) {
        if (exception == null ||
            exception.toString().contains('SocketException')) {
          throw Exception("Network Error");
        } else if (exception.type == DioErrorType.RECEIVE_TIMEOUT ||
            exception.type == DioErrorType.CONNECT_TIMEOUT) {
          throw Exception(
              "Could'nt connect, please ensure you have a stable network.");
        } else {
          return null;
        }
      }
    }
  }

  // ignore: missing_return
  Future<EstimateResponse> estimate( EstimateRequest estimateData) async {
    try {
      Response response = await fusionDio.post('/tx/convert/estimate',
          data: estimateData.toJson(),
          options: Options(contentType: "application/json"));

      if (response.statusCode == 200 || response.statusCode == 201) {
        return EstimateResponse.fromJson(response.data);
      } else
        return null;
    } on DioError catch (exception) {
      if (exception == null) {
        if (exception == null ||
            exception.toString().contains('SocketException')) {
          throw Exception("Network Error");
        } else if (exception.type == DioErrorType.RECEIVE_TIMEOUT ||
            exception.type == DioErrorType.CONNECT_TIMEOUT) {
          throw Exception(
              "Could'nt connect, please ensure you have a stable network.");
        } else {
          return null;
        }
      }
    }
  }

  Future<bool> applyPush(String url, String address) async {
    try {
      Response response = await fusionDio.put("$url?address=$address",
          options: Options(contentType: "application/json"));

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else
        return false;
    } on DioError catch (exception) {
      if (exception == null) {
        if (exception == null ||
            exception.toString().contains('SocketException')) {
          throw Exception("Network Error");
        } else if (exception.type == DioErrorType.RECEIVE_TIMEOUT ||
            exception.type == DioErrorType.CONNECT_TIMEOUT) {
          throw Exception(
              "Could'nt connect, please ensure you have a stable network.");
        } else {
          return null;
        }
      }
    }
  }


  Future<EthBalanceResponse> fetchErc20Balances({String address}) async {
    try {
      logger.d('Fetching ERC balances');
      // Adding Mx to get valid address
      final url = "$fusionApiUrl/erc20/$address/balance";
      logger.d('Fetching ERC balances url $url');

      Response response = await fusionDio.get(url);

      if (response.statusCode == 200) {
        final datas = EthBalanceResponse.fromJson(response.data);

        logger.d("value -> " + datas.value.toString());
        return datas;
      }
    } on DioError catch (exception) {
      if (exception == null) {
        if (exception == null ||
            exception.toString().contains('SocketException')) {
          throw Exception("Network Error");
        } else if (exception.type == DioErrorType.RECEIVE_TIMEOUT ||
            exception.type == DioErrorType.CONNECT_TIMEOUT) {
          throw Exception(
              "Could'nt connect, please ensure you have a stable network.");
        } else {
          return null;
        }
      }
      return null;
    }
    return null;
  }


  Future<CurrencyPricesResponse> fetchCurrencyPrices() async {
    try {
      logger.d('Fetching coefficients');
      // Adding Mx to get valid address
      final url = "$fusionApiUrl/explorer/prices";
      logger.d("Fetch Coefficients Data Url $url");
      Response response = await fusionDio.get(url);

      if (response.statusCode == 200) {
        final datas = CurrencyPricesResponse.fromJson(response.data);
        logger.d(datas);
        return datas;
      }
    } on DioError catch (exception) {
      if (exception == null) {
        if (exception == null ||
            exception.toString().contains('SocketException')) {
          throw Exception("Network Error");
        } else if (exception.type == DioErrorType.RECEIVE_TIMEOUT ||
            exception.type == DioErrorType.CONNECT_TIMEOUT) {
          throw Exception(
              "Could'nt connect, please ensure you have a stable network.");
        } else {
          return null;
        }
      }
      return null;
    }
    return null;
  }


  Future<CoefficientsResponse> fetchCoefficients() async {
    try {
      logger.d('Fetching coefficients');
      // Adding Mx to get valid address
      final url = "$fusionApiUrl/explorer/rates";
      logger.d("Fetch Coefficients Data Url $url");
      Response response = await fusionDio.get(url);

      if (response.statusCode == 200) {
        final datas = CoefficientsResponse.fromJson(response.data);
        logger.d(datas);
        return datas;
      }
    } on DioError catch (exception) {
      if (exception == null) {
        if (exception == null ||
            exception.toString().contains('SocketException')) {
          throw Exception("Network Error");
        } else if (exception.type == DioErrorType.RECEIVE_TIMEOUT ||
            exception.type == DioErrorType.CONNECT_TIMEOUT) {
          throw Exception(
              "Could'nt connect, please ensure you have a stable network.");
        } else {
          return null;
        }
      }
      return null;
    }
    return null;
  }

  Future<ExchangeRateResponse> fetchExchangeRates() async {
    //TODO
  }

  Future<SpecExchangeRatesResponse> fetchExchangerRates(
      String exchangeName) async {}

  Future<AddressData> fetchAddressData({@required String address}) async {
    try {
      if (address == null) {
        logger.e('Cannot fetch info for null address');
        return null;
      }
      if (!address.contains("Mx")) address = "Mx" + address;

      logger.d('Fetching address $address');
      // Adding Mx to get valid address
      final url = "$explorerMainnetUrl/addresses/$address";
      logger.d("Fetch Address Data Url $url");
      Response response = await dio.get(url);

      if (response.statusCode == 200) {
        var data = AddressData.fromJson(response.data);
        return data;
      }
    } on DioError catch (exception) {
      if (exception == null) {
        if (exception == null ||
            exception.toString().contains('SocketException')) {
          throw Exception("Network Error");
        } else if (exception.type == DioErrorType.RECEIVE_TIMEOUT ||
            exception.type == DioErrorType.CONNECT_TIMEOUT) {
          throw Exception(
              "Could'nt connect, please ensure you have a stable network.");
        } else {
          return null;
        }
      }
      return null;
    }
  }

  Future<TransactionsResponse> fetchTransactions(
      {@required String address, DateTime from, DateTime to}) async {
    try {
      if (address == null) {
        logger.e('Cannot fetch txs for null address');
        return null;
      }
      if (!address.contains("Mx")) address = "Mx" + address;

      logger.d('Fetching address $address txs ');
      // Adding Mx to get valid address
      final url =
          "https://explorer-api.minter.network/api/v1/addresses/$address/transactions";
      Response response = await dio.get(url);

      if (response.statusCode == 200) {
        var data = TransactionsResponse.fromJson(response.data);

        if (from != null && to != null) {
          logger.d("Filtering");
          final filtered = data.data.where((element) {
            final time = DateTime.parse(element.timestamp);
            return (time.isAfter(from) && time.isBefore(to));
          }).toList();
          return TransactionsResponse(data: filtered);
        }

        return data;
      }
    } on DioError catch (exception) {
      if (exception == null) {
        if (exception == null ||
            exception.toString().contains('SocketException')) {
          throw Exception("Network Error");
        } else if (exception.type == DioErrorType.RECEIVE_TIMEOUT ||
            exception.type == DioErrorType.CONNECT_TIMEOUT) {
          throw Exception(
              "Could'nt connect, please ensure you have a stable network.");
        } else {
          return null;
        }
      }
      return null;
    }
    return null;
  }

  Future<AddressDataWithUsd> fetchUsdAddressData({String address, String erc20Address}) async {
    try {
      logger.d('Fetching notifications ');
      // Adding Mx to get valid address
      final url =
          "https://explorer-api.minter.network/api/v1/addresses/$address?withSum=true";
      logger.d("Fetch Address Data with USDs Url $url");
      Response response = await dio.get(url);



      if (response.statusCode == 200) {
        {

          var data = AddressDataWithUsd.fromJson(response.data);
          return data;
        }
      }
    } on DioError catch (exception) {
      if (exception == null) {
        if (exception == null ||
            exception.toString().contains('SocketException')) {
          throw Exception("Network Error");
        } else if (exception.type == DioErrorType.RECEIVE_TIMEOUT ||
            exception.type == DioErrorType.CONNECT_TIMEOUT) {
          throw Exception(
              "Could'nt connect, please ensure you have a stable network.");
        } else {
          return null;
        }
      }
      return null;
    }
  }

  Future<AdminNotificationsResponse> fetchNotifications() async {
    try {
      logger.d('Fetching notifications ');
      // Adding Mx to get valid address
      final url = "$fusionApiUrl/notifications/";
      logger.d("Fetch Address Data Url $url");
      Response response = await dio.get(url);

      if (response.statusCode == 200) {
        logger.d("Response status code " + response.statusCode.toString());

        return AdminNotificationsResponse.fromJson(response.data);
      }
    } on DioError catch (exception) {
      if (exception == null) {
        if (exception == null ||
            exception.toString().contains('SocketException')) {
          throw Exception("Network Error");
        } else if (exception.type == DioErrorType.RECEIVE_TIMEOUT ||
            exception.type == DioErrorType.CONNECT_TIMEOUT) {
          throw Exception(
              "Could'nt connect, please ensure you have a stable network.");
        } else {
          return null;
        }
      }
      return null;
    }
  }

  Future<StatisticRewardsResponse> fetchRewardStatistics(
      @required String address) async {
    try {
      if (address == null) {
        logger.e('Cannot fetch txs for null address');
        return null;
      }
      if (!address.contains("Mx")) address = "Mx" + address;

      logger.d('Fetching address $address txs ');
      // Adding Mx to get valid address
      final url = "$explorerMainnetUrl/addresses/$address/statistics/rewards";
      logger.d("Fetch Address Data Url $url");
      Response response = await dio.get(url);

      if (response.statusCode == 200) {
        logger.d("Response status code " + response.statusCode.toString());
        var data = StatisticRewardsResponse.fromJson(response.data);
        return data;
      }
    } on DioError catch (exception) {
      if (exception == null) {
        if (exception == null ||
            exception.toString().contains('SocketException')) {
          throw Exception("Network Error");
        } else if (exception.type == DioErrorType.RECEIVE_TIMEOUT ||
            exception.type == DioErrorType.CONNECT_TIMEOUT) {
          throw Exception(
              "Could'nt connect, please ensure you have a stable network.");
        } else {
          return null;
        }
      }
      return null;
    }
  }

  Future<NonceResponse> fetchNonce(@required String address) async {
    try {
      if (address == null) {
        logger.e('Cannot fetch nonce for null address');
        return null;
      }
      if (!address.contains("Mx")) address = "Mx" + address;

      logger.d('Fetching address $address txs ');
      // Adding Mx to get valid address
      final url = "$gateMainnetUrl/nonce/$address";
      logger.d("Fetch Address Data Url $url");
      Response response = await dio.get(url);

      if (response.statusCode == 200) {
        logger.d("Response status code " + response.statusCode.toString());
        var data = NonceResponse.fromJson(response.data);
        return data;
      }
    } on DioError catch (exception) {
      if (exception == null) {
        if (exception == null ||
            exception.toString().contains('SocketException')) {
          throw Exception("Network Error");
        } else if (exception.type == DioErrorType.RECEIVE_TIMEOUT ||
            exception.type == DioErrorType.CONNECT_TIMEOUT) {
          throw Exception(
              "Could'nt connect, please ensure you have a stable network.");
        } else {
          return null;
        }
      }
      return null;
    }
  }

  Future<PushTransactionResult> push(@required PushTransactionRequest) async {}

  Future<bool> checkAccess(Account lastAccount) async {
    try {
      logger.d('Fetching access profile ${lastAccount.seed}');
      final url = "$fusionApiUrl/profile/${lastAccount.seed}?hash=${lastAccount
          .hash}";
      logger.d("Fetch Profile Access Data Url $url");
      Response response = await fusionDio.get(url);

      if (response.statusCode == 200) {
        logger.d("Response status code " + response.statusCode.toString());
        final data = ProfileResponse.fromJson(response.data);
        logger.e("Has Access ---> ${data.hasAccess}");
        return data.hasAccess;
      }
    } on DioError catch (exception) {
      if (exception == null) {
        if (exception == null ||
            exception.toString().contains('SocketException')) {
          throw Exception("Network Error");
        } else if (exception.type == DioErrorType.RECEIVE_TIMEOUT ||
            exception.type == DioErrorType.CONNECT_TIMEOUT) {
          throw Exception(
              "Could'nt connect, please ensure you have a stable network.");
        } else {
          return false;
        }
      }
      return false;
    }
    return false;
  }

  recover(String value, String value2) {}

  //TODO
  Future<RecoverResponse> canRecover(String name, String mnemonic) async {
    try {
      Response response = await fusionDio.post(
          "$fusionApiUrl/profile/restore/status",
          data: CanRecoverRequest(name: name, mnemonic: mnemonic).toJson(),
          options: Options(contentType: "application/json"));

      if (response.statusCode == 200 || response.statusCode == 201) {
        return RecoverResponse.fromJson(response.data);
      } else
        return null;
    } on DioError catch (exception) {
      if (exception == null) {
        if (exception == null ||
            exception.toString().contains('SocketException')) {
          throw Exception("Network Error");
        } else if (exception.type == DioErrorType.RECEIVE_TIMEOUT ||
            exception.type == DioErrorType.CONNECT_TIMEOUT) {
          throw Exception(
              "Could'nt connect, please ensure you have a stable network.");
        } else {
          return null;
        }
      }
    }
  }

  //TODO
  Future<dynamic> fetchTopCurrencies() {}

  //TODO

}
