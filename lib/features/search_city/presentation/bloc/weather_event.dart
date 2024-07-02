part of 'weather_bloc.dart';

@immutable
sealed class WeatherEvent {}

class GetWeatherEvent extends WeatherEvent{
  final String city;

  GetWeatherEvent({required this.city});
}

class RefreshWeatherEvent extends WeatherEvent{
  final String city;

  RefreshWeatherEvent({required this.city});
}
