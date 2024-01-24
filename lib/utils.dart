
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/models/forcast_day_model.dart';
import 'package:weather_app/models/weather_model.dart';

String calculateTimeDifference(String time){
  DateTime now = DateTime.now();
  DateTime timeNow = DateTime(now.year, now.month, now.day, now.hour, now.minute);
  DateTime timeThen = DateTime.parse(time);
  Duration difference = timeNow.difference(timeThen);
  if(difference.inDays>0){
    return "${difference.inDays} days ago";
  }else if(difference.inHours>0){
    return "${difference.inHours} hours ago";
  }else if (difference.inMinutes>0){
    return "${difference.inMinutes} minutes ago";
  }else if (difference.inSeconds>0){
    return "${difference.inSeconds} seconds ago";
  }else{
    return "just now";
  }
}
String getDayFromDate(String date){
  DateTime dateTime = DateTime.parse(date);
  return DateFormat("EEEE").format(dateTime);
}
Widget getIconFromWeather(WeatherModel model, int height){
  //return appropriate icon based on weather conditions. also take into account if it's day or night
  //use icons from the asset folder

  //check if it's day or night
  bool isDay = model.current.isDay ==1? true:false;
  String icon = model.current.condition.icon;
  print("icons:$icon");
  if(icon.contains("day")){
    if(isDay){
      return Image.asset("assets/icons/day.png",height: height.toDouble());
    }else{
      return Image.asset("assets/icons/night.png", height: height.toDouble());
    }
  }else if(icon.contains("night")){
    if(isDay){
      return Image.asset("assets/icons/day.png",height: height.toDouble());
    }else{
      return Image.asset("assets/icons/night.png", height: height.toDouble());
    }
  }else if(icon.contains("rain")){
    return Image.asset("assets/icons/rain.png", height: height.toDouble());
  }else if(icon.contains("cloudy")){
    return Image.asset("assets/icons/cloudy.png", height: height.toDouble());
  }else if(icon.contains("sunny")){
    return Image.asset("assets/icons/sunny.png", height: height.toDouble());
  }else if(icon.contains("snow")){
    return Image.asset("assets/icons/snow.png", height: height.toDouble());
  }else if(icon.contains("thunder")){
    return Image.asset("assets/icons/thunder.png", height: height.toDouble());
  }else{
    return Image.asset("assets/icons/sun_and_cloud.png", height: height.toDouble());
  }
}
Widget forcastWidgetSmall(Forecastday forecast){
  return Column(
    children: [
      SizedBox(height: 50,
        child: Image.network(
          "https:${forecast.day.condition.icon}",
        ),
      ),
      Text(
        getDayFromDate(forecast.date),
        style: GoogleFonts.inconsolata(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: Colors.white.withOpacity(.5),
          height: 1
        ) ,
      ),
      const SizedBox(height: 10),
      Text(
        "${forecast.day.maxtempC.toInt()}°C",
        style: GoogleFonts.inconsolata(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          height: 1
        ),
      )
    ],
  );
}