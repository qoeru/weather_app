import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:weather_app/domain/models/weather.dart';

class ForecastTempWidget extends StatelessWidget {
  const ForecastTempWidget({Key? key, required this.weather}) : super(key: key);
  final Weather weather;

  @override
  Widget build(BuildContext context) {
    final String iconUrl =
        'https://openweathermap.org/img/wn/${weather.iconId}@2x.png';
    return Column(
      children: [
        Image.network(iconUrl),
        Text(
          '${toCelsius(weather.temperature).toString()}°C',
          style: TextStyle(fontSize: 50),
        ),
        Text(weather.name),
      ],
    );
  }
}

int toCelsius(double temp) {
  return ((temp - 273.15) ~/ 1);
}
