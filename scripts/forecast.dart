import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class Forecast {
  // Class properties are defined here. These represent the data fields of the Forecast object.

  final String? name;
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

  // Constructor to initialize a Forecast object.
  // Each parameter corresponds to a property defined above.
  // Required fields must always be provided when creating a new instance, while optional fields can be omitted or set to null.
  
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

  // A factory constructor that creates a Forecast instance from a JSON object.
  // This is useful when working with APIs or other data sources that provide weather data in JSON format.
  factory Forecast.fromJson(Map<String, dynamic> json) {
    return Forecast(
      name: json["name"].length > 0 ? json["name"] : null,
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

  // Overriding the toString() method
  @override
  String toString(){
    return name != null ? 'Forecast for ${name}\n' : ""
      'Daytime: ${isDaytime ? "Yes" : "No"}\n';
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
    print(Forecast.fromJson(forecast));
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
  num? dewpoint = forecast["dewpoint"]?["value"];

  return;
}


Future<Map<String, dynamic>> getRequestJson(String url) async{
  http.Response r = await http.get(Uri.parse(url));
  return convert.jsonDecode(r.body);
}