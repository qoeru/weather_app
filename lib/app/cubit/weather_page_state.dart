part of 'weather_page_cubit.dart';

@immutable
abstract class WeatherPageState {}

class WeatherPageError extends WeatherPageState {}

class WeatherPageLoading extends WeatherPageState {}

class WeatherPageSuccess extends WeatherPageState {
  Weather weather;

  WeatherPageSuccess({required this.weather});
}

class WeatherPageInitial extends WeatherPageState {}

class WeatherShowThree extends WeatherPageState {
  List<Weather> weathers;

  WeatherShowThree({required this.weathers});
}
