import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/app_colors.dart';
import '../../../core/widgets/text/app_text.dart';
import '../../../core/widgets/text/text_field/AppTextFiled.dart';
import '../controllers/profile_controller.dart';

class AccountSettingDialog extends StatelessWidget {
  const AccountSettingDialog({super.key});

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
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Expanded(
                      child: AppText(
                        data: 'Account Settings',
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    _CloseButton(onTap: () => Get.back()),
                  ],
                ),
                const SizedBox(height: 22),
                _Field(label: 'Full name', child: AppTextField(controller: c.accName, hintText: 'Enter full name')),
                const SizedBox(height: 16),
                _Field(label: 'Email', child: AppTextField(controller: c.accEmail, hintText: 'Enter email', keyboardType: TextInputType.emailAddress)),
                const SizedBox(height: 16),
                _Field(label: 'Phone', child: AppTextField(controller: c.accPhone, hintText: 'Enter phone number', keyboardType: TextInputType.phone)),
                const SizedBox(height: 16),
                const AppText(data: 'Role', fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textSecondary),
                const SizedBox(height: 8),
                Obx(() => Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.inputBorder),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: c.accRole.value,
                          isExpanded: true,
                          items: c.roles
                              .map((r) => DropdownMenuItem(value: r, child: AppText(data: r, fontSize: 15)))
                              .toList(),
                          onChanged: (v) => c.accRole.value = v ?? c.accRole.value,
                        ),
                      ),
                    )),
                const SizedBox(height: 16),
                InkWell(
                  onTap: c.pickImage,
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.inputBorder),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.image_outlined, color: AppColors.textMuted),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Obx(() => AppText(
                                data: c.accImageName.value.isEmpty ? 'Upload profile photo' : c.accImageName.value,
                                fontSize: 15,
                                color: c.accImageName.value.isEmpty ? AppColors.textMuted : AppColors.textPrimary,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 26),
                Row(
                  children: [
                    Expanded(child: _OutlinedButton(text: 'Cancel', onTap: () => Get.back())),
                    const SizedBox(width: 14),
                    Expanded(child: _FilledButton(text: 'Save', onTap: c.saveAccount)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Field extends StatelessWidget {
  final String label;
  final Widget child;
  const _Field({required this.label, required this.child});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(data: label, fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textSecondary),
        const SizedBox(height: 8),
        child,
      ],
    );
  }
}

class _CloseButton extends StatelessWidget {
  final VoidCallback onTap;
  const _CloseButton({required this.onTap});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      customBorder: const CircleBorder(),
      child: Container(
        width: 34,
        height: 34,
        decoration: const BoxDecoration(color: AppColors.sidebar, shape: BoxShape.circle),
        child: const Icon(Icons.close, size: 18, color: Colors.white),
      ),
    );
  }
}

class _FilledButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  const _FilledButton({required this.text, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        height: 50,
        alignment: Alignment.center,
        decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(10)),
        child: const AppText(data: 'Save', fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
      ),
    );
  }
}

class _OutlinedButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  const _OutlinedButton({required this.text, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        height: 50,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.inputBorder),
        ),
        child: AppText(data: text, fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.textPrimary),
      ),
    );
  }
}
