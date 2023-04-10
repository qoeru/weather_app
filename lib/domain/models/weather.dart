class Weather {
  String city;
  String name;
  String iconId;
  double temperature; // температура
  double humidity; // здесь температура и влажность
  double windSpeed; // здесь скорость ветра

  Weather(
      {required this.name,
      this.city = '',
      required this.iconId,
      required this.temperature,
      required this.humidity,
      required this.windSpeed}); // конструктор, где все параметры обязательны

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      name: json['weather'][0]['description'] as String,
      iconId: json['weather'][0]['icon'] as String,
      temperature: json['main']['temp'].toDouble(),
      humidity: json['main']['humidity'].toDouble(),
      windSpeed: json['wind']['speed'].toDouble(),
    );
  }
}
