import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// Assignment 1-2 TODOs:
// Remove the default comments
// Change the title of the application and the title of the home page to CS492
// Change the seed color to something appealing
// Instead of floating action button, use an elevated button
// Extract your button widget so you can use it multiple times
// Wrap the button in a Row, so you can add more buttons
// Add more buttons for decrementing the counter and doubling the counter.
// Create functions to handle those changes

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      _counter--;
    });
  }

  void _doubleCounter() {
    setState(() {
      _counter *= 2;
    });
  }

  void _resetCounter() {
    setState(() {
      _counter = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CounterButton(counterFunction: _incrementCounter, text: "+"),
                CounterButton(counterFunction: _decrementCounter, text: "-"),
                CounterButton(counterFunction: _doubleCounter, text: "x2"),
                CounterButton(counterFunction: _resetCounter, text: "Reset"),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class CounterButton extends StatelessWidget {
  const CounterButton({
    super.key,
    required this.counterFunction,
    required this.text
  });

  final VoidCallback counterFunction;
  final String text;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: counterFunction, child: Text(text));
  }
}
