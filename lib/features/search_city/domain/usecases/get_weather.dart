import 'package:fpdart/fpdart.dart';
import 'package:weather_app/core/error/failure.dart';
import 'package:weather_app/core/entity/weather_entity.dart';
import 'package:weather_app/features/search_city/domain/repository/weather_repo.dart';

class GetWeather {
  final WeatherRepo weatherRepo;

  GetWeather({required this.weatherRepo});

  Future<Either<Failure, WeatherEntity>> call(String city) {
    return weatherRepo.getWeather(city: city);
  }
}
