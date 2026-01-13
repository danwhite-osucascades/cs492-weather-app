import 'dart:convert';

import 'package:http/http.dart' as http;

class Forecast {
  // TODO: Update with more relevant stuff
  
  int temperature;

  Forecast({
    required this.temperature
  });
}


// TODO create this function
void getForecastsByLocation(double lat, double long) async {
  String forecastUrl = "https://api.weather.gov/points/$lat,$long";
  http.Response forecastResponse = await http.get(Uri.parse(forecastUrl));
  final Map<String, dynamic> forecastJson = jsonDecode(forecastResponse.body);
  // return should actually be the forecasts
  print(forecastResponse);
}