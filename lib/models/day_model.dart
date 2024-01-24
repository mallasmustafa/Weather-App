import 'package:weather_app/Models/condition_model.dart';

class Day {
  Day({
    required this.maxtempC,
    required this.maxtempF,
    required this.mintempC,
    required this.mintempF,
    required this.avgtempC,
    required this.avgtempF,
    required this.condition,
  });
  late final double maxtempC;
  late final double maxtempF;
  late final double mintempC;
  late final double mintempF;
  late final double avgtempC;
  late final double avgtempF;
  late final Condition condition;

  Day.fromJson(Map<String, dynamic> json) {
    maxtempC = json['maxtemp_c'];
    maxtempF = json['maxtemp_f'];
    mintempC = json['mintemp_c'];
    mintempF = json['mintemp_f'];
    avgtempC = json['avgtemp_c'];
    avgtempF = json['avgtemp_f'];
    condition = Condition.fromJson(json['condition']);
  }
}