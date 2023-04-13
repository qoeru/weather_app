import 'package:flutter/material.dart';
import 'package:weather_app/app/widgets/forecast_temp_widget.dart';
import 'package:weather_app/domain/models/weather.dart';

class ThreeDaysWeatherPage extends StatelessWidget {
  const ThreeDaysWeatherPage({Key? key, required this.weathers})
      : super(key: key);

  final List<Weather> weathers;

  @override
  Widget build(BuildContext context) {
    weathers.sort((a, b) => a.temperature
        .compareTo(b.temperature)); // сортировка прогнозов по температуре

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(weathers[0].city),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ForecastTempWidget(weather: weathers[0]),
            const SizedBox(
              height: 10,
            ),
            ForecastTempWidget(weather: weathers[1]),
            const SizedBox(
              height: 10,
            ),
            ForecastTempWidget(weather: weathers[2]),
          ],
        ),
      ),
    );
  }
}
