import 'package:weather_app/Models/day_model.dart';

class Forecastday {
  Forecastday({
    required this.date,
    required this.day,
  });
  late final String date;
  late final Day day;

  Forecastday.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    day = Day.fromJson(json['day']);
  }
}