import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/app_colors.dart';
import '../../../core/widgets/section_card.dart';
import '../../../core/widgets/status_badge.dart';
import '../../../core/widgets/text/app_text.dart';
import '../controllers/administrators_controller.dart';

class AdministratorsScreen extends StatelessWidget {
  const AdministratorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.put(AdministratorsController());
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(40, 8, 40, 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Obx(() => AppText(
                    data: '${c.administrators.length} users',
                    fontSize: 16,
                    color: AppColors.textMuted,
                  )),
              const Spacer(),
              InkWell(
                onTap: c.openAdd,
                borderRadius: BorderRadius.circular(28),
                child: Container(
                  height: 48,
                  padding: const EdgeInsets.symmetric(horizontal: 22),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(color: AppColors.sidebar, borderRadius: BorderRadius.circular(28)),
                  child: const AppText(data: '+ Add user', fontSize: 15, fontWeight: FontWeight.w600, color: Colors.white),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SectionCard(
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 8),
            child: LayoutBuilder(
              builder: (context, cns) {
                const minW = 1100.0;
                final content = SizedBox(
                  width: cns.maxWidth < minW ? minW : cns.maxWidth,
                  child: Column(
                    children: [
                      _headerRow(),
                      const Divider(height: 1, color: AppColors.border),
                      Obx(() => Column(
                            children: [
                              for (int i = 0; i < c.administrators.length; i++) ...[
                                _dataRow(c, c.administrators[i]),
                                if (i != c.administrators.length - 1)
                                  const Divider(height: 1, color: AppColors.border),
                              ],
                            ],
                          )),
                    ],
                  ),
                );
                if (cns.maxWidth < minW) {
                  return SingleChildScrollView(scrollDirection: Axis.horizontal, child: content);
                }
                return content;
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _headerRow() {
    Widget h(String t, int flex) => Expanded(
          flex: flex,
          child: AppText(data: t, fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textMuted, letterSpacing: 0.6),
        );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        children: [
          h('USER', 3),
          h('ROLE', 2),
          h('EMAIL', 3),
          h('LANGUAGE', 2),
          h('PLAN', 2),
          h('JOINED', 2),
          h('LAST ACTIVE', 2),
          h('STATUS', 2),
          h('ACTIONS', 3),
        ],
      ),
    );
  }

  Widget _dataRow(AdministratorsController c, AdministratorRow r) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Row(
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundColor: AppColors.sidebar,
                  child: AppText(
                    data: r.name.isNotEmpty ? r.name[0].toUpperCase() : '?',
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(child: AppText(data: r.name, fontSize: 16, fontWeight: FontWeight.w600, maxLines: 2)),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                decoration: BoxDecoration(color: AppColors.neutralBg, borderRadius: BorderRadius.circular(20)),
                child: AppText(data: r.role, fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textSecondary),
              ),
            ),
          ),
          Expanded(flex: 3, child: AppText(data: r.email, fontSize: 15, color: AppColors.textMuted)),
          Expanded(flex: 2, child: AppText(data: r.language, fontSize: 15, color: AppColors.textSecondary)),
          Expanded(flex: 2, child: Align(alignment: Alignment.centerLeft, child: StatusBadge.plan(r.plan))),
          Expanded(flex: 2, child: AppText(data: r.joined, fontSize: 15, color: AppColors.textSecondary)),
          Expanded(flex: 2, child: AppText(data: r.lastActive, fontSize: 15, color: AppColors.textSecondary)),
          Expanded(flex: 2, child: Align(alignment: Alignment.centerLeft, child: StatusBadge.status(r.status))),
          Expanded(
            flex: 3,
            child: Row(
              children: [
                _actionButton('Edit', AppColors.textPrimary, AppColors.inputBorder, () => c.openEdit(r)),
                const SizedBox(width: 10),
                _actionButton('Delete', AppColors.red, const Color(0xFFEBC9C9), () => c.confirmRemove(r)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _actionButton(String label, Color fg, Color border, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: border),
        ),
        child: AppText(data: label, fontSize: 14, fontWeight: FontWeight.w600, color: fg),
      ),
    );
  }
}
