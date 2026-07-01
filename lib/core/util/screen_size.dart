import 'package:flutter/widgets.dart';

/// Stand-in for your project's screen_size helper. Gentle scaling so desktop
/// widths don't blow spacing up. Replace with your real extension if you have one.
extension ScreenSize on BuildContext {
  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;

  double h(double value) => value * (screenHeight / 812.0).clamp(0.85, 1.15);
  double w(double value) => value * (screenWidth / 390.0).clamp(0.85, 1.15);
}
