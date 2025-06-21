import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/logic/weather_bloc/weather_state.dart';
import 'package:weather/logic/weather_bloc/weather_event.dart';
import 'package:weather/data/repositories/weather_repository.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository repository;

  WeatherBloc(this.repository) : super(WeatherInitial()) {
    on<FetchWeather>((event, emit) async {
      emit(WeatherLoading());
      try {
        final current = await repository.getCurrentWeather(event.city);
        final forecast = await repository.getForecast(event.city);
        final air = await repository.getAirQuality(current.latitude, current.longitude);

        emit(WeatherLoaded(
          currentWeather: current,
          forecast: forecast,
          airQuality: air,
        ));
      } catch (e) {
        emit(WeatherError(e.toString()));
      }
    });
  }
}
