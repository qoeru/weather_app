import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/app/cubit/weather_page_cubit.dart';
import 'package:weather_app/app/pages/three_days_weather.dart';
import 'package:weather_app/app/widgets/forecast_temp_widget.dart';
import 'package:weather_app/domain/models/weather.dart';

class HourlyWeatherPage extends StatelessWidget {
  const HourlyWeatherPage({Key? key, required this.weather}) : super(key: key);

  final Weather weather;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(weather.city),
        leading: IconButton(
            onPressed: () {
              context.read<WeatherPageCubit>().resetWeather();
            },
            icon: const Icon(Icons.arrow_back)),
        actions: [
          IconButton(
              onPressed: () {
                context
                    .read<WeatherPageCubit>()
                    .getThreeDaysWeather(weather.city);
              },
              icon: const Icon(Icons.more_horiz))
        ],
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [ForecastTempWidget(weather: weather)]),
      ),
    );
  }
}
