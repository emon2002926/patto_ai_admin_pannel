import 'package:flutter/material.dart';

/// Central Patto palette. Your old project used inline Color(0xFF..) everywhere;
/// because this is a brand-new palette used across ~12 screens, it's collected
/// here so you can retune the theme in one place. Values are eyeballed from the
/// Figma export — nudge them if the brand hex codes differ.
class AppColors {
  // Brand
  static const Color primary = Color(0xFF7A2E42); // filled buttons / accents (wine)
  static const Color sidebar = Color(0xFF43101B); // deep wine sidebar
  static const Color sidebarSelected = Color(0xFF6C2838);
  static const Color sidebarLabel = Color(0xFFB58C97);
  static const Color sidebarSection = Color(0xFF9A6E79);
  static const Color sidebarSelectedText = Color(0xFFFBE9EE);
  static const Color wordmark = Color(0xFF2A1015);

  // Surfaces
  static const Color shellBg = Color(0xFFF4EFE6); // cream app background
  static const Color card = Color(0xFFFFFFFF);

  // Text
  static const Color textPrimary = Color(0xFF1E1418);
  static const Color textSecondary = Color(0xFF6B5A60);
  static const Color textMuted = Color(0xFF9C7681); // dusty mauve labels

  // Borders / tracks
  static const Color border = Color(0xFFE7DFD4);
  static const Color inputBorder = Color(0xFFC9BEB2);
  static const Color track = Color(0xFFEDE7DD);

  // Status
  static const Color green = Color(0xFF1E9268);
  static const Color greenText = Color(0xFF15803D);
  static const Color greenBg = Color(0xFFE3F4EC);
  static const Color amber = Color(0xFFE0A72E);
  static const Color amberText = Color(0xFFB45309);
  static const Color amberBg = Color(0xFFFBF0D6);
  static const Color red = Color(0xFFB91C1C);
  static const Color redBg = Color(0xFFFCE8E8);
  static const Color pink = Color(0xFFEF7387);

  // Plan / badge fills
  static const Color planPinkBg = Color(0xFFFBE7EC);
  static const Color planPinkText = Color(0xFF9B3B4E);
  static const Color neutralBg = Color(0xFFEFEDEA);
  static const Color neutralText = Color(0xFF6B5A60);

  // Bars
  static const Color barMaroon = Color(0xFF6E2A3B);
}
