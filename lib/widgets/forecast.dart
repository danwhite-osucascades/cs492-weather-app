import 'package:flutter/material.dart';
import 'package:weatherapp/models/forecast.dart';
import 'package:weatherapp/widgets/detailed_forecast.dart';
import 'package:weatherapp/widgets/forecasts.dart';


class ForecastWidget extends StatelessWidget {
  const ForecastWidget({
    super.key,
    required List<Forecast> forecasts,
    required Forecast? activeForecast,
    required this.setActiveForecast,
  })  : _forecasts = forecasts,
        _activeForecast = activeForecast;

  final List<Forecast> _forecasts;
  final Forecast? _activeForecast;
  final void Function(Forecast) setActiveForecast;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 200,
          child: ForecastsWidget(
            forecasts: _forecasts,
            setActiveForecast: setActiveForecast,
          ),
        ),
        DetailedForecast(activeForecast: _activeForecast)
      ],
    );
  }
}