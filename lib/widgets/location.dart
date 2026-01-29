import 'package:flutter/material.dart';

import '../models/location.dart';

class LocationWidget extends StatefulWidget {
  const LocationWidget({
    super.key,
    required Location? location,
    required this.setLocation,
    required this.setLocationFromGps,
  }) : _location = location;

  final Location? _location;
  final void Function(String) setLocation;
  final void Function() setLocationFromGps;

  @override
  State<LocationWidget> createState() => _LocationWidgetState();
}

class _LocationWidgetState extends State<LocationWidget> {
  final TextEditingController _locationController = TextEditingController();

  bool _showError = false;

  @override
  void initState() {
    super.initState();

    _locationController.addListener(() {
      if (_locationController.text.isNotEmpty) {
        setState(() {
          _showError = false;
        });
      }
    });
  }

  void _setLocation() {
    if (_locationController.text.isEmpty) {
      setState(() {
        _showError = true;
      });
    } else {
      widget.setLocation(_locationController.text);
    }
  }

  void _clearLocation() {
    widget.setLocation("");
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          TextField(
              controller: _locationController,
              decoration: InputDecoration(
                  labelText: "Enter Location",
                  errorText: _showError ? "Error: Must Type Location" : null)),
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
                    onPressed: widget.setLocationFromGps,
                    child: Text("GPS")),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    onPressed: _clearLocation,
                    child: Text("Clear Location")),
              ),
            ],
          ),
          Text(widget._location != null
              ? "${widget._location?.city}, ${widget._location?.state} ${widget._location?.zip}"
              : "No Location..."),
        ],
      ),
    );
  }
}
