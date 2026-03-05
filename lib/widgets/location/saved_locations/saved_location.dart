import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/models/locations/location.dart';
import 'package:weatherapp/providers/location_provider.dart';
import 'package:weatherapp/providers/theme_provider.dart';
import 'package:weatherapp/widgets/location/saved_locations/delete_location_button.dart';

class SavedLocation extends StatelessWidget {
  const SavedLocation({
    super.key,
    required this.location,
  });

  final Location location;

  @override
  Widget build(BuildContext context) {
    final locationProvider = context.watch<LocationProvider>();
    final themeProvider = context.read<ThemeProvider>();

    void setLocation() {
      locationProvider.setLocation(location);
    }

    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: setLocation,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      location.city,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "${location.state} ${location.zip}",
                      style: TextStyle(
                        fontSize: 14,
                        color: themeProvider.grey,
                      ),
                    ),
                  ],
                ),
              ),
              DeleteLocationButton(location: location),
            ],
          ),
        ),
      ),
    );
  }
}
