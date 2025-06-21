class HourlyForecast {
  final DateTime dateTime; // Still UTC
  final double temperature;
  final String icon;

  HourlyForecast({
    required this.dateTime,
    required this.temperature,
    required this.icon,
  });

  factory HourlyForecast.fromJson(Map<String, dynamic> json) {
    return HourlyForecast(
      dateTime: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000, isUtc: true),
      temperature: json['main']['temp'].toDouble(),
      icon: json['weather'][0]['icon'],
    );
  }
}
