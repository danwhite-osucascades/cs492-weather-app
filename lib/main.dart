import 'package:flutter/material.dart';

import 'package:weatherapp/scripts/tests.dart' as tests;
import 'package:weatherapp/scripts/location.dart' as location;
import 'package:weatherapp/scripts/forecast.dart' as forecast;
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CS492 Weather App',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  // TODO: Add a new list of forecast.Forecast variable called _forecasts
  List<forecast.Forecast> _forecasts = [];
  location.Location? _currentLocation;

  @override
  void initState() {
    super.initState();

    // run tests initially
    //tests.testLocation();
    setLocation();

  }

  // TODO Create a new function called getForecasts(location.Location currentLocation)
  // This function should use a location to call getForecastFromPoints(), passing in the lat, lon
  // use setState the same way as setLocation does to set your _forecasts to the returned forecasts
  void getForecasts(location.Location currentLocation) async {
    List<forecast.Forecast> forecasts = await forecast.getForecastFromPoints(currentLocation.latitude, currentLocation.longitude);
    setState(() {
      _forecasts = forecasts.;
    });
  }

  void setLocation() async {
    if (_currentLocation == null){
      // location.Location? currentLocation = await location.getLocationFromAddress(city, state, zip);
      location.Location? currentLocation = await location.getLocationFromGps();

      // TODO: Add a call to your getForecasts function passing in the currentLocation
      getForecasts(currentLocation);
      
      setState(() {
        _currentLocation = currentLocation;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body:Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
          child: Column(
            children: [
              locationWidget(_currentLocation),
              // TODO: add a new call to forecastWidget that passes in _forecasts[0]
              forecastWidget(_forecasts.isNotEmpty ? _forecasts[0] : null);
            ],
          ),
        ),
      ),
    );
  }

  
  // TODO: add a new Row forecastWidget to display some basic forecast information
  // you can choose the parts that you want to display for now.

  Row forecastWidget(forecast.Forecast? forecasts) {
    return Row(
      children: [
        Text(
          forecasts != null ? forecasts.name ?? "temp",
          style: TextStyle(fontSize: 16, color: Colors.black),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
  }

  Row locationWidget(location.Location? currentLocation) {
    return Row(
      children: [
        Text(
          currentLocation != null ? currentLocation.city ?? "City" : "City",
          style: TextStyle(fontSize: 16, color: Colors.black),
          textAlign: TextAlign.center,
        ),
        Text(
          currentLocation != null ? currentLocation.state ?? "State" : "State",
          style: TextStyle(fontSize: 16, color: Colors.black),
          textAlign: TextAlign.center,
        ),
        Text(
          currentLocation != null ? currentLocation.zip ?? "Zip" : "Zip",
          style: TextStyle(fontSize: 16, color: Colors.black),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
