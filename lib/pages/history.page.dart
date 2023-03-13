import 'package:flutter/material.dart';
import 'package:weather_app/repositories/weather.repo.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    var nameList = WeatherRepo().getNameList();
    var iconList = WeatherRepo().getIconList();
    var dateList = WeatherRepo().getDateList();
    var tempList = WeatherRepo().getTempList();
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
                    Text(nameList[index]),
                    const SizedBox(
                      width: 10,
                    ),
                    Text('Temp: ${tempList[index]}°C'),
                    Image.network(
                      iconList[index],
                      scale: 1.5,
                    ),
                    Expanded(
                      child: Text(
                        dateList[index],
                        textAlign: TextAlign.right,
                      ),
                    ),
                    const SizedBox(width: 10)
                  ],
                );
              },
              childCount: nameList.length,
            ),
          ),
        ],
      ),
    );
  }
}
