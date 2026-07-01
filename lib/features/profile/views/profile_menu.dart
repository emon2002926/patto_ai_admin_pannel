import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/app_colors.dart';
import '../../../core/widgets/text/app_text.dart';
import '../controllers/profile_controller.dart';

/// Dropdown shown when the top-bar avatar is tapped (anchored top-right).
class ProfileMenu extends StatelessWidget {
  const ProfileMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<ProfileController>();
    return Stack(
      children: [
        Positioned(
          top: 78,
          right: 40,
          child: Material(
            color: Colors.transparent,
            child: Container(
              width: 288,
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(
                      color: Color(0x1F000000),
                      blurRadius: 24,
                      offset: Offset(0, 10)),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 14),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 22,
                          backgroundColor: AppColors.sidebar,
                          child: Obx(() => Text(
                                c.initials,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700),
                              )),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Obx(() => AppText(
                                    data: c.name.value,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                  )),
                              const SizedBox(height: 2),
                              Obx(() => AppText(
                                    data: c.role.value,
                                    fontSize: 13,
                                    color: AppColors.textMuted,
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(height: 1, color: AppColors.border),
                  _MenuTile(
                    icon: Icons.person_outline,
                    label: 'Account Settings',
                    onTap: c.openAccountSetting,
                  ),
                  _MenuTile(
                    icon: Icons.lock_outline,
                    label: 'Change Password',
                    onTap: c.openPasswordChange,
                  ),
                  const Divider(height: 1, color: AppColors.border),
                  _MenuTile(
                    icon: Icons.logout,
                    label: 'Logout',
                    danger: true,
                    onTap: c.logout,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _MenuTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool danger;
  const _MenuTile({
    required this.icon,
    required this.label,
    required this.onTap,
    this.danger = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = danger ? AppColors.red : AppColors.textPrimary;
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
        child: Row(
          children: [
            Icon(icon, size: 20, color: color),
            const SizedBox(width: 14),
            AppText(
                data: label,
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: color),
          ],
        ),
      ),
    );
  }
}
