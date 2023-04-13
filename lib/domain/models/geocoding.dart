// данные из api передаются только
// при запросе с координатами, но не с городом.
// для начала нужно превратить название города
// в координаты с помощью еще одного запроса.

class Geocoding {
  double lon;
  double lat;

  Geocoding({required this.lat, required this.lon});

  factory Geocoding.fromJson(List<dynamic> js) {
    Map<String, dynamic> json = js[0];
    return Geocoding(lat: json['lat'].toDouble(), lon: json['lon'].toDouble());
  }
}
