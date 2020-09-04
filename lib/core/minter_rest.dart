import 'package:dio/dio.dart';
import 'package:fusion_wallet/core/abstract/account.dart';
import 'package:fusion_wallet/core/models/address_data.dart';
import 'package:fusion_wallet/core/models/admin_notifications_response.dart';
import 'package:fusion_wallet/core/models/can_recover_request.dart';
import 'package:fusion_wallet/core/models/can_recover_response.dart';
import 'package:fusion_wallet/core/models/create_profile_request.dart';
import 'package:fusion_wallet/core/models/create_push_link_request.dart';
import 'package:fusion_wallet/core/models/create_push_link_response.dart';
import 'package:fusion_wallet/core/models/delegate_ubound_tx_request.dart';
import 'package:fusion_wallet/core/models/exchange_rate_response.dart';
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

  final Dio dio = Dio(dioOptions);
  final Dio fusionDio = Dio(fusionDioOptions);

  void loadInterceptors() async {}

  final logger = injector.get<Logger>();

  //post

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
        return ProfileResponse.fromJson(response.data);
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

  Future<dynamic> multisend() {}

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
      Hive.box<Account>(accountsBox).values.forEach((element) {
        logger.d(
            "Name ${element.name}, hash ${element.hash}, ${element.toString()}");
        if (element != null) _acc = element;
      });

      Response response = await fusionDio.post(
          "$fusionApiUrl/push/create?sender=${sender.isNotEmpty ? sender : _acc}&receiver=$receiver&creatorId=${_acc.sessionKey}",
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

  Future<dynamic> applyPush(String pushId, String to) async {
    try {
      Response response = await fusionDio.put(
          "$fusionApiUrl/push/$pushId?to=$to",
          options: Options(contentType: "application/json"));

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
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

  Future<CoefficientsResponse> fetchCoefficients() async {
    try {
      logger.d('Fetching coefficients');
      // Adding Mx to get valid address
      final url = "$fusionApiUrl/explorer/rates";
      logger.d("Fetch Coefficients Data Url $url");
      Response response = await fusionDio.get(url);

      if (response.statusCode == 200) {
        logger.d("Response status code " + response.statusCode.toString());
        logger.d(response.data);
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
        logger.d("Response status code " + response.statusCode.toString());
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
      logger.d("Fetch Address Data Url $url");
      Response response = await dio.get(url);

      if (response.statusCode == 200) {
        logger.d("Response status code " + response.statusCode.toString());
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
    fetchProfileData(lastAccount.sessionKey, lastAccount.hash).then((value) {
      logger.d(value.hasAccess);
      return value.hasAccess;
    }).catchError((onError) {
      return false;
    });
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
