import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/app_colors.dart';
import '../../../core/widgets/section_card.dart';
import '../../../core/widgets/stat_card.dart';
import '../../../core/widgets/text/app_text.dart';
import '../controllers/ai_api_costs_controller.dart';

class AiApiCostsScreen extends StatelessWidget {
  const AiApiCostsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.put(AiApiCostsController());
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(40, 8, 40, 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StatCardRow(
            cards: const [
              StatCard(label: 'API Spend (June)', value: '\$184', deltaText: '\$23 vs May'),
              StatCard(label: 'Cost per Couple/mo', value: '\$0.65', deltaText: '\$0.08 vs May', deltaColor: AppColors.red, deltaUp: false),
              StatCard(label: 'API Calls (June)', value: '18,420', secondaryText: 'avg 65/couple'),
              StatCard(label: 'P99 Latency', value: '420ms', deltaText: '40ms', deltaColor: AppColors.red, deltaUp: false),
            ],
          ),
          const SizedBox(height: 24),
          LayoutBuilder(
            builder: (context, cns) {
              final cost = _CostByFeatureCard(c: c);
              final projected = _ProjectedCard(c: c);
              if (cns.maxWidth < 1000) {
                return Column(children: [cost, const SizedBox(height: 24), projected]);
              }
              return IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(child: cost),
                    const SizedBox(width: 24),
                    Expanded(child: projected),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _CostByFeatureCard extends StatelessWidget {
  final AiApiCostsController c;
  const _CostByFeatureCard({required this.c});

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppText(data: 'Cost by feature', fontSize: 18, fontWeight: FontWeight.w700),
          const SizedBox(height: 8),
          for (int i = 0; i < c.costByFeature.length; i++) ...[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 18),
              child: Row(
                children: [
                  Expanded(child: AppText(data: c.costByFeature[i].label, fontSize: 16, fontWeight: FontWeight.w500)),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      AppText(data: c.costByFeature[i].amount, fontSize: 17, fontWeight: FontWeight.w700),
                      const SizedBox(height: 2),
                      AppText(data: c.costByFeature[i].pct, fontSize: 13, color: AppColors.textMuted),
                    ],
                  ),
                ],
              ),
            ),
            if (i != c.costByFeature.length - 1) const Divider(height: 1, color: AppColors.border),
          ],
        ],
      ),
    );
  }
}

class _ProjectedCard extends StatelessWidget {
  final AiApiCostsController c;
  const _ProjectedCard({required this.c});

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppText(data: 'Projected costs at scale', fontSize: 18, fontWeight: FontWeight.w700),
          const SizedBox(height: 18),
          for (final s in c.savings)
            Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              decoration: BoxDecoration(color: AppColors.greenBg, borderRadius: BorderRadius.circular(12)),
              child: Row(
                children: [
                  const Icon(Icons.savings_outlined, size: 18, color: AppColors.greenText),
                  const SizedBox(width: 12),
                  Expanded(
                    child: AppText(data: s, fontSize: 15, fontWeight: FontWeight.w500, color: AppColors.greenText),
                  ),
                ],
              ),
            ),
          const SizedBox(height: 12),
          for (int i = 0; i < c.projected.length; i++) ...[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Row(
                children: [
                  Expanded(child: AppText(data: c.projected[i].couples, fontSize: 16, fontWeight: FontWeight.w500)),
                  AppText(data: c.projected[i].cost, fontSize: 17, fontWeight: FontWeight.w700),
                ],
              ),
            ),
            if (i != c.projected.length - 1) const Divider(height: 1, color: AppColors.border),
          ],
        ],
      ),
    );
  }
}
