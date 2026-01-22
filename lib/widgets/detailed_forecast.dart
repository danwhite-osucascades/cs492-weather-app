import 'package:flutter/material.dart';
import '../models/forecast.dart';

class DetailedForecast extends StatelessWidget {
  const DetailedForecast({
    super.key,
    required Forecast? activeForecast,
  }) : _activeForecast = activeForecast;

  final Forecast? _activeForecast;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      width: double.infinity,
      child: Text(_activeForecast != null ? _activeForecast!.name : "")
    );
  }
}