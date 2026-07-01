import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/app_colors.dart';
import '../../../core/widgets/buttons/app_button.dart';
import '../../../core/widgets/text/app_text.dart';
import '../../../core/widgets/text/text_field/AppTextFiled.dart';
import '../controllers/login_controller.dart';
import '../shared_widgets/auth_shared_widgets.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.put(LoginController());
    return AuthScaffold(
      title: 'Login to Account',
      subtitle: 'Please enter your email and password to continue',
      children: [
        const AuthFieldLabel('Email address'),
        const SizedBox(height: 10),
        AppTextField(controller: c.emailCtrl, hintText: 'Enter your email', keyboardType: TextInputType.emailAddress),
        const SizedBox(height: 22),
        const AuthFieldLabel('Password'),
        const SizedBox(height: 10),
        Obx(() => AppTextField(
              controller: c.passCtrl,
              hintText: '*********',
              obscureText: c.obscurePass.value,
              suffixWidget: IconButton(
                onPressed: c.toggleObscure,
                icon: Icon(
                  c.obscurePass.value ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                  color: AppColors.textPrimary,
                ),
              ),
            )),
        const SizedBox(height: 16),
        Row(
          children: [
            Obx(() => GestureDetector(
                  onTap: c.toggleRemember,
                  child: Container(
                    width: 22,
                    height: 22,
                    decoration: BoxDecoration(
                      color: c.rememberMe.value ? AppColors.primary : Colors.white,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: c.rememberMe.value ? AppColors.primary : AppColors.inputBorder),
                    ),
                    child: c.rememberMe.value ? const Icon(Icons.check, size: 16, color: Colors.white) : null,
                  ),
                )),
            const SizedBox(width: 10),
            const AppText(data: 'Remember Password', fontSize: 15),
            const Spacer(),
            GestureDetector(
              onTap: c.goForgotPassword,
              child: const AppText(data: 'Forget Password?', fontSize: 15, fontWeight: FontWeight.w500),
            ),
          ],
        ),
        const SizedBox(height: 32),
        AppButton(buttonText: 'Sign in', onPressed: c.onSignIn, buttonHeight: 56),
      ],
    );
  }
}
