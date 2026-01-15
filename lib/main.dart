import 'package:flutter/material.dart';

import './models/forecast.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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
  List<Widget> _forecastsWidget = [];

  @override
  void initState() {
    super.initState();
    _initForecasts();
  }

  void _initForecasts() async {
    List<Forecast> forecasts = await getForecastsByLocation(44.058, -121.315);
    setState(() {
      _forecasts = forecasts;
      // Instead of just mapping the e.name, try to create a widget that shows all properties
      _forecastsWidget = _forecasts
          .map((forecast) => ForecastWidget(forecast: forecast))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Row(children: _forecastsWidget),
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
    return Column(
      children: [
        Text(forecast.name),
        Text(forecast.shortForecast),
        Text(forecast.temperature.toString()),
        Text(forecast.isDaytime ? "Day" : "Night")
      ],
    );
  }
}
