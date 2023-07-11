library color_kit;

import 'dart:math';

import 'package:flutter/material.dart';

Color getRandomColor() =>
    Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);

Color getInverseColor(Color color) {
  final r = 255 - color.red;
  final g = 255 - color.green;
  final b = 255 - color.blue;

  return Color.fromARGB((color.opacity * 255).round(), r, g, b);
}

Color blackOrWhiteForeground(Color backgroundColor) {
  return backgroundColor.computeLuminance() > 0.5 ? Colors.black : Colors.white;
}

Color getRandomMaterialColor() {
  final randomIndex = 0 + Random().nextInt(Colors.primaries.length - 0);
  return Colors.primaries[randomIndex];
}

Color getDarkerShade(Color color, [double percent = 0.5]) {
  // Make sure percent is within the valid range of 0.0 to 1.0.
  percent = percent.clamp(0.0, 1.0);
  // Convert the color to the HSL color space.
  final hslColor = HSLColor.fromColor(color);
  // Get the lightness value and decrease it by the specified percentage.
  final newLightness = (hslColor.lightness - percent).clamp(0.0, 1.0);
  // Create a new HSL color with the same hue and saturation, but the new lightness value.
  final newColor = hslColor.withLightness(newLightness).toColor();
  return newColor;
}

Color getLighterShade(Color color, [double percent = 0.5]) {
  percent = percent.clamp(0.0, 1.0);

  final hslColor = HSLColor.fromColor(color);
  final newLightness = (hslColor.lightness + percent).clamp(0.0, 1.0);
  final newColor = hslColor.withLightness(newLightness).toColor();

  return newColor;
}

List<Color> generateAnalogousPalette(Color baseColor, {int count = 5}) {
  final List<Color> palette = [];

  final HSVColor baseHSV = HSVColor.fromColor(baseColor);
  final double interval = 360.0 / count;

  for (int i = 0; i < count; i++) {
    final double hue = (baseHSV.hue + (interval * i)) % 360.0;
    final Color analogousColor =
        HSVColor.fromAHSV(1.0, hue, baseHSV.saturation, baseHSV.value)
            .toColor();
    palette.add(analogousColor);
  }

  return palette;
}
