/**
 * @author Daniel Alvarez
 * @email josamogax@gmail.com
 * @create date 2023-02-22 16:13:04
 * @modify date 2023-02-22 16:13:04
 * @desc [description]
 */

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:weather_portal/classes/LogginInterceptor.dart';
import 'LocalStorage.dart';

// Duration connectionTO = (60 * 1000) as Duration;
// Duration receiveTO = 60 * 1000;

class BaseService {
  final Dio _dio = Dio(BaseOptions(
      baseUrl: "https://samples.openweathermap.org",
      validateStatus: (status) {
        return status! < 500;
      },
      headers: {
        "Accept": "*/*",
        "Content-Type": "application/json",
        "Connection": "keep-alive",
      },
      connectTimeout: const Duration(minutes: 60, seconds: 1000),
      receiveTimeout: const Duration(minutes: 60, seconds: 1000)))
    ..interceptors.add(LoggingInterceptor());

  Future<Response> request(String url, {dynamic body, String? method}) async {
    var token = LocalStorage.getToken();

    var res = _dio.request(url,
        data: body,
        options: Options(
            method: method, headers: token != null ? {'authorization': 'Bearer $token'} : null));
    return res;
  }
}

handleError(DioError error) {
  if (kDebugMode) {
    print(error.response.toString());
  }
  if (error.message!.contains('SocketException')) {
    return 'Cannot connect. Check that you have internet connection';
  }

  if (error.type == DioErrorType.connectionTimeout) {
    return 'Connection timed out. Please retry.';
  }

  if (error.response == null || error.response!.data is String) {
    return 'Something went wrong. Please try again later';
  }
  return 'Something went wrong. Please try again later';
}
