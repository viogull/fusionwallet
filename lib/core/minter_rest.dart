import 'package:dio/dio.dart';
import 'package:fusion_wallet/core/models/exchange_rate_response.dart';
import 'package:fusion_wallet/core/models/address_data.dart';
import 'package:fusion_wallet/core/models/nonce_response.dart';
import 'package:fusion_wallet/core/models/spec_exchange_rates_response.dart';
import 'package:fusion_wallet/core/models/statistic_rewards_response.dart';
import 'package:fusion_wallet/core/models/transanctions_response.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';

import '../inject.dart';
import 'models/push_transaction_result.dart';

enum MinterNetwork { Main, Test }

class MinterRest {
  final MinterNetwork networkType;

  static const fusionRestUrl = "https://api.minter-push.cash/";

  static const explorerMainnetUrl =
      "https://explorer-api.minter.network/api/v1";
  static const explorerTestnetUrl =
      "https://testnet.explorer-api.minter.network/api/v1/";

  static const gateMainnetUrl = "https://gate-api.minter.network/api/v1/";
  static const gateTestnetUrl =
      "https://testnet.gate-api.minter.network/api/v1/";

  static const exchangeRatesUrl = "https://bipchange.org/api/";

  static const FUSION_DELEGATE_NODE =
      "Mp4926c68cec9b85d743810c801c35c33bd3d1e74ae0a801e4e08998e656835727";

  static specExchangeRatesUrl(String exchange) =>
      "https://bipchange.org/api/ex/$exchange";

  static MinterRest _instance = new MinterRest.internal();
  MinterRest.internal({this.networkType = MinterNetwork.Test});
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

  final Dio dio = Dio(dioOptions);

  final logger = injector.get<Logger>();

  Future<bool> synchronize(
      {@required String playerId,
      @required String publicKey,
      @required String name}) async {
    try {
      Response response = await dio.post("$fusionRestUrl/profile/create",
          data: {
            "name": name,
            "player_id": playerId,
            "publicKey": publicKey,
          },
          options: Options(contentType: "application/json"));

      if (response.statusCode == 200 || response.statusCode == 201) {
        // response -> response.data;
        return response.data != null;
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
      @required String address) async {
    try {
      if (address == null) {
        logger.e('Cannot fetch txs for null address');
        return null;
      }
      if (!address.contains("Mx")) address = "Mx" + address;

      logger.d('Fetching address $address txs ');
      // Adding Mx to get valid address
      final url = "$explorerMainnetUrl/transactions?address=$address";
      logger.d("Fetch Address Data Url $url");
      Response response = await dio.get(url);

      if (response.statusCode == 200) {
        logger.d("Response status code " + response.statusCode.toString());
        var data = TransactionsResponse.fromJson(response.data);
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

  Future<String> sign(dynamic txData, String privateKey) async {}

  Future<PushTransactionResult> push(@required PushTransactionRequest) async {}

  Future<String> send(
      String receiver, num value, String coin, String privKey) async {
    try {
      Response response = await dio.post("$fusionRestUrl/tx/send",
          data: {
            "to": receiver,
            "value": value,
            "coin": coin,
            "privateKey": privKey
          },
          options: Options(contentType: "application/json"));

      if (response.statusCode == 200 || response.statusCode == 201) {
        // response -> response.data;
        return response.data['hash'];
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

  Future<String> delegate(String pubkey, String coin, num stake) async {}

  Future<String> ubound(String pubkey, String coin, num stake) async {}
}
