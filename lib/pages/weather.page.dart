import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/weather.dart';
import 'package:weather_app/pages/history.page.dart';
import 'package:weather_app/repositories/weather.repo.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final TextEditingController _cityController = TextEditingController();
  String _tempString = '';
  bool _iconAwailable = false;

  @override
  void initState() {
    super.initState();
    WeatherRepo().restoreData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const HistoryPage(),
                  ),
                );
              },
              child: const Text(
                'Verlauf',
                style: TextStyle(color: Colors.white),
              ))
        ],
        title: const Text(
          'Wetter',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _cityController,
                    decoration: const InputDecoration(
                      hintText: 'Stadt eingeben',
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () async {
                    await _makeWeatherCall();
                    setState(() {});
                  },
                  child: const Text('Suchen'),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Center(
              child: Text(_tempString),
            ),
            const SizedBox(height: 30.0),
            Center(
              child: _iconAwailable == false
                  ? const Text('')
                  : Image.network(WeatherRepo().getIconList()[0]),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _makeWeatherCall() async {
    try {
      if (_cityController.text.isNotEmpty) {
        await WeatherRepo().getWeatherFromApi(_cityController.text);
        _tempString =
            'Temp in ${_cityController.text}: ${WeatherRepo().getTempList()[0]}°C';
        //_weatherController.text = WeatherRepo().getWeather();
        _iconAwailable = true;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.only(bottom: 1.0),
            //padding: const EdgeInsets.only(bottom: 30.0),
            duration: Duration(seconds: 4),
            content: Text('Bitte Namen eingeben'),
          ),
        );
      }
    } catch (e) {
      _tempString = 'Stadt nicht gefunden!';
      debugPrint(e.toString());
    }
  }
}
