import 'package:weather/weather.dart';

class WeatherRepo {
  static final WeatherRepo _weatherRepo = WeatherRepo._internal();

  factory WeatherRepo() {
    return _weatherRepo;
  }

  WeatherRepo._internal() {
    _weatherFactory = WeatherFactory(_apiKey, language: Language.GERMAN);
  }

  final List<Weather> _weatherList = [];
  WeatherFactory? _weatherFactory;
  Weather? _lastWeather;
  final String _apiKey = '1a5861cccad85b14095593639f7355cc';

  Future<void> getWeatherFromApi(String cityName) async {
    try {
      _lastWeather = await _weatherFactory!.currentWeatherByCityName(cityName);
      _weatherList.add(_lastWeather!);
      _weatherList.length > 30 ? _weatherList.removeAt(0) : null;
    } catch (e) {
      throw Exception('City not found!');
    }
  }

  List<Weather> getWeatherList() {
    return _weatherList;
  }

  List<Weather> getReversedWeatherList() {
    return _weatherList.reversed.toList();
  }

  Weather getLatestWeather() {
    return _weatherList.last;
  }

  int getTemperatureCelsius() {
    return _lastWeather!.temperature!.celsius!.round();
  }

  String getWeatherIconString() {
    String weatherString =
        'https://openweathermap.org/img/wn/${_lastWeather?.weatherIcon}@2x.png';
    return weatherString;
  }

  String getWeatherIconStringByIndex(int index) {
    String weatherString =
        'https://openweathermap.org/img/wn/${_weatherList[index].weatherIcon}@2x.png';
    return weatherString;
  }
}
