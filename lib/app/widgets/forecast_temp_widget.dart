import 'package:flutter/material.dart';
import 'package:weather_app/app/cubit/weather_page_cubit.dart';
import 'package:weather_app/config/theme/theme.dart';
import 'package:weather_app/domain/models/weather.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForecastTempWidget extends StatelessWidget {
  const ForecastTempWidget({Key? key, required this.weather}) : super(key: key);
  final Weather weather;

  @override
  Widget build(BuildContext context) {
    final String iconUrl =
        'https://openweathermap.org/img/wn/${weather.iconId}@2x.png'; //url иконки погоды

    initializeDateFormatting('ru',
        ''); // инициализацирую местность для отображения даты на русском языке
    Intl.defaultLocale = 'ru';
    var now = DateTime.now().toLocal(); //записываю текущую дату в переменную
    var formatter = DateFormat(
        'EEEEE, d MMMM'); //завожу переменную для форматирования даты в стиле (ДЕНЬ НЕДЕЛИ, ЧИСЛО МЕСЯЦ) //строка, содержащая сегодняшнюю даты
    return Container(
      width: MediaQuery.of(context).size.width / 1.2,
      decoration: BoxDecoration(
          color: AppColors.lighterBlue,
          borderRadius: const BorderRadius.all(
            Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
                color: AppColors.darkBlue.withOpacity(0.5),
                blurRadius: 7,
                offset: const Offset(0, 3)),
          ]),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<WeatherPageCubit, WeatherPageState>(
              builder: (context, state) {
                if (state is WeatherShowThree && weather.date != '') {
                  now = DateTime.parse(weather.date);
                }
                return Text(
                  // текущая дата
                  formatter.format(now).toUpperCase(),
                  style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.white,
                      fontWeight: FontWeight.bold),
                );
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(iconUrl), // изображение погоды
                Text(
                  // температура в цельсиях
                  '${toCelsius(weather.temperature)}°C',
                  style: const TextStyle(
                      fontSize: 50,
                      color: AppColors.white,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Text(
              // описание погоды (дождь, облачно, ясно и т.п.)
              weather.name.toUpperCase(),
              style: const TextStyle(
                color: AppColors.white,
                fontSize: 14,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  //скорость ветра
                  children: [
                    Text(
                      '${weather.windSpeed} м/с',
                      style: const TextStyle(
                          color: AppColors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      'Скорость ветра',
                      style: TextStyle(color: AppColors.white),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Column(
                    //влажность
                    children: [
                      Text(
                        '${weather.humidity ~/ 1}%',
                        style: const TextStyle(
                            color: AppColors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      const Text(
                        'Влажность',
                        style: TextStyle(color: AppColors.white),
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

int toCelsius(double temp) {
  // температура из JSON находится в кельвинах, нужно перевести в цельсии
  return ((temp - 273.15) ~/ 1);
}
