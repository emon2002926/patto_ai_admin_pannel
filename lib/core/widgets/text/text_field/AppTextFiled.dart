import 'package:flutter/material.dart';
import '../../../app_colors.dart';

/// Kept the original file name (AppTextFiled.dart) so imports match your project.
class AppTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final bool obscureText;
  final TextInputType? keyboardType;
  final Widget? suffixWidget;
  final FocusNode? focusNode;
  final Color? fillColor;
  final Color? inputTextColor;
  final bool isHintTextInMiddle;
  final ValueChanged<String>? onChanged;

  const AppTextField({
    super.key,
    this.controller,
    this.hintText = '',
    this.obscureText = false,
    this.keyboardType,
    this.suffixWidget,
    this.focusNode,
    this.fillColor,
    this.inputTextColor,
    this.isHintTextInMiddle = false,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final base = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: AppColors.inputBorder),
    );
    return TextField(
      controller: controller,
      focusNode: focusNode,
      obscureText: obscureText,
      keyboardType: keyboardType,
      onChanged: onChanged,
      textAlign: isHintTextInMiddle ? TextAlign.center : TextAlign.start,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: inputTextColor ?? AppColors.textPrimary,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Color(0xFF98A2B3),
          fontWeight: FontWeight.w400,
        ),
        filled: true,
        fillColor: fillColor ?? Colors.white,
        isDense: true,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        suffixIcon: suffixWidget,
        enabledBorder: base,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.4),
        ),
        border: base,
      ),
    );
  }
}
