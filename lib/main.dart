import 'package:flutter/material.dart';
import './models/forecast.dart';
import './models/location.dart';
import './widgets/location.dart';
import './widgets/forecasts.dart';
import './widgets/detailed_forecast.dart';

// TODOS:
// Use a TabBar to separate the location and weather into separate tabs
// Use icons to represent each
// Prevent tapping the weather tab unless a valid location is selected.

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
  Forecast? _activeForecast;
  Location? _location;

  @override
  void initState() {
    _setLocationFromGps();
    super.initState();
  }

  void _setActiveForecast(Forecast forecast) {
    setState(() {
      _activeForecast = forecast;
    });
  }

  void _setLocationFromGps() async {
    Location location = await getLocationFromGps();
    _getForecasts(location);
    setState(() {
      _location = location;
    });
  }

  void _setLocation(String locationString) async {
    Location? location = await getLocationFromString(locationString);
    _getForecasts(location);
    setState(() {
      _location = location;
    });
  }

  void _getForecasts(Location? location) async {
    if (location != null) {
      List<Forecast> forecasts =
          await getForecastsByLocation(location.latitude, location.longitude);
      setState(() {
        _forecasts = forecasts;
        _activeForecast = _forecasts[0];
      });
    }
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
            LocationWidget(
              location: _location,
              setLocation: _setLocation,
              setLocationFromGps: _setLocationFromGps,
            ),
            SizedBox(
              width: double.infinity,
              height: 200,
              child: ForecastsWidget(forecasts: _forecasts, setActiveForecast: _setActiveForecast,),
            ),
            DetailedForecast(activeForecast: _activeForecast)
          ],
        ),
      ),
    );
  }
}
