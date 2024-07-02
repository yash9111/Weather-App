part of 'weather_bloc.dart';

@immutable
sealed class WeatherState {}

final class WeatherInitial extends WeatherState {}

class WeatherFetched extends WeatherState {
  final WeatherEntity weatherEntity;

  WeatherFetched({required this.weatherEntity});
}

class WeatherRefreshed extends WeatherState {
  final WeatherEntity weatherEntity;

  WeatherRefreshed({required this.weatherEntity});
}

class WeatherFailure extends WeatherState{
  final String message;

  WeatherFailure({required this.message});
}
class WeatherLoading extends WeatherState{}
