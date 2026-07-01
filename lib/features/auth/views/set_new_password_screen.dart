import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/app_colors.dart';
import '../../../core/widgets/buttons/app_button.dart';
import '../../../core/widgets/text/text_field/AppTextFiled.dart';
import '../controllers/set_new_password_controller.dart';
import '../shared_widgets/auth_shared_widgets.dart';

class SetNewPasswordScreen extends StatelessWidget {
  const SetNewPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.put(SetNewPasswordController());
    return AuthScaffold(
      title: 'Set a new password',
      subtitle: 'Create a new password. Ensure it differs from previous ones for security',
      centerSubtitle: true,
      children: [
        const AuthFieldLabel('New Password'),
        const SizedBox(height: 10),
        Obx(() => AppTextField(
              controller: c.newPass,
              hintText: '*********',
              obscureText: c.obscureNew.value,
              suffixWidget: IconButton(
                onPressed: c.toggleNew,
                icon: Icon(
                  c.obscureNew.value ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                  color: AppColors.textPrimary,
                ),
              ),
            )),
        const SizedBox(height: 22),
        const AuthFieldLabel('Confirm Password'),
        const SizedBox(height: 10),
        Obx(() => AppTextField(
              controller: c.confirmPass,
              hintText: '*********',
              obscureText: c.obscureConfirm.value,
              suffixWidget: IconButton(
                onPressed: c.toggleConfirm,
                icon: Icon(
                  c.obscureConfirm.value ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                  color: AppColors.textPrimary,
                ),
              ),
            )),
        const SizedBox(height: 32),
        AppButton(buttonText: 'Reset Password', onPressed: c.onReset, buttonHeight: 56),
      ],
    );
  }
}
