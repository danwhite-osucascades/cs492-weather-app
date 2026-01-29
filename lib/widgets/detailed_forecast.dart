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
    if (_activeForecast == null) {
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
                _activeForecast!.name,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 8),
              const Divider(),
              const SizedBox(height: 8),
              Expanded(
                child: SingleChildScrollView(
                  child: Text(
                    _activeForecast!.detailedForecast,
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
