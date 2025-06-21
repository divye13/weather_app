import 'package:flutter/material.dart';
import 'package:weather/core/theme/weather_colors.dart';
import 'package:weather/data/models/forecast_model.dart';
import 'package:intl/intl.dart';

class HourlyForecast extends StatelessWidget {
  final Forecast forecast;
  const HourlyForecast({super.key, required this.forecast});

  @override
  Widget build(BuildContext context) {
    final hourlyData = forecast.items.take(6).toList(); // next 6 time slots
    // final timezoneOffset = forecast.timezone; // in seconds

    return SizedBox(
      height: 120,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: hourlyData.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final hour = hourlyData[index];
          
          // Convert to local time of searched city
          final locationTime = hour.dateTime.add(Duration(seconds: forecast.timezone));
          final time = DateFormat('HH:mm').format(locationTime);
          
          final temp = '${hour.temperature.round()}°C';
          final iconUrl = 'https://openweathermap.org/img/wn/${hour.icon}@2x.png';

          return Container(
            padding: const EdgeInsets.only(right: 12, left: 12, top: 4, bottom: 4),
            decoration: BoxDecoration(
              color: WeatherColors.tilecolor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(time, style: const TextStyle(fontSize: 14)),
                const SizedBox(height: 8),
                Image.network(iconUrl, width: 35, height: 35),
                const SizedBox(height: 8),
                Text(temp, style: const TextStyle(fontSize: 16)),
              ],
            ),
          );
        },
      ),
    );
  }
}
