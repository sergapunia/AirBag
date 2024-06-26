import 'package:flutter/material.dart';

TextStyle myTextStyle() {
  return const TextStyle(color: Colors.white);
}

TextStyle procentText(Color color, double size) {
  return TextStyle(fontSize: size, color: color, fontWeight: FontWeight.bold);
}

Text changeText(double value, String suffix, int rounded, double size) {
  return Text(
      (value > 0
              ? "+ ${value.toStringAsFixed(rounded)}"
              : value.toStringAsFixed(rounded)) +
          " $suffix",
      style: procentText(value > 0 ? Colors.green : Colors.red, size));
}
