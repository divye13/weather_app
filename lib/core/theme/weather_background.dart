import 'package:flutter/material.dart';
import 'weather_colors.dart';

class WeatherBackground {
  static Color getBackgroundColor(String main, bool isNight) {
    switch (main.toLowerCase()) {
      case 'thunderstorm':
        return isNight? WeatherColors.nightthunderstorm: WeatherColors.thunderstorm;
      case 'drizzle':
        return WeatherColors.drizzle;
      case 'rain':
        return isNight? WeatherColors.nightrain:WeatherColors.rain;
      case 'snow':
        return isNight? WeatherColors.nightsnow: WeatherColors.snow;
      case 'atmosphere':
        return WeatherColors.atmosphere;
      case 'clouds':
        return isNight? WeatherColors.nigthclouds:WeatherColors.clouds;
      case 'clear':
        return isNight? WeatherColors.nightclear : WeatherColors.clear;
      default:
        return WeatherColors.fallback;
    }
  }
}
