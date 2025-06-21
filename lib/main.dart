import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/data/datasources/weather_api_service.dart';
import 'package:weather/data/repositories/weather_repository.dart';
import 'package:weather/logic/weather_bloc/weather_bloc.dart';
import 'package:weather/logic/weather_bloc/weather_state.dart';
import 'package:weather/presentation/pages/weather_page.dart';
import 'package:weather/core/secrets.dart';
import 'package:weather/core/theme/weather_background.dart';

void main() {
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    final apiService = WeatherApiService(openWeatherApiKey);
    final weatherRepository = WeatherRepository(apiService);

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: weatherRepository),
      ],
      child: BlocProvider(
        create: (_) => WeatherBloc(weatherRepository),
        child: BlocBuilder<WeatherBloc, WeatherState>(
          builder: (context, state) {
            Color backgroundColor = Colors.black; // fallback

            if (state is WeatherLoaded) {
              final weather = state.currentWeather;
              final localTime = DateTime.fromMillisecondsSinceEpoch(
                (weather.dt + weather.timezone) * 1000,
                isUtc: true,
              );
              final isNight = localTime.hour < 6 || localTime.hour > 18;
              // print(localTime);
              backgroundColor = WeatherBackground.getBackgroundColor(
                weather.main,
                isNight,
              );
            }

            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Weather App',
              theme: ThemeData.dark().copyWith(
                scaffoldBackgroundColor: backgroundColor,
                textTheme: ThemeData.dark().textTheme.apply(
                      bodyColor: Colors.white,
                    ),
              ),
              home: const WeatherPage(),
            );
          },
        ),
      ),
    );
  }
}
