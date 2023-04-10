import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:weather_app/domain/models/.env.dart';
import 'package:weather_app/domain/models/weather.dart';
import 'package:weather_app/domain/models/geocoding.dart';

class WeatherApi {
  Future getLocation(String cityName) async {
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

  Future getForecast(String cityName) async {
    Geocoding geocoding = await getLocation(cityName);
    try {
      http.Response response = await http.get(Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?lat=${geocoding.lat}&lon=${geocoding.lon}&appid=$openWeatherApiKey'));
      if (response.statusCode == 200) {
        return Weather.fromJson(jsonDecode(response.body.toString()));
      }
    } catch (e) {
      log('Weather issue: $e');
    }
  }
}
