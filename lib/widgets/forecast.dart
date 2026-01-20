import 'package:flutter/material.dart';

import '../models/forecast.dart';

class ForecastWidget extends StatelessWidget {
  const ForecastWidget({
    super.key,
    required this.forecast,
  });

  final Forecast forecast;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text(forecast.name),
          Text(forecast.shortForecast),
          Text(forecast.temperature.toString()),
          Text(forecast.isDaytime ? "Day" : "Night")
        ],
      ),
    );
  }
}
