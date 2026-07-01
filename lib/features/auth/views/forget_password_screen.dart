import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/widgets/buttons/app_button.dart';
import '../../../core/widgets/text/text_field/AppTextFiled.dart';
import '../controllers/forget_password_controller.dart';
import '../shared_widgets/auth_shared_widgets.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.put(ForgetPasswordController());
    return AuthScaffold(
      title: 'Forget Password?',
      subtitle: 'Please enter your email to get verification code',
      children: [
        const AuthFieldLabel('Email address'),
        const SizedBox(height: 10),
        AppTextField(controller: c.emailCtrl, hintText: 'Enter your email', keyboardType: TextInputType.emailAddress),
        const SizedBox(height: 32),
        AppButton(buttonText: 'Continue', onPressed: c.onContinue, buttonHeight: 56),
      ],
    );
  }
}
