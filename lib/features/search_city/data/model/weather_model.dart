import 'package:weather_app/core/entity/weather_entity.dart';

class WeatherModel extends WeatherEntity {
  WeatherModel({
    required super.cityName,
    required super.tempKelvin,
    required super.condition,
    required super.icon,
    required super.humidity,
    required super.windSpeed,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      cityName: json["name"] as String,
      tempKelvin: (json["main"]["temp"] as num).toDouble(),
      condition: json["weather"][0]["main"] as String,
      icon: json["weather"][0]["icon"] as String,
      humidity: (json["main"]["humidity"] as num).toDouble() ,
      windSpeed: (json["wind"]["speed"] as num).toDouble(),
    );
  }
}
