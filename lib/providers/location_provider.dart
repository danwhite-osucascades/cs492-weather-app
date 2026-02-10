import 'package:flutter/foundation.dart';

import 'package:weatherapp/models/location.dart';

class LocationProvider extends ChangeNotifier {
  Location? location;

  Map<String, Location> savedLocations = {};

  void setLocationFromGps() async {
    location = await getLocationFromGps();

    if (location != null && !savedLocations.containsKey(location!.zip)) {
      savedLocations[location!.zip] = location!;
    }

    notifyListeners();
  }

  void setLocation(String? locationString) async {
    if (locationString != null && locationString.trim().isNotEmpty) {
      location = await getLocationFromString(locationString);
    } else {
      location = null;
    }

    if (location != null && !savedLocations.containsKey(location!.zip)) {
      savedLocations[location!.zip] = location!;
    }

    notifyListeners();
  }

}
