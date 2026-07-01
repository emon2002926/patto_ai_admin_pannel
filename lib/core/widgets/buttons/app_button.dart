import 'package:flutter/material.dart';
import '../../app_colors.dart';
import '../text/app_text.dart';

class AppButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;
  final double buttonHeight;
  final Color? color;

  const AppButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
    this.buttonHeight = 54,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        height: buttonHeight,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color ?? AppColors.primary,
          borderRadius: BorderRadius.circular(10),
        ),
        child: AppText(
          data: buttonText,
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );
  }
}
