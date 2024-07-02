//Remote datasource connector , (API in this case)

import 'dart:convert';

import 'package:weather_app/core/error/exceptions.dart';
import 'package:weather_app/features/search_city/data/model/weather_model.dart';
import 'package:http/http.dart' as http;

abstract interface class WeatherRemoteDatasource {
  Future<WeatherModel> getWeatherDetails(String city);
}

class WeatherRemoteDatasourceImpl implements WeatherRemoteDatasource {
  @override
  Future<WeatherModel> getWeatherDetails(String city) async {
    try {
      final response = await http.get(Uri.parse(
          "https://api.openweathermap.org/data/2.5/weather?q=$city&appid=2d0b4437ac83074c8e944738118b97f4"));

      final body = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return WeatherModel.fromJson(body);
      } else {
        throw APiException(message: body["message"].toString());
      }
    } catch (e) {
      throw APiException(message: e.toString());
    }
  }
}
