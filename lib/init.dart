import 'package:get_it/get_it.dart';
import 'package:weather_app/features/search_city/data/datasources/weather_remote_datasource.dart';
import 'package:weather_app/features/search_city/data/repository/weather_repo_impl.dart';
import 'package:weather_app/features/search_city/domain/repository/weather_repo.dart';
import 'package:weather_app/features/search_city/domain/usecases/get_weather.dart';
import 'package:weather_app/features/search_city/presentation/bloc/weather_bloc.dart';

final servicelocator = GetIt.instance;

initDependencies() {
  servicelocator.registerFactory<WeatherRemoteDatasource>(
      () => WeatherRemoteDatasourceImpl());

  servicelocator.registerFactory<WeatherRepo>(
      () => WeatherRepoImpl(weatherRemoteDatasource: servicelocator()));

  servicelocator
      .registerFactory(() => GetWeather(weatherRepo: servicelocator()));

  servicelocator.registerLazySingleton<WeatherBloc>(() => WeatherBloc(servicelocator()));
}
