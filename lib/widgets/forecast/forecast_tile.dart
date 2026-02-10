import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:weatherapp/providers/forecast_provider.dart';

import '../../models/forecast.dart';

class ForecastTileWidget extends StatelessWidget {
  const ForecastTileWidget({super.key, required this.forecast});

  final Forecast forecast;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final accentColor = forecast.isDaytime ? Colors.orange : Colors.indigo;

    return InkWell(
      onTap: () {
        context.read<ForecastProvider>().setActiveForecast(forecast);
      },
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
                      SvgPicture.asset(forecast.imagePath, semanticsLabel: forecast.shortForecast),
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
