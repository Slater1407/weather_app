import 'package:flutter/material.dart';
import 'package:weather_app/pages/weather.page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.black,
            primary: Colors.black,
            secondary: const Color.fromARGB(255, 6, 63, 6)),
      ),
      home: const WeatherPage(),
    );
  }
}
