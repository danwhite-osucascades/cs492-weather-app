import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/providers/forecast_provider.dart';

class DetailedForecast extends StatelessWidget {
  const DetailedForecast({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final activeForecast = context.watch<ForecastProvider>().activeForecast;

    if (activeForecast == null) {
      return const SizedBox(
        height: 300,
        child: Center(
          child: Text(
            'Select a forecast to see details',
            style: TextStyle(color: Colors.grey),
          ),
        ),
      );
    }

    return SizedBox(
      height: 300,
      width: double.infinity,
      child: Card(
        elevation: 3,
        margin: const EdgeInsets.all(12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                activeForecast.name,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: const Divider(),
              ),

              Expanded(
                child: SingleChildScrollView(
                  child: Text(
                    activeForecast.detailedForecast,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          height: 1.4,
                        ),
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
