import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/app/cubit/weather_page_cubit.dart';
import 'package:weather_app/app/widgets/forecast_temp_widget.dart';
import 'package:weather_app/domain/models/weather.dart';

class ThreeDaysWeather extends StatelessWidget {
  const ThreeDaysWeather({Key? key, required this.weathers}) : super(key: key);

  final List<Weather> weathers;

  @override
  Widget build(BuildContext context) {
    weathers.sort((a, b) => a.temperature
        .compareTo(b.temperature)); // сортировка прогнозов по температуре

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            context.read<WeatherPageCubit>().getWeather(weathers[0].city);
          },
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ForecastTempWidget(weather: weathers[0]),
          ForecastTempWidget(weather: weathers[1]),
          ForecastTempWidget(weather: weathers[2]),
        ],
      ),
    );
  }
}
