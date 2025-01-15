import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class Forecast {
  final String name;
  final bool isDaytime;
  final int temperature;
  final String temperatureUnit;
  final String windSpeed;
  final String windDirection;
  final String shortForecast;
  final String detailedForecast;
  final int? precipitationProbability;
  final int? humidity;
  final num? dewpoint;

  // Constructor
  Forecast({
    required this.name,
    required this.isDaytime,
    required this.temperature,
    required this.temperatureUnit,
    required this.windSpeed,
    required this.windDirection,
    required this.shortForecast,
    required this.detailedForecast,
    this.precipitationProbability,
    this.humidity,
    this.dewpoint
  });

  // Factory constructor to create a Forecast from JSON
  factory Forecast.fromJson(Map<String, dynamic> json) {
    return Forecast(
      name: json["name"],
      isDaytime: json["isDaytime"],
      temperature: json["temperature"],
      temperatureUnit: json["temperatureUnit"],
      windSpeed: json["windSpeed"],
      windDirection: json["windDirection"],
      shortForecast: json["shortForecast"],
      detailedForecast: json["detailedForecast"],
      precipitationProbability: json["probabilityOfPrecipitation"]?["value"],
      humidity: json["relativeHumidity"]?["value"],
      dewpoint: json["dewpoint"]?["value"],
    );
  }

  // Method to serialize Forecast back to JSON
  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "isDaytime": isDaytime,
      "temperature": temperature,
      "temperatureUnit": temperatureUnit,
      "windSpeed": windSpeed,
      "windDirection": windDirection,
      "shortForecast": shortForecast,
      "detailedForecast": detailedForecast,
      "probabilityOfPrecipitation": {
        "value": precipitationProbability,
      },
      "relativeHumidity": {
        "value": humidity,
      },
      "dewpoint": {
        "value" : dewpoint,
      }
    };
  }
}


void getForecastFromPoints(double lat, double lon) async{
  // make a request to the weather api using the latitude and longitude and decode the json data
  String pointsUrl = "https://api.weather.gov/points/${lat},${lon}";
  Map<String, dynamic> pointsJson = await getRequestJson(pointsUrl);

  // pull the forecast URL from the response json
  String forecastUrl = pointsJson["properties"]["forecast"];

  // make a request to the forecastJson url and decode the json data
  Map<String, dynamic> forecastJson = await getRequestJson(forecastUrl);
  processForecasts(forecastJson["properties"]["periods"]);

  return null;
}

void getForecastHourlyFromPoints(double lat, double lon) async{
  // make a request to the weather api using the latitude and longitude and decode the json data
  String pointsUrl = "https://api.weather.gov/points/${lat},${lon}";
  Map<String, dynamic> pointsJson = await getRequestJson(pointsUrl);

  // pull the forecastHourly URL from the response json
  String forecastHourlyUrl = pointsJson["properties"]["forecastHourly"];

  // make a request to the forecastHourlyJson url and decode the json data
  Map<String, dynamic> forecastHourlyJson = await getRequestJson(forecastHourlyUrl);
  processForecasts(forecastHourlyJson["properties"]["periods"]);

  return null;
}

List<Forecast> processForecasts(List<dynamic> forecastJsons){
  List<Forecast> forecasts = [];
  for (dynamic forecast in forecastJsons){
    forecasts.add(Forecast.fromJson(forecast));
  }
  return forecasts;
}

void processForecast(Map<String, dynamic> forecast){
  String forecastName = forecast["name"];
  bool isDaytime = forecast["isDaytime"];
  int temperature = forecast["temperature"];
  String tempUnit = forecast["temperatureUnit"];
  String windSpeed = forecast["windSpeed"];
  String windDirection = forecast["windDirection"];
  String shortForecast = forecast["shortForecast"];
  String detailedForecast = forecast["detailedForecast"];
  int? preciptationProb = forecast["probabilityOfPrecipitation"]["value"] ?? null;
  int? humidity = forecast["relativeHumidity"]?["value"];

  return;
}


Future<Map<String, dynamic>> getRequestJson(String url) async{
  http.Response r = await http.get(Uri.parse(url));
  return convert.jsonDecode(r.body);
}