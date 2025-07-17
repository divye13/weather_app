// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/logic/weather_bloc/weather_bloc.dart';
import 'package:weather/logic/weather_bloc/weather_event.dart';
import 'package:weather/logic/weather_bloc/weather_state.dart';
import 'package:weather/presentation/dialogs/change_city_dialog.dart';
import 'package:weather/presentation/widgets/current_weather_card.dart';
import 'package:weather/presentation/widgets/daily_forecast_card.dart';
import 'package:weather/presentation/widgets/hourly_forecast_card.dart';
import 'package:weather/presentation/widgets/info_tile.dart';
import 'package:weather/data/datasources/city_storage.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});
  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  String _city = 'Delhi'; // fallback
  final _storage = CityStorage();

  @override
  void initState() {
    super.initState();
    _loadAndFetchCity();
  }
  void _loadAndFetchCity() async {
    final savedCity = await _storage.loadCity();
    setState(() => _city = savedCity);
    context.read<WeatherBloc>().add(FetchWeather(savedCity));
  }
  void _changeCity(String newCity) async {
    await _storage.saveCity(newCity);
    setState(() => _city = newCity);
    context.read<WeatherBloc>().add(FetchWeather(newCity));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocListener<WeatherBloc, WeatherState>(
          listener: (context, state) {
            if (state is WeatherError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Error: ${state.message}')),
              );
              showDialog(
                context: context,
                builder: (context) => ChangeCityDialog(onSubmit: _changeCity),
              );
            }
          },
          child: BlocBuilder<WeatherBloc, WeatherState>(
            builder: (context, state) {
              if (state is WeatherLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is WeatherLoaded) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildCityHeader(context),
                      CurrentWeatherCard(weather: state.currentWeather),
                      HourlyForecast(forecast: state.forecast),
                      DailyForecast(forecast: state.forecast),
                      InfoTile(
                        weather: state.currentWeather,
                        air: state.airQuality,
                      ),
                    ],
                  ),
                );
              } else if (state is WeatherError) {
                return Center(child: Text('Error: ${state.message}'));
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ),
      ),
    );
  }
  Widget _buildCityHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          const Icon(Icons.location_on),
          const SizedBox(width: 8),
          Text(
            _city.toUpperCase(),
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.edit_location_alt),
            color: Colors.white,
            onPressed: () => showDialog(
              context: context,
              builder: (_) => ChangeCityDialog(onSubmit: _changeCity),
            ),
          ),
        ],
      ),
    );
  }
}
