/**
 * @author Daniel Alvarez
 * @email josamogax@gmail.com
 * @create date 2023-02-22 16:14:59
 * @modify date 2023-02-22 16:14:59
 * @desc [description]
 */

import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';

import 'package:weather_portal/classes/BaseService.dart';

class WeatherService {
  BaseService service = BaseService();
  String apiKey = "e342de54804fc43726eb011e37723d21";

  Future<Response> getWeather() async {
    try {
      Position position =
          await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
      double longitude = position.longitude;
      double latitude = position.latitude;
      Response response = await service.request(
          "https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric",
          method: "Get");
      print("_++++++++++++++++++${response.statusCode}");
      return response;
    } on DioError catch (e) {
      throw handleError(e);
    }
  }
}
