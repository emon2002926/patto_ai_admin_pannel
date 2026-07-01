import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/app_colors.dart';
import '../../../core/widgets/metric_bar.dart';
import '../../../core/widgets/section_card.dart';
import '../../../core/widgets/stat_card.dart';
import '../../../core/widgets/text/app_text.dart';
import '../controllers/engagement_controller.dart';

class EngagementScreen extends StatelessWidget {
  const EngagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.put(EngagementController());
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(40, 8, 40, 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StatCardRow(
            cards: const [
              StatCard(label: 'DAU/MAU', value: '41%', deltaText: '3%'),
              StatCard(label: 'Avg Daily Streak', value: '11', valueEmoji: '🔥', deltaText: '2 days'),
              StatCard(label: 'Pact Confirm Rate', value: '58%', deltaText: '4%'),
              StatCard(label: '30-Day Unlocks', value: '89', secondaryText: 'couples this month'),
            ],
          ),
          const SizedBox(height: 24),
          LayoutBuilder(
            builder: (context, cns) {
              final adoption = SectionCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const AppText(data: 'Feature adoption', fontSize: 18, fontWeight: FontWeight.w700),
                    const SizedBox(height: 8),
                    for (final b in c.featureAdoption)
                      MetricBar(label: b.label, fraction: b.pct / 100, fillColor: b.color, trailing: '${b.pct}%', labelWidth: 160),
                  ],
                ),
              );
              final retention = SectionCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const AppText(data: 'Retention cohort (June)', fontSize: 18, fontWeight: FontWeight.w700),
                    const SizedBox(height: 8),
                    for (final (label, v) in c.retentionCohort)
                      MetricBar(label: label, fraction: v / 100, fillColor: AppColors.barMaroon, trailing: '$v%', labelWidth: 120),
                  ],
                ),
              );
              if (cns.maxWidth < 1000) {
                return Column(children: [adoption, const SizedBox(height: 24), retention]);
              }
              return IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(child: adoption),
                    const SizedBox(width: 24),
                    Expanded(child: retention),
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
