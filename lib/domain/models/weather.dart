class Weather {
  String city;
  String name;
  String iconId;
  double temperature; // температура
  double humidity; // здесь температура и влажность
  double windSpeed;
  String date; // здесь скорость ветра

  Weather(
      {required this.name,
      this.city = '',
      this.date = '',
      required this.iconId,
      required this.temperature,
      required this.humidity,
      required this.windSpeed}); // конструктор, где все параметры обязательны

  factory Weather.fromCurrentJson(Map<String, dynamic> json) {
    return Weather(
      name: json['weather'][0]['description'] as String,
      iconId: json['weather'][0]['icon'] as String,
      temperature: json['main']['temp'].toDouble(),
      humidity: json['main']['humidity'].toDouble(),
      windSpeed: json['wind']['speed'].toDouble(),
    );
  }

  factory Weather.fromFiveDaystJson(Map<String, dynamic> json, int index) {
    return Weather(
      name: json['list'][index]['weather'][0]['description'] as String,
      iconId: json['list'][index]['weather'][0]['icon'] as String,
      temperature: json['list'][index]['main']['temp'].toDouble(),
      humidity: json['list'][index]['main']['humidity'].toDouble(),
      windSpeed: json['list'][index]['wind']['speed'].toDouble(),
      date: json['list'][index]['dt_txt'] as String,
    );
  }
}
