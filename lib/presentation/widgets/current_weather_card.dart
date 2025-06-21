import 'package:flutter/material.dart';
import 'package:weather/data/models/current_weather_model.dart';

class CurrentWeatherCard extends StatelessWidget {
  final CurrentWeather weather;

  const CurrentWeatherCard({super.key, required this.weather});
  

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: Colors.transparent,
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16.0, right: 16.0, left: 16.0),
        child: Column(
          children: [
            Text(
              '${weather.temperature.toStringAsFixed(0)}°C',
              style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              capitalizeEachWord(weather.description),
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.thermostat, size: 16),
                const SizedBox(width: 4),
                Text('Feels like ${weather.feelsLike.toStringAsFixed(0)}°C',style: TextStyle(fontSize: 16),),
              ],
            ),
          ],
        ),
      ),
    );
    
  }
  String capitalizeEachWord(String input) {
    return input
        .toLowerCase()
        .split(' ')
        .map((word) => word.isNotEmpty
            ? '${word[0].toUpperCase()}${word.substring(1)}'
            : '')
        .join(' ');
  }
}

