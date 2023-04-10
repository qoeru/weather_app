import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/app/cubit/weather_page_cubit.dart';
import 'package:weather_app/data/weather_api.dart';
import 'package:weather_app/domain/models/weather.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    var _textController = TextEditingController();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _textController,
            ),
            FilledButton(
              onPressed: () {
                context
                    .read<WeatherPageCubit>()
                    .getWeather(_textController.text);
              },
              child: const Text('Поиск'),
            )
          ],
        ),
      ),
    );
  }
}
