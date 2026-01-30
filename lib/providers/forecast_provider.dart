import 'package:flutter/foundation.dart';

import 'package:weatherapp/models/forecast.dart';
import 'package:weatherapp/models/location.dart';

class ForecastProvider extends ChangeNotifier {
  List<Forecast> forecasts = [];
  Forecast? activeForecast;
  void setActiveForecast(Forecast forecast) {
    activeForecast = forecast;
    notifyListeners();
  }

  void getForecasts(Location? location) async {
    if (location != null) {
      forecasts =
          await getForecastsByLocation(location.latitude, location.longitude);
      activeForecast = forecasts[0];
    }
    notifyListeners();
  }
}
