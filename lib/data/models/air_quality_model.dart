// lib/data/models/air_quality_model.dart
class AirQuality {
  final int aqi;

  AirQuality({required this.aqi});

  factory AirQuality.fromJson(Map<String, dynamic> json) {
    return AirQuality(
      aqi: json['list'][0]['main']['aqi'],
    );
  }
}
