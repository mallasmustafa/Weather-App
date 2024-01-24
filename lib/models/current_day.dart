import 'package:weather_app/Models/condition_model.dart';

class Current {
  Current({
    required this.lastUpdatedEpoch,
    required this.lastUpdated,
    required this.tempC,
    required this.tempF,
    required this.isDay,
    required this.condition,
    required this.feelsLike,
    required this.humidity,
  });
  late final int lastUpdatedEpoch;
  late final String lastUpdated;
  late final double tempC;
  late final double tempF;
  late final double feelsLike;
  late final int isDay;
  late final Condition condition;
  late final int humidity;

  Current.fromJson(Map<String, dynamic> json) {
    lastUpdatedEpoch = json['last_updated_epoch'];
    lastUpdated = json['last_updated'];
    tempC = json['temp_c'];
    tempF = json['temp_f'];
    isDay = json['is_day'];
    feelsLike = json['feelslike_c'];
    humidity = json['humidity'];
    condition = Condition.fromJson(json['condition']);
  }
}