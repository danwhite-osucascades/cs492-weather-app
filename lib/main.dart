import 'package:flutter/material.dart';
import './models/forecast.dart';
import './models/location.dart';

// TODOS:
// Look over code changes
// Work on refactoring for proper encapsulation of widgets
// Add GPS functionality

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
  }

  void _setLocation(String locationString) async {
    Location location = await getLocationFromString(locationString);
    _getForecasts(location);
    setState(() {
      _location = location;
    });
  }

  void _getForecasts(Location location) async {
    List<Forecast> forecasts =
        await getForecastsByLocation(location.latitude, location.longitude);
    setState(() {
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
      body: SizedBox(
        height: double.infinity,
        width: 500,
        child: Column(
          children: [
            LocationWidget(location: _location, setLocation: _setLocation),
            SizedBox(
              width: double.infinity,
              height: 200,
              child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: _forecasts
                      .map((forecast) => ForecastWidget(forecast: forecast))
                      .toList()),
            ),
          ],
        ),
      ),
    );
  }
}

class LocationWidget extends StatelessWidget {
  LocationWidget({
    super.key,
    required Location? location,
    required this.setLocation,
  }) : _location = location;

  final Location? _location;
  final TextEditingController _locationController = TextEditingController();
  final void Function(String) setLocation;

  void _setLocation() {
    setLocation(_locationController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
            controller: _locationController,
            decoration: InputDecoration(labelText: "Enter Location")),
        ElevatedButton(onPressed: _setLocation, child: Text("Set Location")),
        Text(_location != null
            ? "${_location?.city}, ${_location?.state} ${_location?.zip}"
            : "No Location..."),
      ],
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
