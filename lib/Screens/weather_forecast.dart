import 'package:flutter/material.dart';

import '../Model/weather_model.dart';
import '../Services/weather_api_service.dart';

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final TextEditingController _controller = TextEditingController();
  WeatherService _weatherService = WeatherService();
  Weather? _weather;
  bool _loading = false;

  void _fetchWeather() async {
    setState(() {
      _loading = true;
    });
    Weather? weather = await _weatherService.fetchWeather(_controller.text);
    setState(() {
      _loading = false;
      _weather = weather;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather Checking'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _controller,
                decoration: InputDecoration(
                  labelText: 'Enter city name',
                  labelStyle: TextStyle(color: Colors.teal),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.teal),
                  ),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: _fetchWeather,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  textStyle: TextStyle(fontSize: 16),
                ),
                child: Text('Get Weather'),
              ),
              SizedBox(height: 10),
              if (_loading)
                CircularProgressIndicator()
              else if (_weather != null)
                Card(
                  color: Colors.white,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _weather!.cityName,
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.teal,
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Icon(Icons.thermostat, color: Colors.orange),
                            SizedBox(width: 10),
                            Text(
                              'Temperature: ${_weather!.temp}°F',
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Icon(Icons.opacity, color: Colors.teal),
                            SizedBox(width: 10),
                            Text(
                              'Humidity: ${_weather!.humidity}%',
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Icon(Icons.compress, color: Colors.orange),
                            SizedBox(width: 10),
                            Text(
                              'Pressure: ${_weather!.pressure} hPa',
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Icon(Icons.air, color: Colors.teal),
                            SizedBox(width: 10),
                            Text(
                              'Wind: ${_weather!.wind} m/s',
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Text(
                          _weather!.description,
                          style:
                          TextStyle(fontSize: 20, color: Colors.grey[700]),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}