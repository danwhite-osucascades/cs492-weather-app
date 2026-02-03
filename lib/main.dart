import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:weatherapp/providers/forecast_provider.dart';
import 'package:weatherapp/providers/location_provider.dart';
import 'package:weatherapp/widgets/weather_app_bar.dart';
import 'package:weatherapp/widgets/weather_body.dart';

// TODO:
// Go over the context providers more
// Add icons to forecast_tile widget

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => LocationProvider()),
    ChangeNotifierProvider(create: (context) => ForecastProvider())
  ], child: const MyApp()));
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
  late final TabController _tabController;
  bool locationSet = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.index = 1;
    _tabController.addListener(() {
      if (!locationSet) {
        _tabController.animateTo(1);
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final locationProvider = context.read<LocationProvider>();
    final forecastProvider = context.read<ForecastProvider>();

    if (locationProvider.location != null) {
      locationSet = true;
      forecastProvider.getForecasts(locationProvider.location);
    } else {
      locationSet = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final locationProvider = context.watch<LocationProvider>();

    return Scaffold(
      appBar: WeatherAppBar(title: widget.title, locationProvider: locationProvider, tabController: _tabController),
      body: WeatherAppBody(tabController: _tabController),
    );
  }
}
