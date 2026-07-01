import 'package:flutter/material.dart';

/// The "patto" logotype. Uses a serif fallback — swap fontFamily for the real
/// brand font once you add it to pubspec assets.
class PattoWordmark extends StatelessWidget {
  final double fontSize;
  final Color color;
  final bool italic;
  const PattoWordmark({
    super.key,
    this.fontSize = 64,
    this.color = const Color(0xFF2A1015),
    this.italic = false,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      'patto',
      style: TextStyle(
        fontFamily: 'Georgia',
        fontSize: fontSize,
        color: color,
        fontWeight: FontWeight.w600,
        fontStyle: italic ? FontStyle.italic : FontStyle.normal,
        letterSpacing: -0.5,
      ),
    );
  }
}
