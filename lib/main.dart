import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:weatherapp/providers/forecast_provider.dart';
import 'package:weatherapp/providers/location_provider.dart';
import 'package:weatherapp/providers/theme_provider.dart';
import 'package:weatherapp/widgets/weather_ui/weather_app_bar.dart';
import 'package:weatherapp/widgets/weather_ui/weather_body.dart';

// TODO:
// use shared preferences to store the location when it's set
// load the location if it exists as the default location when the app starts

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => LocationProvider()),
    ChangeNotifierProvider(create: (context) => ForecastProvider()),
    ChangeNotifierProvider(create: (context) => ThemeProvider())
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    return MaterialApp(
      title: 'CS492',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber, brightness: Brightness.light),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber, brightness: Brightness.dark),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'CS492'),
      themeMode: themeProvider.darkMode ? ThemeMode.dark : ThemeMode.light,
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
    final locationProvider = context.read<LocationProvider>();
    locationProvider.loadSavedLocations();
    final themeProvider = context.read<ThemeProvider>();
    themeProvider.loadDarkModePrefs();
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

    final locationProvider = context.watch<LocationProvider>();
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
    return Scaffold(
      appBar: WeatherAppBar(title: widget.title, tabController: _tabController),
      body: WeatherAppBody(tabController: _tabController),
    );
  }
}
