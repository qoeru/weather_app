import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:weather_app/data/weather_api.dart';
import 'package:weather_app/domain/models/weather.dart';
import 'dart:developer';

part 'weather_page_state.dart';

class WeatherPageCubit extends Cubit<WeatherPageState> {
  WeatherPageCubit() : super(WeatherPageInitial());

  WeatherApi weatherApi = WeatherApi();

  Future<void> getWeather(String cityName) async {
    try {
      Weather weather = await weatherApi.getForecast(cityName);
      weather.city = cityName;
      emit(WeatherPageSuccess(weather: weather));
    } catch (_) {
      emit(WeatherPageError());
    }
  }
}
