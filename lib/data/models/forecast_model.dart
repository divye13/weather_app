import 'hourly_forecast_model.dart';

class Forecast {
  final List<HourlyForecast> items;
  final int timezone; // ⬅️ Add this

  Forecast({
    required this.items,
    required this.timezone,
  });

  factory Forecast.fromJson(Map<String, dynamic> json) {
    final List<dynamic> list = json['list'];
    final int timezone = json['city']?['timezone'] ?? 0; // in seconds

    final items = list
        .map((item) => HourlyForecast.fromJson(item))
        .toList();

    return Forecast(
      items: items,
      timezone: timezone,
    );
  }
}
