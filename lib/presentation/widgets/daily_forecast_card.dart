import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/core/theme/weather_colors.dart';
import 'package:weather/data/models/forecast_model.dart';
import 'package:weather/data/models/hourly_forecast_model.dart';

class DailyForecast extends StatelessWidget {
  final Forecast forecast;
  const DailyForecast({super.key, required this.forecast});

  @override
  Widget build(BuildContext context) {
    final int timezoneOffset = forecast.timezone; // in seconds

    // Step 1: Group forecast items by local date
    final Map<String, List<HourlyForecast>> groupedByDay = {};

    for (final item in forecast.items) {
      final localDateTime = item.dateTime.add(Duration(seconds: timezoneOffset));
      final dayKey = DateFormat('yyyy-MM-dd').format(localDateTime);
      groupedByDay.putIfAbsent(dayKey, () => []).add(item);
    }

    final todayKey = DateFormat('yyyy-MM-dd').format(
      DateTime.now().toUtc().add(Duration(seconds: timezoneOffset)),
    ); // get today's date in location time

    // Step 2: Build a list of daily summaries
    final dailySummaries = groupedByDay.entries.map((entry) {
      final date = DateTime.parse(entry.key); // already adjusted
      final entries = entry.value;

      // ✅ Special case: If it's today, use all today's data (not just grouped entries)
      final isToday = entry.key == todayKey;
      final List<HourlyForecast> fullDayEntries = isToday
          ? forecast.items
              .where((e) => DateFormat('yyyy-MM-dd').format(
                      e.dateTime.add(Duration(seconds: timezoneOffset))) ==
                  todayKey)
              .toList()
          : entries;

      double minTemp = fullDayEntries.first.temperature;
      double maxTemp = fullDayEntries.first.temperature;
      String icon = fullDayEntries.first.icon;

      for (var e in fullDayEntries) {
        if (e.temperature < minTemp) minTemp = e.temperature;
        if (e.temperature > maxTemp) maxTemp = e.temperature;

        // Prefer the 12 PM icon based on location time
        final localHour = e.dateTime.add(Duration(seconds: timezoneOffset)).hour;
        if (localHour == 12) icon = e.icon;
      }

      return {
        'date': date,
        'min': minTemp.round(),
        'max': maxTemp.round(),
        'icon': icon,
      };
    }).toList();

    // Step 3: Sort & take next 5 days
    dailySummaries.sort((a, b) => (a['date'] as DateTime).compareTo(b['date'] as DateTime));
    final next5Days = dailySummaries.take(5).toList();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            decoration: BoxDecoration(
              color: WeatherColors.tilecolor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: next5Days.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final item = next5Days[index];
                final itemDate = item['date'] as DateTime;
                final iconUrl = 'https://openweathermap.org/img/wn/${item['icon']}@2x.png';
                final min = item['min'];
                final max = item['max'];

                // ✅ Get today's date in the forecast location timezone
                final today = DateTime.now().toUtc().add(Duration(seconds: forecast.timezone));
                final isToday = itemDate.year == today.year &&
                                itemDate.month == today.month &&
                                itemDate.day == today.day;

                final dayLabel = isToday
                    ? 'Today'
                    : DateFormat('EEE').format(itemDate); // e.g. Mon, Tue...

                return Row(
                  children: [
                    Text(dayLabel, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    const Spacer(),
                    Image.network(iconUrl, width: 35, height: 35),
                    const SizedBox(width: 8),
                    Text('$min°C / $max°C', style: const TextStyle(fontSize: 16)),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:weather/core/theme/weather_colors.dart';
// import 'package:weather/data/models/forecast_model.dart';
// import 'package:weather/data/models/hourly_forecast_model.dart';

// class DailyForecast extends StatelessWidget {
//   final Forecast forecast;
//   const DailyForecast({super.key, required this.forecast});

//   @override
//   Widget build(BuildContext context) {
//     final int timezoneOffset = forecast.timezone; // in seconds

//     // Step 1: Group forecast items by local date
//     final Map<String, List<HourlyForecast>> groupedByDay = {};

//     for (final item in forecast.items) {
//       final localDateTime = item.dateTime.add(Duration(seconds: timezoneOffset));
//       final dayKey = DateFormat('yyyy-MM-dd').format(localDateTime);
//       groupedByDay.putIfAbsent(dayKey, () => []).add(item);
//     }

//     // Step 2: Build a list of daily summaries
//     final dailySummaries = groupedByDay.entries.map((entry) {
//       final date = DateTime.parse(entry.key); // already adjusted
//       final entries = entry.value;

//       double minTemp = entries.first.temperature;
//       double maxTemp = entries.first.temperature;
//       String icon = entries.first.icon;

//       for (var e in entries) {
//         if (e.temperature < minTemp) minTemp = e.temperature;
//         if (e.temperature > maxTemp) maxTemp = e.temperature;

//         // Prefer the 12 PM icon based on location time
//         final localHour = e.dateTime.add(Duration(seconds: timezoneOffset)).hour;
//         if (localHour == 12) icon = e.icon;
//       }

//       return {
//         'date': date,
//         'min': minTemp.round(),
//         'max': maxTemp.round(),
//         'icon': icon,
//       };
//     }).toList();

//     // Step 3: Sort & take next 5 days
//     dailySummaries.sort((a, b) => (a['date'] as DateTime).compareTo(b['date'] as DateTime));
//     final next5Days = dailySummaries.take(5).toList();

//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const SizedBox(height: 16),
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
//             decoration: BoxDecoration(
//               color: WeatherColors.tilecolor,
//               borderRadius: BorderRadius.circular(16),
//             ),
//             child: ListView.separated(
//               shrinkWrap: true,
//               physics: const NeverScrollableScrollPhysics(),
//               itemCount: next5Days.length,
//               separatorBuilder: (_, __) => const SizedBox(height: 12),
//               itemBuilder: (context, index) {
//                 final item = next5Days[index];
//                 final dayName = DateFormat('EEE').format(item['date'] as DateTime); // e.g. Mon
//                 final iconUrl = 'https://openweathermap.org/img/wn/${item['icon']}@2x.png';
//                 final min = item['min'];
//                 final max = item['max'];

//                 return Row(
//                   children: [
//                     Text(dayName, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//                     const Spacer(),
//                     Image.network(iconUrl, width: 35, height: 35),
//                     const SizedBox(width: 8),
//                     Text('$min°C / $max°C', style: const TextStyle(fontSize: 16)),
//                   ],
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
