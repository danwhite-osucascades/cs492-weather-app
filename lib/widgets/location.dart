import 'package:flutter/material.dart';

import '../models/location.dart';

class LocationWidget extends StatelessWidget {
  LocationWidget({
    super.key,
    required Location? location,
    required this.setLocation,
    required this.setLocationFromGps,
  }) : _location = location;

  final Location? _location;
  final TextEditingController _locationController = TextEditingController();
  final void Function(String) setLocation;
  final void Function() setLocationFromGps;

  void _setLocation() {
    setLocation(_locationController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          TextField(
              controller: _locationController,
              decoration: InputDecoration(labelText: "Enter Location")),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    onPressed: _setLocation, child: Text("Set Location")),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    onPressed: setLocationFromGps,
                    child: Text("Set Location from GPS")),
              ),
            ],
          ),
          Text(_location != null
              ? "${_location.city}, ${_location.state} ${_location.zip}"
              : "No Location..."),
        ],
      ),
    );
  }
}
