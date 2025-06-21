# 🌦️ Weather App

A modern Flutter weather application that displays current weather, hourly and daily forecasts, rain chances, wind speed, humidity, UV index, air pollution, and more — powered by the OpenWeather API.  
The app is built using **Flutter** and **BLoC**, with dynamic background colors based on the current weather and time of day.

---

## 🚀 Features

- 🔍 Manually search cities (no location permissions required)
- 🌡️ Current weather with “feels like” temperature and rain chance
- 📆 5-day forecast with high/low temperature
- 🕒 Hourly forecast adjusted to the city's local time
- 🌬️ Wind speed, humidity, UV index, and dew point
- 🧪 Air pollution data
- 🎨 Background color adapts based on weather and time (e.g., night vs. day)
- 🧱 Clean Architecture with BLoC

---

## 🛠️ Built With

- [Flutter](https://flutter.dev)
- [Dart](https://dart.dev)
- [Flutter BLoC](https://bloclibrary.dev)
- [OpenWeather API](https://openweathermap.org/api)
- [intl](https://pub.dev/packages/intl)
- [http](https://pub.dev/packages/http)

---

## 📦 Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_bloc: ^8.1.3
  http: ^1.2.1
  intl: ^0.18.1

