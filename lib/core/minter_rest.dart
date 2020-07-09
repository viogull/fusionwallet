import 'package:dio/dio.dart';
import 'package:fusion_wallet/core/models/minter/address_data.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';

import '../inject.dart';

class MinterRest {
  static const baseUrl = "https://explorer-api.minter.network/api/v1";

  static MinterRest _instance = new MinterRest.internal();
  MinterRest.internal();
  factory MinterRest() => _instance;

  static const ADDRESS_INFO_URL = baseUrl + "addresses/";

  static final BaseOptions dioOptions = BaseOptions(
      baseUrl: baseUrl,
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

  Future<AddressData> fetchAddressData({@required String address}) async {
    try {
      if (address == null) {
        logger.e('Cannot fetch info for null address');
        return null;
      }
      logger.d('Fetching address $address');
      // Adding Mx to get valid address
      final url = "$baseUrl/addresses/Mx$address";
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
}
