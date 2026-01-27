
import 'package:flutter/material.dart';
import '../models/forecast.dart';
import 'forecast_tile.dart';


class ForecastsWidget extends StatelessWidget {
  const ForecastsWidget({
    super.key,
    required List<Forecast> forecasts,
    required this.setActiveForecast,
  }) : _forecasts = forecasts;

  final List<Forecast> _forecasts;
  final void Function(Forecast) setActiveForecast;

  @override
  Widget build(BuildContext context) {
    return ListView(
        scrollDirection: Axis.horizontal,
        children: _forecasts
            .map((forecast) => ForecastTileWidget(forecast: forecast, setActiveForecast: setActiveForecast,))
            .toList());
  }
}