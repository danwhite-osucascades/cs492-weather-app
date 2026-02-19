import 'package:flutter/material.dart';

import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/providers/theme_provider.dart';

class SeedColorPicker extends StatefulWidget {
  const SeedColorPicker({super.key});

  @override
  State<SeedColorPicker> createState() => _SeedColorPickerState();
}

// TODO: use your theme provider seed color and set it as well!

class _SeedColorPickerState extends State<SeedColorPicker> {
  Color currentColor = Colors.amber;
  List<Color> colorHistory = [];

  void changeColor(Color color) => setState(() => currentColor = color);

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();

    return SizedBox(
        height: 500,
        width: 200,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlockPicker(
            pickerColor: themeProvider.seedColor,
            onColorChanged: themeProvider.setSeedColor,
            availableColors: [
              Colors.red,
              Colors.orange,
              Colors.yellow,
              Colors.green,
              Colors.blue,
              Colors.indigo,
              Colors.deepPurple,
              Colors.brown
            ],
          ),
        ));
  }
}
