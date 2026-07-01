import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/app_colors.dart';
import '../../../core/widgets/section_card.dart';
import '../../../core/widgets/text/app_text.dart';
import '../controllers/support_controller.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.put(SupportController());
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(40, 8, 40, 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 16,
            runSpacing: 12,
            children: [
              _StatPill(count: c.openCount, label: 'Open', bg: AppColors.amberBg, fg: AppColors.amberText),
              _StatPill(count: c.pendingCount, label: 'Pending', bg: const Color(0xFFFBE0E6), fg: AppColors.pink),
              _StatPill(count: c.resolvedTodayCount, label: 'Resolved today', bg: AppColors.greenBg, fg: AppColors.greenText),
            ],
          ),
          const SizedBox(height: 20),
          SectionCard(
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const AppText(data: 'All tickets', fontSize: 18, fontWeight: FontWeight.w700),
                    const Spacer(),
                    _FilterTabs(c: c),
                  ],
                ),
                const SizedBox(height: 8),
                Obx(() => Column(
                      children: [
                        for (final t in c.visible) ...[
                          const Divider(height: 1, color: AppColors.border),
                          _TicketTile(c: c, t: t),
                        ],
                      ],
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatPill extends StatelessWidget {
  final int count;
  final String label;
  final Color bg;
  final Color fg;
  const _StatPill({required this.count, required this.label, required this.bg, required this.fg});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 30,
            height: 30,
            alignment: Alignment.center,
            decoration: BoxDecoration(color: bg, shape: BoxShape.circle),
            child: AppText(data: '$count', fontSize: 14, fontWeight: FontWeight.w700, color: fg),
          ),
          const SizedBox(width: 12),
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: AppText(data: label, fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}

class _FilterTabs extends StatelessWidget {
  final SupportController c;
  const _FilterTabs({required this.c});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(color: const Color(0xFFF1ECE3), borderRadius: BorderRadius.circular(12)),
      child: Obx(() => Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (final f in const ['All', 'Open', 'Resolved']) _tab(f, c.filter.value == f),
            ],
          )),
    );
  }

  Widget _tab(String label, bool selected) {
    return GestureDetector(
      onTap: () => c.setFilter(label),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 9),
        decoration: BoxDecoration(
          color: selected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(9),
        ),
        child: AppText(
          data: label,
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: selected ? AppColors.textPrimary : AppColors.textMuted,
        ),
      ),
    );
  }
}

class _TicketTile extends StatelessWidget {
  final SupportController c;
  final TicketRow t;
  const _TicketTile({required this.c, required this.t});

  @override
  Widget build(BuildContext context) {
    final isOpen = t.status == 'Open';
    final dotColor = isOpen ? AppColors.red : AppColors.amber;
    final statusBg = isOpen ? AppColors.redBg : AppColors.amberBg;
    final statusFg = isOpen ? AppColors.red : AppColors.amberText;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 22),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 6, right: 14),
            child: Container(width: 10, height: 10, decoration: BoxDecoration(color: dotColor, shape: BoxShape.circle)),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    AppText(data: '#${t.id}', fontSize: 17, fontWeight: FontWeight.w700),
                    const SizedBox(width: 8),
                    Flexible(child: AppText(data: '— ${t.title}', fontSize: 17, fontWeight: FontWeight.w600, maxLines: 1, overflow: TextOverflow.ellipsis)),
                  ],
                ),
                const SizedBox(height: 8),
                AppText(data: '${t.name} · ${t.category} · ${t.time}', fontSize: 14, color: AppColors.textMuted),
                const SizedBox(height: 10),
                AppText(
                  data: '“${t.quote}”',
                  fontSize: 15,
                  color: AppColors.textSecondary,
                  fontStyle: FontStyle.italic,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                decoration: BoxDecoration(color: statusBg, borderRadius: BorderRadius.circular(20)),
                child: AppText(data: t.status, fontSize: 13, fontWeight: FontWeight.w600, color: statusFg),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  _btn('Reply', AppColors.sidebar, Colors.white, () => c.reply(t)),
                  const SizedBox(width: 10),
                  _btn('Resolve', AppColors.greenBg, AppColors.greenText, () => c.resolve(t)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _btn(String label, Color bg, Color fg, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 9),
        decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(8)),
        child: AppText(data: label, fontSize: 14, fontWeight: FontWeight.w600, color: fg),
      ),
    );
  }
}
