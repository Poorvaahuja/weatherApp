import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weatherapp/services/weather_service.dart';
import 'package:weatherapp/models/weather_model.dart';
class WeatherPage extends StatefulWidget{
  const WeatherPage({super.key});
  @override
  State<WeatherPage> createState() => _WeatherPageState();
}
class _WeatherPageState extends State<WeatherPage>{

  //api key
  final _weatherService = WeatherService('16693d04021347b056281c6a75f8b4c8');
  Weather? _weather;
  //fetch weather
  _fetchWeather() async{
    String cityName = await _weatherService.getCurrentCity();
    try{
      final weather = await _weatherService.getWeather(cityName);
      setState((){
        _weather = weather as Weather?;
      });
    }
    catch(e){
      print(e);
    }
  }
  //weather animations
  String getWeatherAnimation(String? mainConditions){
    if(mainConditions == null){
      return 'assets/Animation - sunny.json';
    }
    switch(mainConditions){
      case 'Rain':
        return 'assets/Animation - rainy.json';
      case 'Shower Rain':
        return 'assets/Animation - rainy.json';
      case 'Clouds':
        return 'assets/Animation - cloudy.json';
      case 'Mist':
        return 'assets/Animation - cloudy.json';
      case 'Fog':
        return 'assets/Animation - cloudy.json';
      case 'Smoke':
        return 'assets/Animation - cloudy.json';
      case 'Clear':
        return 'assets/Animation - sunny.json';
      default:
        return 'assets/Animation - sunny.json';
    }
  }

  //init state
  void initState(){
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_weather?.cityName ?? "Loading City..."),
            Lottie.asset(getWeatherAnimation(_weather?.mainConditions)),
            Text('${_weather?.temperature.round()}°C'),
            Text(_weather?.mainConditions ?? ""),
          ],
        )
      ),
    );
  }
}