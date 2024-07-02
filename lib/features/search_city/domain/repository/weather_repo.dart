import 'package:fpdart/fpdart.dart';
import 'package:weather_app/core/error/failure.dart';
import 'package:weather_app/core/entity/weather_entity.dart';

abstract interface class WeatherRepo {
  Future<Either<Failure, WeatherEntity>> getWeather({required String city});
}
