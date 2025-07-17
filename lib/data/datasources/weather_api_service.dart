import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather/data/models/current_weather_model.dart';
import 'package:weather/data/models/forecast_model.dart';
import 'package:weather/data/models/air_quality_model.dart';

class WeatherApiService {
  final String apiKey;

  WeatherApiService(this.apiKey); //constructor

  final String baseUrl = 'https://api.openweathermap.org/data/2.5';

  Future<CurrentWeather> fetchCurrentWeather(String city) async {
    final url = Uri.parse('$baseUrl/weather?q=$city&units=metric&appid=$apiKey');
    final response = await http.get(url); //url is used to fetch the information from the web with the help of REST API

    if (response.statusCode == 200) {
      return CurrentWeather.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load current weather');
    }
  }

  Future<Forecast> fetchForecast(String city) async {
    final url = Uri.parse('$baseUrl/forecast?q=$city&units=metric&appid=$apiKey');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return Forecast.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load forecast');
    }
  }

  Future<AirQuality> fetchAirQuality(double lat, double lon) async {
    final url = Uri.parse('$baseUrl/air_pollution?lat=$lat&lon=$lon&appid=$apiKey');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return AirQuality.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load air quality');
    }
  }
}
