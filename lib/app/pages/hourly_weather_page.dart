import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/app/cubit/weather_page_cubit.dart';
import 'package:weather_app/app/widgets/forecast_temp_widget.dart';
import 'package:weather_app/data/weather_api.dart';
import 'package:weather_app/domain/models/weather.dart';

class HourlyWeatherPage extends StatelessWidget {
  const HourlyWeatherPage({Key? key, required this.weather}) : super(key: key);

  final Weather weather;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [ForecastTempWidget(weather: weather)])),
    );
  }
}
