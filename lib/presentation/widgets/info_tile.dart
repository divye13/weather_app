import 'package:flutter/material.dart';
import 'package:weather/core/theme/weather_colors.dart';
import 'package:weather/data/models/air_quality_model.dart';
import 'package:weather/data/models/current_weather_model.dart';

class InfoTile extends StatelessWidget {
  final CurrentWeather weather;
  final AirQuality air;

  const InfoTile({super.key, required this.weather, required this.air});

  @override
  Widget build(BuildContext context) {
    final info = [
      {
        'label': 'Humidity',
        'value': '${weather.humidity}%',
        'icon': Icons.water_drop,
      },
      {
        'label': 'Wind',
        'value': '${weather.windSpeed} km/h',
        'icon': Icons.air,
      },
      {
        'label': 'AQI',
        'value': '${air.aqi}/5',
        'icon': Icons.blur_on, // better suited AQI icon
      },
      {
        'label': 'Rain',
        'value': '${weather.rainChance}%', // fallback to 0% if null
        'icon': Icons.grain,
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // const Text('Details', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: info.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisExtent: 60,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemBuilder: (context, index) {
              final item = info[index];
              return Container(
                padding: const EdgeInsets.only(left:12),
                decoration: BoxDecoration(
                  color: WeatherColors.tilecolor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Icon(item['icon'] as IconData, size: 30),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(item['label']! as String, style: const TextStyle(fontSize: 14)),
                        Text(item['value']! as String, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      ],
                    )
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
