import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/weather.dart';

class WeatherRepo {
  static final WeatherRepo _weatherRepo = WeatherRepo._internal();

  factory WeatherRepo() {
    return _weatherRepo;
  }

  WeatherRepo._internal() {
    _weatherFactory = WeatherFactory(_apiKey, language: Language.GERMAN);
  }

  List<String> _nameStringList = [];
  List<String> _iconStringList = [];
  List<String> _dateStringList = [];
  List<String> _tempStringList = [];
  WeatherFactory? _weatherFactory;
  Weather? _lastWeather;
  final String _apiKey = '1a5861cccad85b14095593639f7355cc';

  Future<void> getWeatherFromApi(String cityName) async {
    try {
      _lastWeather = await _weatherFactory!.currentWeatherByCityName(cityName);
      convertWeatherToStrings();
      _nameStringList.length > 30 ? removeLastEntry : null;
      saveData();
    } catch (e) {
      throw Exception('City not found!');
    }
  }

  void setWeatherLists(
      {required List<String> nameStringList,
      required List<String> iconStringList,
      required List<String> dateStringList,
      required List<String> tempStringList}) {
    _nameStringList = nameStringList;
    _iconStringList = iconStringList;
    _dateStringList = dateStringList;
    _tempStringList = tempStringList;
  }

  List<String> getNameList() {
    return _nameStringList;
  }

  List<String> getIconList() {
    return _iconStringList;
  }

  List<String> getDateList() {
    return _dateStringList;
  }

  List<String> getTempList() {
    return _tempStringList;
  }

  void convertWeatherToStrings() {
    _nameStringList.insert(0, _lastWeather!.areaName!);
    _tempStringList.insert(
        0, _lastWeather!.temperature!.celsius!.round().toString());
    _iconStringList.insert(0,
        'https://openweathermap.org/img/wn/${_lastWeather!.weatherIcon}@2x.png');
    _dateStringList.insert(0,
        '${_lastWeather!.date!.day}.${_lastWeather!.date!.month}.${_lastWeather!.date!.year}  ${_lastWeather!.date!.hour}:${_lastWeather!.date!.second}');
  }

  void removeLastEntry() {
    _nameStringList.removeLast();
    _iconStringList.removeLast();
    _dateStringList.removeLast();
    _tempStringList.removeLast();
  }

  Future<void> saveData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('nameList', _nameStringList);
    prefs.setStringList('tempList', _tempStringList);
    prefs.setStringList('iconList', _iconStringList);
    prefs.setStringList('dateList', _dateStringList);
  }

  Future<void> restoreData() async {
    final prefs = await SharedPreferences.getInstance();
    _nameStringList = prefs.getStringList('nameList') ?? [];
    _tempStringList = prefs.getStringList('tempList') ?? [];
    _iconStringList = prefs.getStringList('iconList') ?? [];
    _dateStringList = prefs.getStringList('dateList') ?? [];
  }
}
