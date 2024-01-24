
import 'package:weather_app/models/forcast_day_model.dart';

class Forecast {
  Forecast({
    required this.forecastday,
  });
  late final List<Forecastday> forecastday;

  Forecast.fromJson(Map<String, dynamic> json) {
    forecastday = List.from(json['forecastday'])
        .map((e) => Forecastday.fromJson(e))
       .toList();
  }
}