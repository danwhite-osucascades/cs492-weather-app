import './forecast.dart' as forecast;

Future<void> main() async {
  // testing with Bend, OR coordinates
  double lat = 44.05;
  double lon = -121.31;
  //forecast.getForecastFromPoints(lat,lon);
  forecast.getForecastHourlyFromPoints(lat,lon);
}