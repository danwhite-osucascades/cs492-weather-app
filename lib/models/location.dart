import 'package:geocoding/geocoding.dart' as geocoding;

class Location {
  String city;
  String state;
  String zip;
  String country;
  double latitude;
  double longitude;

  Location(
      {required this.city,
      required this.state,
      required this.zip,
      required this.country,
      required this.latitude,
      required this.longitude});
}

Future<Location> getLocationFromString(String s) async {
  List<geocoding.Location> locations = await geocoding.locationFromAddress(s);

  List<geocoding.Placemark> placemarks = await geocoding
      .placemarkFromCoordinates(locations[0].latitude, locations[0].longitude);

  return Location(
      city: placemarks[0].locality ?? "",
      state: placemarks[0].administrativeArea ?? "",
      zip: placemarks[0].postalCode ?? "",
      country: placemarks[0].country ?? "",
      latitude: locations[0].latitude,
      longitude: locations[0].longitude);
}
