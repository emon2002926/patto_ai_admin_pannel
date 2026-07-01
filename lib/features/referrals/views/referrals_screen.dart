import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/app_colors.dart';
import '../../../core/widgets/section_card.dart';
import '../../../core/widgets/stat_card.dart';
import '../../../core/widgets/text/app_text.dart';
import '../controllers/referrals_controller.dart';

class ReferralsScreen extends StatelessWidget {
  const ReferralsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.put(ReferralsController());
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(40, 8, 40, 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LayoutBuilder(
            builder: (context, cns) {
              final cards = <Widget>[
                const StatCard(label: 'Total Referrals', value: '47', secondaryText: 'couples referred'),
                const StatCard(label: 'Converted', value: '31', secondaryText: '66% conversion rate'),
                const StatCard(label: 'Free Months Issued', value: '31', secondaryText: '\$372 in credits'),
              ];
              if (cns.maxWidth < 820) {
                return Column(
                  children: [
                    cards[0],
                    const SizedBox(height: 20),
                    cards[1],
                    const SizedBox(height: 20),
                    cards[2],
                  ],
                );
              }
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: cards[0]),
                  const SizedBox(width: 20),
                  Expanded(child: cards[1]),
                  const SizedBox(width: 20),
                  Expanded(child: cards[2]),
                ],
              );
            },
          ),
          const SizedBox(height: 24),
          _TopReferrersCard(c: c),
        ],
      ),
    );
  }
}

class _TopReferrersCard extends StatelessWidget {
  final ReferralsController c;
  const _TopReferrersCard({required this.c});

  @override
  Widget build(BuildContext context) {
    Widget h(String t, int flex) => Expanded(
        flex: flex,
        child: AppText(data: t, fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textMuted, letterSpacing: 0.6));
    return SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppText(data: 'Top referrers', fontSize: 18, fontWeight: FontWeight.w700),
          const SizedBox(height: 18),
          Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: Row(children: [h('USER', 3), h('REFERRED', 2), h('CONVERTED', 2), h('FREE MONTHS EARNED', 3)]),
          ),
          const Divider(height: 1, color: AppColors.border),
          Obx(() => Column(
                children: [
                  for (int i = 0; i < c.topReferrers.length; i++) ...[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Row(
                        children: [
                          Expanded(flex: 3, child: AppText(data: c.topReferrers[i].user, fontSize: 16, fontWeight: FontWeight.w600)),
                          Expanded(flex: 2, child: AppText(data: '${c.topReferrers[i].referred}', fontSize: 16, color: AppColors.textSecondary)),
                          Expanded(flex: 2, child: AppText(data: '${c.topReferrers[i].converted}', fontSize: 16, color: AppColors.textSecondary)),
                          Expanded(flex: 3, child: AppText(data: '${c.topReferrers[i].freeMonths}', fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.greenText)),
                        ],
                      ),
                    ),
                    if (i != c.topReferrers.length - 1) const Divider(height: 1, color: AppColors.border),
                  ],
                ],
              )),
        ],
      ),
    );
  }
}
