import 'package:equatable/equatable.dart';
import 'package:weather/data/models/current_weather_model.dart';
import 'package:weather/data/models/forecast_model.dart';
import 'package:weather/data/models/air_quality_model.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object?> get props => [];
}

class WeatherInitial extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherLoaded extends WeatherState {
  final CurrentWeather currentWeather;
  final Forecast forecast;
  final AirQuality airQuality;

  const WeatherLoaded({
    required this.currentWeather,
    required this.forecast,
    required this.airQuality,
  });

  @override
  List<Object?> get props => [currentWeather, forecast, airQuality];
}

class WeatherError extends WeatherState {
  final String message;

  const WeatherError(this.message);

  @override
  List<Object?> get props => [message];
}
