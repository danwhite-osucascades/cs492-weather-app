import 'package:flutter/material.dart';

class LocationButton extends StatelessWidget {
  const LocationButton({
    super.key,
    required this.description,
    required this.callbackFunction,
  });

  final String description;
  final void Function() callbackFunction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child:
          ElevatedButton(onPressed: callbackFunction, child: Text(description)),
    );
  }
}