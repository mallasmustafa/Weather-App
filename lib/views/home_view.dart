import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:search_map_place_updated/search_map_place_updated.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:weather_app/constant.dart';
import 'package:weather_app/controllers/weather_controller.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/utils.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final weatherController = Get.put(WeatherController());
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: SafeArea(
        top: false,
        child: Center(
          child: Obx(() {
            if (weatherController.isLoading.value) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset("assets/icons/sun_and_cloud.png", height: 80)
                      .animate(
                        onPlay: (controller) =>
                            controller.repeat(reverse: true),
                      )
                      .fadeIn(
                          curve: Curves.easeIn,
                          duration: const Duration(milliseconds: 500)),
                  const Text(
                    "Loading...",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ],
              );
            }
            final weather = weatherController.weather.value;
            if (weather == null) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/icons/thunder.png",
                    height: 50,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Error Fetching the weather...",
                   style: TextStyle(
                     color: Colors.white,
                     fontSize: 20
                   ),
                  ),
                ],
              );
            }else{
              return  Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: _haiderWidget(weather, context),
                      ),
                      //make listview to show forecast
                      const SizedBox(
                        height: 30,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Weakly Forcast",
                          style: GoogleFonts.inconsolata(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      _forcastWidget(weather),
                    ],
                  ),
                ),
              );
            }
          },
          ),
        ),
      ),
    );
  }
  Widget _forcastWidget(WeatherModel weather){
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 3,
      children: List.generate(weather.forecast.forecastday.length, (index){
        return forcastWidgetSmall(weather.forecast.forecastday[index])
            .animate()
            .fadeIn();
      }),
    );
  }
  Widget _haiderWidget(WeatherModel weather , BuildContext context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Align(
          alignment: Alignment.topRight,
          child: GestureDetector(
            onTap: (){
              _searchBottomSheet(context);
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.transparent.withOpacity(.1),
              ),
              child: const Icon(
                Icons.search,
                color: Colors.white,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Text("${weather.location.region}, ${weather.location.country}",
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.inconsolata(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.white
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Icon(
                      Icons.location_pin,
                      color: Colors.white,
                    )
                  ],
                ),
                Text(
                  "Humidity: ${weather.current.humidity.toInt().toString()}%",
                  style: GoogleFonts.inconsolata(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.white.withOpacity(.5),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        GradientText(
                          "${weather.current.tempC.toInt()}",
                          style: const TextStyle(
                            fontFamily: "AlfaSlabOne",
                            fontSize: 170,
                            height: 1,
                          ),
                          gradientDirection: GradientDirection.ttb,
                          colors: const [
                            Colors.white,
                             Color(0xff35707C),
                          ],
                        ),
                        Positioned(
                          bottom: 0,
                          child: getIconFromWeather(weather, 100),
                        )
                      ],
                    ),
                    const SizedBox(
                      width: 2,
                    ),
                    GradientText(
                      "°",
                      style: const TextStyle(
                        fontFamily:"AlfaSlabOne",
                        fontSize: 120,
                        height: 1,
                      ),
                      gradientDirection: GradientDirection.ttb,
                      colors: const [
                        Colors.white,
                         Color(0xff35707C),
                         Color(0xff35707C),
                      ],
                    ),
                  ]
                ).animate().fadeIn()
              ],
            )
          ],
        ),
        const SizedBox(height: 40),
      ],
    );
  }
   _searchBottomSheet(BuildContext context){
    showModalBottomSheet(
      isScrollControlled: true,
        showDragHandle: true,
        enableDrag: true,
        backgroundColor: Colors.white,
        context: context,
        builder: (context) {
          return SizedBox(
            height: Get.size.height*.8,
            width: double.infinity,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: Column(
                    children: [
                      SearchMapPlaceWidget(
                          apiKey: dotenv.env["GOOGLE_API_KEY"]!,
                        // The language of the autocompletion
                        placeholder: "Search Location",
                        language: "en",
                        iconColor: Colors.white,
                        bgColor: kPrimaryColor.withOpacity(.7),
                        //radius: 30000,
                        onSelected: (Place place)async{
                            final geoLocation = await place.geolocation;
                          //get the longitude and latitude and pass it to the controller
                          Get.find<WeatherController>().fetchWeather(
                            geoLocation!.coordinates.latitude,
                            geoLocation.coordinates.longitude,
                          );
                          Get.back();
                        },
                      ),
                      const SizedBox(height: 20),
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width*.3,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: kPrimaryColor,
                              width: 1
                            )
                          ),
                          child: const Center(
                            child: Text(
                              "Dismiss",
                              style: TextStyle(
                                color: kPrimaryColor,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        },
    );
   }
}
