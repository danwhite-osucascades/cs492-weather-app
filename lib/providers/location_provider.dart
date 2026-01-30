import 'package:flutter/foundation.dart';

import 'package:weatherapp/models/location.dart';

class LocationProvider extends ChangeNotifier {
  Location? location;

  void setLocationFromGps() async {
    location = await getLocationFromGps();
    notifyListeners();
  }

  void setLocation(String? locationString) async {
    if (locationString != null && locationString.trim().isNotEmpty) {
      location = await getLocationFromString(locationString);
    }
    else {
      location = null;
    }
    notifyListeners();
  }
}
