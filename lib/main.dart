import 'package:flutter/material.dart';
import 'package:weatherapp/widgets/forecast.dart';
import './models/forecast.dart';
import './models/location.dart';
import './widgets/location.dart';

// TODOS:
// Add a clear location button to the location widget
// If implemented correctly, the location should clear, and you shouldn't be able to click the weather tab

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

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  List<Forecast> _forecasts = [];
  Forecast? _activeForecast;
  Location? _location;
  late final TabController _tabController;

  @override
  void initState() {
    // _setLocationFromGps();
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.index = 1;
    _tabController.addListener(() {
      if (_location == null) {
        _tabController.index = 1;
      }
    });
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

  void _setLocation(String? locationString) async {
    Location? location;

    if (locationString != null && locationString.trim().isNotEmpty) {
      location = await getLocationFromString(locationString);
      _getForecasts(location);
    }

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
          actions: [
            if (_location != null)
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Text(
                  "${_location!.city}, ${_location!.state}",
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
            LocationWidget(
              location: _location,
              setLocation: _setLocation,
              setLocationFromGps: _setLocationFromGps,
            ),
          ],
        ),
      ),
    );
  }
}
