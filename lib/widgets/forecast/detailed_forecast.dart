import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:weatherapp/models/forecast.dart';
import 'package:weatherapp/providers/forecast_provider.dart';

class DetailedForecast extends StatefulWidget {
  const DetailedForecast({super.key});

  @override
  State<DetailedForecast> createState() => _DetailedForecastState();
}

class _DetailedForecastState extends State<DetailedForecast> {
  String? _imageUrl;
  Forecast? _lastForecast;

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

    final imageUrl = await _getImage(prompt);

    if (!mounted) return;

    setState(() {
      _imageUrl = imageUrl;
    });
  }

  Future<String?> _getImage(String prompt) async {
    final apiKey = dotenv.env['PEXELS_API_KEY'];
    print(apiKey);
    if (apiKey == null) return null;

    final uri = Uri.parse(
      'https://api.pexels.com/v1/search?query=${Uri.encodeComponent(prompt)}&per_page=1',
    );

    final response = await http.get(
      uri,
      headers: {
        'Authorization': apiKey,
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(data);

      if (data['photos'] != null && data['photos'].isNotEmpty) {
        return data['photos'][0]['src']['large'];
      }
    }

    return null;
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

    return SizedBox(
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
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    activeForecast.name,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Divider(color: Colors.white70),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Text(
                        activeForecast.detailedForecast,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              height: 1.4,
                              color: Colors.white,
                            ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (_imageUrl == null)
              const Center(
                child: CircularProgressIndicator(color: Colors.white),
              ),
          ],
        ),
      ),
    );
  }
}
