import 'package:flutter/material.dart';
import '../models/forecast.dart';

class ForecastWidget extends StatelessWidget {
  const ForecastWidget({
    super.key,
    required this.forecast,
    required this.setActiveForecast,
  });

  final Forecast forecast;
  final void Function(Forecast) setActiveForecast;

  void _setActiveForecast(){
    setActiveForecast(forecast);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final accentColor = forecast.isDaytime
        ? Colors.orange
        : Colors.indigo;

    return ElevatedButton(
      onPressed: _setActiveForecast,
      child: SizedBox(
        width: 160,
        height: 200,
        child: Card(
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              // Subtle top accent
              Container(
                height: 6,
                decoration: BoxDecoration(
                  color: accentColor.withValues(alpha: 0.35),
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                ),
              ),
      
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        forecast.name,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
      
                      Text(
                        "${forecast.temperature}°",
                        style: theme.textTheme.displaySmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
      
                      Text(
                        forecast.shortForecast,
                        style: theme.textTheme.bodySmall,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
