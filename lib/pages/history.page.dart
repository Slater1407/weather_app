import 'package:flutter/material.dart';
import 'package:weather/weather.dart';
import 'package:weather_app/repositories/weather.repo.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    List<Weather> weatherList = WeatherRepo().getReversedWeatherList();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Verlauf',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    Text(weatherList[index].areaName!),
                    const SizedBox(
                      width: 15,
                    ),
                    Text(
                        'Temp: ${weatherList[index].temperature!.celsius!.round()}'),
                    const SizedBox(
                      width: 15,
                    ),
                    Image.network(
                      WeatherRepo().getWeatherIconStringByIndex(index),
                      scale: 1.5,
                    ),
                    Expanded(child: Container()),
                    Text(
                        '${weatherList[index].date!.day}.${weatherList[index].date!.month}.${weatherList[index].date!.year}  ${weatherList[index].date!.hour}:${weatherList[index].date!.second}'),
                  ],
                );
              },
              childCount: weatherList.length,
            ),
          ),
        ],
      ),
    );
  }
}
