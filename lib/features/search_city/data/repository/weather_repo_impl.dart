import 'package:fpdart/fpdart.dart';
import 'package:weather_app/core/error/exceptions.dart';
import 'package:weather_app/core/error/failure.dart';
import 'package:weather_app/features/search_city/data/datasources/weather_remote_datasource.dart';
import 'package:weather_app/core/entity/weather_entity.dart';
import 'package:weather_app/features/search_city/domain/repository/weather_repo.dart';

class WeatherRepoImpl implements WeatherRepo {
  final WeatherRemoteDatasource weatherRemoteDatasource;

  WeatherRepoImpl({required this.weatherRemoteDatasource});

  @override
  Future<Either<Failure, WeatherEntity>> getWeather(
      {required String city}) async {
    try {
      final weather = await weatherRemoteDatasource.getWeatherDetails(city);

      return right(weather);
    } on APiException catch (e) {
      return left(Failure(e.message));
    }
  }
}
