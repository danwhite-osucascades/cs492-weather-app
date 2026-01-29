import 'package:flutter/material.dart';
import 'package:weatherapp/providers/location_provider.dart';

class LocationWidget extends StatefulWidget {
  const LocationWidget({super.key, required this.locationProvider});

  final LocationProvider locationProvider;

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
      widget.locationProvider.setLocation(_locationController.text);
    }
  }

  void _clearLocation() {
    widget.locationProvider.setLocation(null);
    _locationController.text = "";
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
                    onPressed: widget.locationProvider.setLocationFromGps,
                    child: Text("GPS")),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    onPressed: _clearLocation, child: Text("Clear Location")),
              ),
            ],
          ),
          Text(widget.locationProvider.location != null
              ? "${widget.locationProvider.location?.city}, ${widget.locationProvider.location?.state} ${widget.locationProvider.location?.zip}"
              : "No Location..."),
        ],
      ),
    );
  }
}
