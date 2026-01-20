import 'package:flutter/material.dart';

import '../models/location.dart';

class LocationWidget extends StatelessWidget {
  LocationWidget({
    super.key,
    required Location? location,
    required this.setLocation,
  }) : _location = location;

  final Location? _location;
  final TextEditingController _locationController = TextEditingController();
  final void Function(String) setLocation;

  void _setLocation() {
    setLocation(_locationController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
            controller: _locationController,
            decoration: InputDecoration(labelText: "Enter Location")),
        ElevatedButton(onPressed: _setLocation, child: Text("Set Location")),
        Text(_location != null
            ? "${_location?.city}, ${_location?.state} ${_location?.zip}"
            : "No Location..."),
      ],
    );
  }
}