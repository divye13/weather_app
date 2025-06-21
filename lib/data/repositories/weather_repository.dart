import 'package:weather/data/models/air_quality_model.dart';
import 'package:weather/data/models/current_weather_model.dart';
import 'package:weather/data/models/forecast_model.dart';
import 'package:weather/data/datasources/weather_api_service.dart';

class WeatherRepository {
  final WeatherApiService apiService;

  WeatherRepository(this.apiService);

  Future<CurrentWeather> getCurrentWeather(String city) {
    return apiService.fetchCurrentWeather(city);
  }

  Future<Forecast> getForecast(String city) {
    return apiService.fetchForecast(city);
  }

  Future<AirQuality> getAirQuality(double lat, double lon) {
    return apiService.fetchAirQuality(lat, lon);
  }
}
