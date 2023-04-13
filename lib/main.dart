import 'package:flutter/material.dart';
import 'package:weather_app/app/cubit/weather_page_cubit.dart';
import 'package:weather_app/app/pages/three_days_weather.dart';
import 'package:weather_app/app/widgets/loading_widget.dart';
import 'app/pages/search_page.dart';
import 'app/pages/hourly_weather_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'config/theme/theme.dart';

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
      theme: lightTheme(),
      home: BlocConsumer<WeatherPageCubit, WeatherPageState>(
        listener: (context, state) {
          if (state is WeatherPageError) {
            // при ошибке загрузки погоды выскакивает снекбар
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Ошибка загрузки города'),
                duration: Duration(seconds: 2),
                backgroundColor: AppColors.lightBlue,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is WeatherPageSuccess) {
            // при правильной загрузке погоды выводится второй экран
            return HourlyWeatherPage(weather: state.weather);
          }
          if (state is WeatherShowThree) {
            // при правильной загрузке погоды выводится второй экран
            return ThreeDaysWeather(weathers: state.weathers);
          }
          // в любом другом случае показывается главный экран
          return SearchPage();
        },
      ),
    );
  }
}
