import 'dart:convert';

class CurrentWeather {
  final double temperature;
  final int humidity;
  final double windSpeed;
  final String description;
  final String icon;
  final double feelsLike;
  final double rainChance;
  final double latitude;
  final double longitude;
  final String main;
  final int dt;
  final int timezone;


  CurrentWeather({
    required this.temperature,
    required this.humidity,
    required this.windSpeed,
    required this.description,
    required this.icon,
    required this.feelsLike,
    required this.rainChance,
    required this.latitude,
    required this.longitude,
    required this.main,
    required this.dt,
    required this.timezone,
  });

  factory CurrentWeather.fromJson(Map<String, dynamic> json) {
    final weatherList = json['weather'] as List<dynamic>?;
    final weather = (weatherList != null && weatherList.isNotEmpty) ? weatherList[0] : {};
    return CurrentWeather(
      temperature: json['main']['temp'].toDouble(),
      feelsLike: json['main']['feels_like'].toDouble(),
      humidity: json['main']['humidity'],
      windSpeed: json['wind']['speed'].toDouble(),
      description: weather['description'] ?? '',
      icon: weather['icon'] ?? '',
      main: weather['main'] ?? '',
      latitude: json['coord']['lat'].toDouble(),
      longitude: json['coord']['lon'].toDouble(),
      rainChance: (json['rain'] != null && json['rain']['1h'] != null)
          ? json['rain']['1h'].toDouble()
          : 0.0, // default fallback
      dt: json['dt'],
      timezone: json['timezone'],
    );
  }

  CurrentWeather copyWith({
    double? temperature,
    int? humidity,
    double? windSpeed,
    String? description,
    String? main,
    String? icon,
    double? feelsLike,
    double? rainChance,
    double? latitude,
    double? longitude,
    int? dt,
    int? timezone,
  }) 
  {
    return CurrentWeather(
      temperature: temperature ?? this.temperature,
      humidity: humidity ?? this.humidity,
      windSpeed: windSpeed ?? this.windSpeed,
      description: description ?? this.description,
      main: main ?? this.main,
      icon: icon ?? this.icon,
      feelsLike: feelsLike ?? this.feelsLike,
      rainChance: rainChance ?? this.rainChance,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude, 
      dt: dt ?? this.dt,
      timezone: timezone ?? this.timezone,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'temperature': temperature,
      'humidity': humidity,
      'windSpeed': windSpeed,
      'description': description,
      'main': main,
      'icon': icon,
      'feelsLike': feelsLike,
      'rainChance': rainChance,
      'latitude': latitude,
      'longitude': longitude,
      'dt':dt,
      'timezone':timezone,
    };
  }

  factory CurrentWeather.fromMap(Map<String, dynamic> map) {
    return CurrentWeather(
      temperature: map['temperature'] as double,
      humidity: map['humidity'] as int,
      windSpeed: map['windSpeed'] as double,
      description: map['description'] as String,
      main: map['main'] as String,
      icon: map['icon'] as String,
      feelsLike: map['feelsLike'] as double,
      rainChance: (map['rainChance'] ?? 0.0) as double, 
      latitude: map['latitude'] as double,
      longitude: map['longitude'] as double,
      dt: map['dt'] as int,
      timezone: map['timezone'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory CurrentWeather.fromJsonString(String source) =>
      CurrentWeather.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CurrentWeather(temperature: $temperature,dt: $dt,timezone: $timezone, humidity: $humidity, windSpeed: $windSpeed, description: $description,main: $main, icon: $icon, feelsLike: $feelsLike, rainChance: $rainChance, latitude: $latitude, longitude: $longitude,)';
  }

  @override
  bool operator ==(covariant CurrentWeather other) {
    if (identical(this, other)) return true;

    return other.temperature == temperature &&
        other.humidity == humidity &&
        other.windSpeed == windSpeed &&
        other.description == description &&
        other.icon == icon &&
        other.main ==main &&
        other.feelsLike == feelsLike &&
        other.rainChance == rainChance &&
        other.latitude == latitude &&
        other.dt == dt &&
        other.timezone == timezone &&
        other.longitude == longitude;
  }

  @override
  int get hashCode {
    return temperature.hashCode ^
        humidity.hashCode ^
        windSpeed.hashCode ^
        description.hashCode ^
        icon.hashCode ^
        main.hashCode ^
        feelsLike.hashCode ^
        rainChance.hashCode ^
        latitude.hashCode ^
        dt.hashCode ^
        timezone.hashCode ^
        longitude.hashCode;
  }
}
