import 'dart:convert';
import 'package:http/http.dart' as http;

class Forecast {

  int temperature;
  String windSpeed;
  String windDirection;
  String name;
  String shortForecast;
  String detailedForecast;
  bool isDaytime;

  Forecast({
    required this.temperature,
    required this.windSpeed,
    required this.windDirection,
    required this.name,
    required this.shortForecast,
    required this.detailedForecast,
    required this.isDaytime,
  });
}

Future<List<Forecast>> getForecastsByLocation(double lat, double long) async {
  String forecastUrl = "https://api.weather.gov/points/$lat,$long";
  http.Response forecastResponse = await http.get(Uri.parse(forecastUrl));
  final Map<String, dynamic> forecastJson = jsonDecode(forecastResponse.body);

  http.Response forecastDetailResponse =
      await http.get(Uri.parse(forecastJson["properties"]["forecast"]));
  final Map<String, dynamic> forecastDetailJson =
      jsonDecode(forecastDetailResponse.body);

  List<Forecast> forecasts = [];

  List<dynamic> periods =
      forecastDetailJson["properties"]["periods"];

  for (int i = 0; i < periods.length; i++) {
    Map<String, dynamic> f = periods[i];
    forecasts.add(
      Forecast(
          temperature: f["temperature"],
          windSpeed: f['windSpeed'],
          windDirection: f["windDirection"],
          name: f["name"],
          shortForecast: f["shortForecast"],
          detailedForecast: f["detailedForecast"],
          isDaytime: f["isDaytime"])
      );
  }

  return forecasts;
}
