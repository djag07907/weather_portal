/**
 * @author Daniel Alvarez
 * @email josamogax@gmail.com
 * @create date 2023-02-22 16:29:07
 * @modify date 2023-02-22 16:29:07
 * @desc [description]
 */

import 'package:get/get.dart';
import 'package:weather_portal/classes/weather_class.dart';
import 'package:weather_portal/helpers/weather_snackbar.dart';
import 'package:weather_portal/services/weather_service.dart';
// import 'package:weather_portal/utilities/snack_bar.dart';
// import 'utilities';

class WeatherController extends GetxController {
  final weatherService = Get.put(WeatherService());

  Future<Weather> getWeatherData() async {
    var res;
    try {
      res = await weatherService.getWeather();
      if (res.statusCode != 200 || res.statusCode != 201) {
        return WeatherSnackBars.errorSnackBar(message: res.data['message']);
      } else {}
    } catch (e) {
      WeatherSnackBars.errorSnackBar(message: e.toString());
    }
    return Weather.fromJson(res.data);
  }
}
