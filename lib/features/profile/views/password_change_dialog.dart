import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/app_colors.dart';
import '../../../core/widgets/text/app_text.dart';
import '../../../core/widgets/text/text_field/AppTextFiled.dart';
import '../controllers/profile_controller.dart';

class PasswordChangeDialog extends StatelessWidget {
  const PasswordChangeDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<ProfileController>();
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(24),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 460),
        child: Container(
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Expanded(
                    child: AppText(data: 'Change Password', fontSize: 22, fontWeight: FontWeight.w700),
                  ),
                  InkWell(
                    onTap: () => Get.back(),
                    customBorder: const CircleBorder(),
                    child: Container(
                      width: 34,
                      height: 34,
                      decoration: const BoxDecoration(color: AppColors.sidebar, shape: BoxShape.circle),
                      child: const Icon(Icons.close, size: 18, color: Colors.white),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 22),
              _pwField('Current password', c.oldPass, c.obscureOld, c.toggleOld),
              const SizedBox(height: 16),
              _pwField('New password', c.newPass, c.obscureNew, c.toggleNew),
              const SizedBox(height: 16),
              _pwField('Confirm new password', c.retypePass, c.obscureRetype, c.toggleRetype),
              const SizedBox(height: 26),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () => Get.back(),
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        height: 50,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: AppColors.inputBorder),
                        ),
                        child: const AppText(data: 'Cancel', fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: InkWell(
                      onTap: c.updatePassword,
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        height: 50,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(10)),
                        child: const AppText(data: 'Update', fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _pwField(String label, TextEditingController ctrl, RxBool obscure, VoidCallback toggle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(data: label, fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textSecondary),
        const SizedBox(height: 8),
        Obx(() => AppTextField(
              controller: ctrl,
              hintText: '********',
              obscureText: obscure.value,
              suffixWidget: IconButton(
                onPressed: toggle,
                icon: Icon(
                  obscure.value ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                  color: AppColors.textMuted,
                ),
              ),
            )),
      ],
    );
  }
}
