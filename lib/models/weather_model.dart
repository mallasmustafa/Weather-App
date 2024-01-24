import 'package:weather_app/Models/current_day.dart';
import 'package:weather_app/Models/location_model.dart';
import 'package:weather_app/models/forcast_model.dart';

class WeatherModel {
  WeatherModel({
    required this.location,
    required this.current,
    required this.forecast,
  });
  late final Location location;
  late final Current current;
  late final Forecast forecast;

  WeatherModel.fromJson(Map<String, dynamic> json) {
    location = Location.fromJson(json['location']);
    current = Current.fromJson(json['current']);
    forecast = Forecast.fromJson(json['forecast']);
  }
}