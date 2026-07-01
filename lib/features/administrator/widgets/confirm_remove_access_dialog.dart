import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/app_colors.dart';
import '../../../core/widgets/text/app_text.dart';
import '../controllers/administrators_controller.dart';

/// Confirmation shown before removing a user's access (the Delete action).
class ConfirmRemoveAccessDialog extends StatelessWidget {
  final AdministratorRow admin;
  const ConfirmRemoveAccessDialog({super.key, required this.admin});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<AdministratorsController>();
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(24),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 420),
        child: Container(
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(22),
            boxShadow: const [
              BoxShadow(color: Color(0x1A000000), blurRadius: 30, offset: Offset(0, 12)),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(color: AppColors.redBg, borderRadius: BorderRadius.circular(12)),
                    child: const Icon(Icons.person_remove_outlined, color: AppColors.red),
                  ),
                  const SizedBox(width: 14),
                  const Expanded(
                    child: AppText(data: 'Remove access?', fontSize: 22, fontWeight: FontWeight.w700, fontFamily: 'Georgia'),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              AppText(
                data: '${admin.name} (${admin.email}) will lose access immediately. '
                    'This cannot be undone.',
                fontSize: 15,
                color: AppColors.textSecondary,
                height: 1.5,
              ),
              const SizedBox(height: 26),
              Row(
                children: [
                  Expanded(
                    child: _button(
                      label: 'Cancel',
                      filled: false,
                      onTap: () => Get.back(),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: _button(
                      label: 'Remove',
                      filled: true,
                      onTap: () => c.removeAdministrator(admin),
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

  Widget _button({required String label, required bool filled, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        height: 52,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: filled ? AppColors.red : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: filled ? null : Border.all(color: AppColors.inputBorder),
        ),
        child: AppText(data: label, fontSize: 16, fontWeight: FontWeight.w700, color: filled ? Colors.white : AppColors.textPrimary),
      ),
    );
  }
}
