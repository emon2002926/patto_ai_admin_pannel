import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../core/app_colors.dart';
import '../../../core/widgets/buttons/app_button.dart';
import '../../../core/widgets/text/app_text.dart';
import '../controllers/check_email_controller.dart';
import '../shared_widgets/auth_shared_widgets.dart';

class CheckEmailScreen extends StatelessWidget {
  const CheckEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.put(CheckEmailController());
    return AuthScaffold(
      title: 'Check your email',
      subtitle: 'We sent a code to your email address @. Please check your email for the 5 digit code.',
      centerSubtitle: true,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(5, (i) => _OtpBox(controller: c, index: i)),
        ),
        const SizedBox(height: 40),
        AppButton(buttonText: 'Verify', onPressed: c.onVerify, buttonHeight: 56),
        const SizedBox(height: 40),
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const AppText(data: 'You have not received the email?', fontSize: 15),
              const SizedBox(width: 6),
              GestureDetector(
                onTap: c.onResend,
                child: const AppText(data: 'Resend', fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.primary),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _OtpBox extends StatelessWidget {
  final CheckEmailController controller;
  final int index;
  const _OtpBox({required this.controller, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 64,
      height: 64,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.inputBorder),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: controller.digits[index],
        focusNode: controller.nodes[index],
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w600, color: AppColors.textPrimary),
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        decoration: const InputDecoration(counterText: '', border: InputBorder.none),
        onChanged: (v) => controller.onDigitChanged(index, v),
      ),
    );
  }
}
