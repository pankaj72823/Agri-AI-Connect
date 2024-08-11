import 'dart:convert';
import 'package:http/http.dart' as http;

import '../Model/weather_model.dart';

class WeatherService {
  final String apiKey = '4703e04ffcmsh214c270174ca39ep1bca10jsn06388b0220a4';
  final String apiHost = 'open-weather13.p.rapidapi.com';

  Future<Weather?> fetchWeather(String cityName) async {
    final url = 'https://$apiHost/city/$cityName/EN';

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'x-rapidapi-key': apiKey,
        'x-rapidapi-host': apiHost,
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return Weather.fromJson(data);
    } else {
      return null;
    }
  }

  fetchWeatherByLocation(double latitude, double longitude) {}
}