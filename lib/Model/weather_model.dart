class Weather {
  final String cityName;
  final String description;
  final String temp;
  final String humidity;
  final String pressure;
  final String wind;
  Weather(
      {required this.cityName,
        required this.description,
        required this.humidity,
        required this.pressure,
        required this.temp,
        required this.wind});

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['name'],
      temp: json['main']['temp'].toString(),
      humidity: json['main']['humidity'].toString(),
      pressure: json['main']['pressure'].toString(),
      wind: json['wind']['speed'].toString(),
      description: json['weather'][0]['description'],
    );
  }
}