import 'package:flutter/material.dart';
import 'package:weather_app/app/cubit/weather_page_cubit.dart';
import 'app/pages/search_page.dart';
import 'app/pages/hourly_weather_page.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(BlocProvider<WeatherPageCubit>(
    create: (context) => WeatherPageCubit(),
    child: MainApp(),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocBuilder<WeatherPageCubit, WeatherPageState>(
        builder: (context, state) {
          if (state is WeatherPageInitial) {
            return SearchPage();
          }
          if (state is WeatherPageSuccess) {
            return HourlyWeatherPage(weather: state.weather);
          }
          return Placeholder();
        },
      ),
    );
  }
}
