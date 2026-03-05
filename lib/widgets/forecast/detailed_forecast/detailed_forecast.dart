import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/models/forecast.dart';
import 'package:weatherapp/models/pexels_image.dart';
import 'package:weatherapp/providers/forecast_provider.dart';
import 'package:weatherapp/widgets/forecast/detailed_forecast/detailed_forecast_text.dart';

class DetailedForecast extends StatefulWidget {
  const DetailedForecast({super.key});

  @override
  State<DetailedForecast> createState() => _DetailedForecastState();
}

class _DetailedForecastState extends State<DetailedForecast> {
  String? _imageUrl;
  Forecast? _lastForecast;
  PexelsImage pexelsImage = PexelsImage();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final activeForecast = context.watch<ForecastProvider>().activeForecast;

    if (activeForecast != null && activeForecast != _lastForecast) {
      _lastForecast = activeForecast;
      _fetchAndUpdateImage(activeForecast);
    }
  }

  Future<void> _fetchAndUpdateImage(Forecast forecast) async {
    String day = forecast.isDaytime ? "Day" : "Night";

    String prompt = "$day ${forecast.shortForecast}".trim();

    final imageUrl = await pexelsImage.getImage(prompt);

    if (!mounted) return;

    setState(() {
      _imageUrl = imageUrl;
    });
  }

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

    return ExcludeSemantics(
      child: SizedBox(
        height: 300,
        width: double.infinity,
        child: Card(
          elevation: 3,
          margin: const EdgeInsets.all(12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            children: [
              // Background image
              if (_imageUrl != null)
                Positioned.fill(
                  child: Image.network(
                    _imageUrl!,
                    fit: BoxFit.cover,
                  ),
                ),
      
              Positioned.fill(
                child: Container(
                  color: Colors.black.withValues(alpha: 0.5),
                ),
              ),
              DetailedForecastText(activeForecast: activeForecast),
              if (_imageUrl == null)
                const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
