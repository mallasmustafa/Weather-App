import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/location_service.dart';
import 'package:weather_app/services/weather_service.dart';

class WeatherController extends GetxController{
  final WeatherService weatherService = WeatherService(apiKey: dotenv.env["API_KEY"]!);
  LocationService locationService = LocationService();
  Rx<WeatherModel?> weather = Rx<WeatherModel?>(null);
  final isLoading = false.obs;

  Future<void> fetchWeather(double latitude, double longitude)async{
    print("Fetching weather ..");
    try{
      final data = await weatherService.fetchWeather(latitude, longitude);
      final weatherData = WeatherModel.fromJson(data);
      weather.value=weatherData;
    }catch(error){
      print("$error");
    }
  }
  Future<Map> extractLocationCoordinate()async{
    try{
      Position currentPosition = await locationService.getCurrentLocation();
      //extract latitude and longitude
      final latitude = currentPosition.latitude;
      final longitude = currentPosition.longitude;
      //return latitude and longitude as map
      return{"latitude": latitude, "longitude": longitude};
    }catch(error){
      print("Error getting current position$error");
    }
    return {};
  }
  @override
  void onInit() {
    isLoading.value=true;
    extractLocationCoordinate().then((coordinates)async{
      final latitude = coordinates["latitude"];
      final longitude = coordinates["longitude"];
      if(latitude!=null&&longitude!=null){
        await fetchWeather(latitude, longitude);
      }
      isLoading.value=false;
    });
    super.onInit();
  }
}