import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:weather_app/data/weather_api.dart';
import 'package:weather_app/domain/models/weather.dart';

part 'weather_page_state.dart';

class WeatherPageCubit extends Cubit<WeatherPageState> {
  WeatherPageCubit() : super(WeatherPageInitial());

  WeatherApi weatherApi = WeatherApi();

  Future<void> getWeather(String cityName) async {
    try {
      emit(WeatherPageLoading());
      Weather weather = await weatherApi.getCurrentForecast(cityName);
      weather.city = cityName;
      emit(WeatherPageSuccess(weather: weather));
    } catch (_) {
      emit(WeatherPageError());
    }
  }

  void resetWeather() {
    emit(WeatherPageInitial());
  }

  Future<void> getThreeDaysWeather(String cityName) async {
    List<Weather> weathers = await weatherApi.getThreeDaysForecast(cityName);
    emit(WeatherShowThree(weathers: weathers));
  }
}
