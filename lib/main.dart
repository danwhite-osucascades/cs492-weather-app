import 'package:flutter/material.dart';

import './models/forecast.dart';

import './models/location.dart';  

// TODO:
// Add text field and elevated button
// Allow the user to enter a location, when they click the button, update the location and forecasts

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CS492',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'CS492'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Forecast> _forecasts = [];
  Location? _location;

  @override
  void initState() {
    super.initState();
    _initForecasts();
  }

  void _initForecasts() async {
    

    Location location = await getLocationFromString("Miami");

    List<Forecast> forecasts = await getForecastsByLocation(location.latitude, location.longitude);
    
    setState(() {
      _location = location;
      _forecasts = forecasts;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: 
          SizedBox(
            width: 500,
            child: Column(
              children: [
                Text(_location != null ? "${_location?.city}, ${_location?.state} ${_location?.zip}" : "No Location..."),
                Row(children: _forecasts.map((forecast)=> ForecastWidget(forecast: forecast)).toList()),
              ],
            ),
          ),
      
    );
  }
}

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
