import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/entity/weather_entity.dart';
import 'package:weather_app/features/search_city/domain/usecases/get_weather.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetWeather getWeather;

  WeatherBloc(this.getWeather) : super(WeatherInitial()) {
    on<WeatherEvent>((event, emit) {
      emit(WeatherLoading());
    });

    on<GetWeatherEvent>((event, emit) async {
      final res = await getWeather(event.city);

      res.fold((l) {
        print(l.message);

        emit(WeatherFailure(message: l.message));
      }, (r) => emit(WeatherFetched(weatherEntity: r)));
    });
    on<RefreshWeatherEvent>((event, emit) async {
      final res = await getWeather(event.city);

      res.fold((l) => emit(WeatherFailure(message: l.message)),
          (r) => emit(WeatherRefreshed(weatherEntity: r)));
    });
  }
}
