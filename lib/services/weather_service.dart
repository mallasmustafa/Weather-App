import 'package:dio/dio.dart';

class WeatherService {
  final String apiKey;
  final Dio dio;

  WeatherService({required this.apiKey})
      : dio = Dio(BaseOptions(baseUrl: 'http://api.weatherapi.com/v1/'));

  Future<Map<String, dynamic>> fetchWeather(
      double latitude, double longitude) async {
    final q = "$latitude,$longitude";
    try {
      final response = await dio.get(
        'forecast.json',
        queryParameters: {'q': q, 'key': apiKey, 'days': '6'},
      );
      return response.data;
    } catch (error) {
      print("Error Fetching weather data in WeatherService: $error");
      rethrow;
    }
  }
}
