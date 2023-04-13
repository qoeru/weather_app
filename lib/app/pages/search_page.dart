import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/app/cubit/weather_page_cubit.dart';
import 'package:weather_app/app/widgets/loading_widget.dart';
import 'package:weather_app/config/theme/theme.dart';
import 'package:weather_app/data/weather_api.dart';
import 'package:weather_app/domain/models/weather.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    var _textController = TextEditingController();

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(centerTitle: true, title: Text('Погода')),
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<WeatherPageCubit, WeatherPageState>(
                builder: (context, state) {
              if (state is WeatherPageError) {
                return const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    'Ошибка получения данных',
                    style: TextStyle(color: Colors.red, fontSize: 17),
                  ),
                );
              }
              return const SizedBox();
            }),
            TextFormField(
              controller: _textController,
              decoration: const InputDecoration(
                label: Text('Введите название города'),
                fillColor: AppColors.white,
                filled: true,
                border: OutlineInputBorder(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: BlocBuilder<WeatherPageCubit, WeatherPageState>(
                builder: (context, state) {
                  if (state is WeatherPageLoading) {
                    return const LoadingWidget();
                  }
                  return FilledButton(
                    style: const ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(AppColors.lightBlue)),
                    onPressed: () {
                      context
                          .read<WeatherPageCubit>()
                          .getWeather(_textController.text);
                    },
                    child: const Text(
                      'Поиск',
                      style: TextStyle(
                          color: AppColors.white, fontWeight: FontWeight.bold),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
