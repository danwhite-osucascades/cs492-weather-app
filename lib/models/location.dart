import 'package:geocoding/geocoding.dart' as geocoding;


// TODO:
// create a Location class that will hold:
// city, state, country, zip, latitude, longitude



// change this function to return a single Location object
void getLocationFromString(String s) async {
  List<geocoding.Location> locations = await geocoding.locationFromAddress(s);

  print(locations);

  List<geocoding.Placemark> placemarks = await geocoding.placemarkFromCoordinates(locations[0].latitude, locations[0].longitude);

  print(placemarks);
}