import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/providers/location_provider.dart';
import 'package:weatherapp/widgets/location/saved_location.dart';

class SavedLocations extends StatelessWidget {
  const SavedLocations({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final locationProvider = context.watch<LocationProvider>();
    return ListView(
        scrollDirection: Axis.vertical,
        children: locationProvider.savedLocations.values
            .map((location) => SavedLocation(location: location))
            .toList());
  }
}
