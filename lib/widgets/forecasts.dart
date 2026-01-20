
import 'package:flutter/material.dart';
import '../models/forecast.dart';
import './forecast.dart';


class ForecastsWidget extends StatelessWidget {
  const ForecastsWidget({
    super.key,
    required List<Forecast> forecasts,
  }) : _forecasts = forecasts;

  final List<Forecast> _forecasts;

  @override
  Widget build(BuildContext context) {
    return ListView(
        scrollDirection: Axis.horizontal,
        children: _forecasts
            .map((forecast) => ForecastWidget(forecast: forecast))
            .toList());
  }
}