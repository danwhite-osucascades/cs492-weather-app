import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/providers/location_provider.dart';
import 'package:weatherapp/widgets/forecast.dart';
import './models/forecast.dart';
import './models/location.dart';
import './widgets/location.dart';

// TODOs
// Implement global state management for Location and Forecast using ChangeProvider

// TODO:
// Update the location widget, so that you no longer need to pass the location or set functions

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => LocationProvider(), child: const MyApp()));
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

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  List<Forecast> _forecasts = [];
  Forecast? _activeForecast;
  // Location? _location;
  late final TabController _tabController;
  final LocationProvider _locationProvider = LocationProvider();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.index = 1;
    _tabController.addListener(() {
      if (_locationProvider.location == null) {
        _tabController.index = 1;
      }
    });
    _locationProvider.addListener(() {
      _getForecasts(_locationProvider.location);
    });
  }

  void _setActiveForecast(Forecast forecast) {
    setState(() {
      _activeForecast = forecast;
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
          actions: [
            if (_locationProvider.location != null)
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Text(
                  "${_locationProvider.location!.city}, ${_locationProvider.location!.state}",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.5,
                      ),
                ),
              ),
          ],
          bottom: TabBar(controller: _tabController, tabs: [
            Tab(icon: Icon(Icons.sunny_snowing)),
            Tab(
              icon: Icon(Icons.location_pin),
            )
          ])),
      body: SizedBox(
        height: double.infinity,
        width: 500,
        child: TabBarView(
          controller: _tabController,
          children: [
            ForecastWidget(
                forecasts: _forecasts,
                activeForecast: _activeForecast,
                setActiveForecast: _setActiveForecast),
            LocationWidget(locationProvider: _locationProvider),
          ],
        ),
      ),
    );
  }
}
