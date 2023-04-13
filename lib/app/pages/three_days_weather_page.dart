import 'package:flutter/material.dart';
import 'package:weather_app/app/widgets/forecast_temp_widget.dart';
import 'package:weather_app/domain/models/weather.dart';

// страница с прогнозом за три дня

class ThreeDaysWeatherPage extends StatelessWidget {
  const ThreeDaysWeatherPage({Key? key, required this.weathers})
      : super(key: key);

  final List<Weather> weathers;

  @override
  Widget build(BuildContext context) {
    List<Weather> weathersToShow =
        swapMinElement(weathers); // сортировка прогнозов по температуре

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(weathersToShow[0].city),
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
            ForecastTempWidget(weather: weathersToShow[0]),
            const SizedBox(
              height: 10,
            ),
            ForecastTempWidget(weather: weathersToShow[1]),
            const SizedBox(
              height: 10,
            ),
            ForecastTempWidget(weather: weathersToShow[2]),
          ],
        ),
      ),
    );
  }
}

List<Weather> swapMinElement(List<Weather> weathers) {
  Weather min = weathers.first;
  int index = 0;

  for (int i = 0; i < 3; i++) {
    if (weathers[i].temperature < min.temperature) {
      min = weathers[i];
      index = i;
    }
  }

  Weather tmp = weathers.first;

  weathers.first = min;
  weathers[index] = tmp;

  return weathers;
}
