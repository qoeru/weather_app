import 'package:flutter/material.dart';
import 'package:weather_app/app/cubit/weather_page_cubit.dart';
import 'package:weather_app/app/pages/three_days_weather_page.dart';
import 'app/pages/search_page.dart';
import 'app/pages/hourly_weather_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'config/theme/theme.dart';

void main() {
  runApp(BlocProvider<WeatherPageCubit>(
    create: (context) => WeatherPageCubit(),
    child: const MainApp(),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
          if (state is WeatherPageSuccess) {
            // добавление страницы на экран при успешной загрузке погоды
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      HourlyWeatherPage(weather: state.weather)),
            );
          }
          if (state is WeatherShowThree) {
            // добавление страницы на экран при успешной загрузке трех погод
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      ThreeDaysWeatherPage(weathers: state.weathers)),
            );
          }
        },
        builder: (context, state) {
          return const SearchPage();
        },
      ),
    );
  }
}
