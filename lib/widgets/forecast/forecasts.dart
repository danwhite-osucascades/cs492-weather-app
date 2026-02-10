import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:weatherapp/providers/forecast_provider.dart';
import 'forecast_tile.dart';

class ForecastsWidget extends StatelessWidget {
  const ForecastsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final forecastProvider = context.read<ForecastProvider>();
    return ListView(
        scrollDirection: Axis.horizontal,
        children: forecastProvider.forecasts
            .map((forecast) => ForecastTileWidget(forecast: forecast))
            .toList());
  }
}
