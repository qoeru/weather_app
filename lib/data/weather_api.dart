import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:weather_app/domain/models/.env.dart';
import 'package:weather_app/domain/models/weather.dart';
import 'package:weather_app/domain/models/geocoding.dart';

class WeatherApi {
  Future getLocation(String cityName) async {
    //для получения координат из города
    try {
      http.Response response = await http.get(Uri.parse(
          'http://api.openweathermap.org/geo/1.0/direct?q=$cityName&limit=1&appid=$openWeatherApiKey'));
      if (response.statusCode == 200) {
        return Geocoding.fromJson(jsonDecode(response.body));
      }
    } catch (e) {
      log('Geocoding issue: $e');
    }
  }

  Future getCurrentForecast(String cityName) async {
    // для получения прогноза в текущий момент
    Geocoding geocoding = await getLocation(cityName);
    try {
      http.Response response = await http.get(Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?lat=${geocoding.lat}&lon=${geocoding.lon}&lang=ru&appid=$openWeatherApiKey'));
      if (response.statusCode == 200) {
        return Weather.fromCurrentJson(jsonDecode(response.body.toString()));
      }
    } catch (e) {
      log('Weather issue: $e');
    }
  }

  Future getThreeDaysForecast(String cityName) async {
    // для получения прогноза за три дня
    Geocoding geocoding = await getLocation(cityName);
    try {
      http.Response response = await http.get(Uri.parse(
          'https://api.openweathermap.org/data/2.5/forecast?lat=${geocoding.lat}&lon=${geocoding.lon}&lang=ru&appid=$openWeatherApiKey'));
      if (response.statusCode == 200) {
        List<Weather> threeDaysWeather = [];
        for (int i = 0; i < 17; i = i + 8) {
          Weather weather = Weather.fromFiveDaystJson(
              jsonDecode(response.body.toString()), i);
          weather.city = cityName;
          threeDaysWeather.add(weather);
        }
        return threeDaysWeather;
      }
    } catch (e) {
      log('Weather issue: $e');
    }
  }
}
