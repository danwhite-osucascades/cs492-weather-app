import 'package:flutter/material.dart';

import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class SeedColorPicker extends StatefulWidget {
  const SeedColorPicker({super.key});

  @override
  State<SeedColorPicker> createState() => _SeedColorPickerState();
}

class _SeedColorPickerState extends State<SeedColorPicker> {
  Color currentColor = Colors.amber;
  List<Color> currentColors = [Colors.yellow, Colors.green];
  List<Color> colorHistory = [];

  void changeColor(Color color) => setState(() => currentColor = color);
  void changeColors(List<Color> colors) => setState(() => currentColors = colors);


  @override
  Widget build(BuildContext context) {
    return SizedBox(height: 500, width: 200, child: ColorPicker(colorPickerWidth: 200, pickerColor: currentColor, onColorChanged: changeColor, enableAlpha: false, labelTypes: [], displayThumbColor: false,));
  }
}