
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:weather_app/views/home_view.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  //load .env file
  await dotenv.load(fileName: ".env");
  runApp(
    DevicePreview(
      enabled: false,
      builder: (context) => const MyApp(),)
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      title: "Weather App",
      home: const HomeView(),
    );
  }
}

