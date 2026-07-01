import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  final String data;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final double? height;
  final double? letterSpacing;
  final FontStyle fontStyle;
  final String? fontFamily;

  const AppText({
    super.key,
    required this.data,
    this.fontSize = 14,
    this.fontWeight = FontWeight.w400,
    this.color = const Color(0xFF1E1418),
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.height,
    this.letterSpacing,
    this.fontStyle = FontStyle.normal,
    this.fontFamily,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        height: height,
        letterSpacing: letterSpacing,
        fontStyle: fontStyle,
        fontFamily: fontFamily,
      ),
    );
  }
}
