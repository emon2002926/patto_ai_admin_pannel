import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/app_colors.dart';
import '../../../core/widgets/section_card.dart';
import '../../../core/widgets/status_badge.dart';
import '../../../core/widgets/text/app_text.dart';
import '../controllers/couples_controller.dart';

class CouplesScreen extends StatelessWidget {
  const CouplesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.put(CouplesController());
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(40, 8, 40, 40),
      child: SectionCard(
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 8),
        child: LayoutBuilder(
          builder: (context, cns) {
            final content = SizedBox(
              width: cns.maxWidth < 900 ? 900 : cns.maxWidth,
              child: Column(
                children: [
                  _headerRow(),
                  const Divider(height: 1, color: AppColors.border),
                  Obx(() => Column(
                        children: [
                          for (int i = 0; i < c.couples.length; i++) ...[
                            _dataRow(c.couples[i]),
                            if (i != c.couples.length - 1)
                              const Divider(height: 1, color: AppColors.border),
                          ],
                        ],
                      )),
                ],
              ),
            );
            if (cns.maxWidth < 900) {
              return SingleChildScrollView(scrollDirection: Axis.horizontal, child: content);
            }
            return content;
          },
        ),
      ),
    );
  }

  Widget _headerRow() {
    Widget h(String t, int flex, {TextAlign align = TextAlign.left}) => Expanded(
          flex: flex,
          child: AppText(
            data: t,
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: AppColors.textMuted,
            letterSpacing: 0.6,
            textAlign: align,
          ),
        );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        children: [
          h('COUPLE', 3),
          h('PLAN', 2),
          h('PACT', 2),
          h('TOPICS', 2),
          h('STREAK', 2),
          h('JOINED', 2),
          h('LAST ACTIVE', 2),
          h('MRR', 2, align: TextAlign.right),
        ],
      ),
    );
  }

  Widget _dataRow(CoupleRow r) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 22),
      child: Row(
        children: [
          Expanded(flex: 3, child: AppText(data: r.couple, fontSize: 16, fontWeight: FontWeight.w600)),
          Expanded(flex: 2, child: Align(alignment: Alignment.centerLeft, child: StatusBadge.plan(r.plan))),
          Expanded(flex: 2, child: Align(alignment: Alignment.centerLeft, child: StatusBadge.pact(r.pact))),
          Expanded(flex: 2, child: AppText(data: r.topics, fontSize: 16, color: AppColors.textSecondary)),
          Expanded(flex: 2, child: AppText(data: r.streak, fontSize: 16, fontWeight: FontWeight.w600)),
          Expanded(flex: 2, child: AppText(data: r.joined, fontSize: 16, color: AppColors.textSecondary)),
          Expanded(flex: 2, child: AppText(data: r.lastActive, fontSize: 16, color: AppColors.textSecondary)),
          Expanded(flex: 2, child: AppText(data: r.mrr, fontSize: 16, fontWeight: FontWeight.w600, textAlign: TextAlign.right)),
        ],
      ),
    );
  }
}
