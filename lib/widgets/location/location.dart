import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:weatherapp/providers/location_provider.dart';
import 'package:weatherapp/widgets/location/location_buttons.dart';

class LocationWidget extends StatefulWidget {
  const LocationWidget({super.key});

  @override
  State<LocationWidget> createState() => _LocationWidgetState();
}

class _LocationWidgetState extends State<LocationWidget> {
  final TextEditingController _locationController = TextEditingController();
  bool _showError = false;

  late LocationProvider _locationActions;

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

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _locationActions = context.read<LocationProvider>();
  }

  void _setLocation() {
    if (_locationController.text.isEmpty) {
      setState(() {
        _showError = true;
      });
    } else {
      _locationActions.setLocation(_locationController.text);
    }
  }

  void _clearLocation() {
    _locationActions.setLocation(null);
    _locationController.text = "";
  }

  @override
  Widget build(BuildContext context) {
    final locationProvider = context.watch<LocationProvider>();

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          TextField(
            controller: _locationController,
            decoration: InputDecoration(
              labelText: "Enter Location",
              errorText: _showError ? "Error: Must Type Location" : null,
            ),
          ),
          LocationButtons(
            setLocation: _setLocation,
            setLocationFromGps: _locationActions.setLocationFromGps,
            clearLocation: _clearLocation,
          ),
          Text(
            locationProvider.location != null
                ? "${locationProvider.location?.city}, ${locationProvider.location!.state} ${locationProvider.location?.zip}"
                : "No Location...",
          ),
        ],
      ),
    );
  }
}


