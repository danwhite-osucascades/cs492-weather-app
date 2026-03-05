import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/models/locations/location.dart';
import 'package:weatherapp/providers/location_provider.dart';
import 'package:weatherapp/providers/theme_provider.dart';

class DeleteLocationButton extends StatelessWidget {
  const DeleteLocationButton({
    super.key,
    required this.location,
  });

  final Location location;

  @override
  Widget build(BuildContext context) {
    final locationProvider = context.watch<LocationProvider>();
    final themeProvider = context.watch<ThemeProvider>();
    void deleteLocation() {
      locationProvider.deleteLocation(location);
    }

    return Semantics(
      label: "Delete Location Button for ${location.city}, ${location.state}.",
      child: IconButton(
        icon: Icon(
          Icons.delete,
          color: themeProvider.dangerColor,
        ),
        onPressed: deleteLocation,
      ),
    );
  }
}
