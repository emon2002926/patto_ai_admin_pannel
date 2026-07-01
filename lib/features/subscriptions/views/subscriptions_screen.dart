import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/app_colors.dart';
import '../../../core/widgets/metric_bar.dart';
import '../../../core/widgets/section_card.dart';
import '../../../core/widgets/status_badge.dart';
import '../../../core/widgets/stat_card.dart';
import '../../../core/widgets/text/app_text.dart';
import '../controllers/subscriptions_controller.dart';

class SubscriptionsScreen extends StatelessWidget {
  const SubscriptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.put(SubscriptionsController());
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(40, 8, 40, 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StatCardRow(
            cards: const [
              StatCard(label: 'MRR', value: '\$2,890', deltaText: '\$318 vs last month'),
              StatCard(label: 'ARR Run Rate', value: '\$34,680', deltaText: '12.4%'),
              StatCard(label: 'Churn', value: '4.2%', deltaText: '0.8%', secondaryText: '8 this month'),
              StatCard(label: 'Avg LTV', value: '\$94', deltaText: '\$8'),
            ],
          ),
          const SizedBox(height: 24),
          LayoutBuilder(
            builder: (context, cns) {
              final tx = _TransactionsCard(c: c);
              final cancel = _CancellationCard(c: c);
              if (cns.maxWidth < 1000) {
                return Column(children: [tx, const SizedBox(height: 24), cancel]);
              }
              return IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(child: tx),
                    const SizedBox(width: 24),
                    Expanded(child: cancel),
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

class _TransactionsCard extends StatelessWidget {
  final SubscriptionsController c;
  const _TransactionsCard({required this.c});

  @override
  Widget build(BuildContext context) {
    Widget h(String t, int flex) => Expanded(
        flex: flex,
        child: AppText(data: t, fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textMuted, letterSpacing: 0.6));
    return SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppText(data: 'Recent transactions', fontSize: 18, fontWeight: FontWeight.w700),
          const SizedBox(height: 18),
          Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: Row(children: [h('COUPLE', 3), h('AMOUNT', 2), h('PLAN', 2), h('DATE', 2), h('STATUS', 2)]),
          ),
          const Divider(height: 1, color: AppColors.border),
          Obx(() => Column(
                children: [
                  for (final t in c.transactions)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      child: Row(
                        children: [
                          Expanded(flex: 3, child: AppText(data: t.couple, fontSize: 15, fontWeight: FontWeight.w500)),
                          Expanded(flex: 2, child: AppText(data: t.amount, fontSize: 15)),
                          Expanded(flex: 2, child: Align(alignment: Alignment.centerLeft, child: StatusBadge.plan(t.plan))),
                          Expanded(flex: 2, child: AppText(data: t.date, fontSize: 15, color: AppColors.textSecondary)),
                          Expanded(
                            flex: 2,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: StatusBadge(text: t.status, bg: AppColors.greenBg, fg: AppColors.greenText),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              )),
        ],
      ),
    );
  }
}

class _CancellationCard extends StatelessWidget {
  final SubscriptionsController c;
  const _CancellationCard({required this.c});

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppText(data: 'Cancellation reasons', fontSize: 18, fontWeight: FontWeight.w700),
          const SizedBox(height: 12),
          for (final (label, v) in c.cancellationReasons)
            MetricBar(label: label, fraction: v / 100, fillColor: AppColors.barMaroon, trailing: '$v%', labelWidth: 180),
        ],
      ),
    );
  }
}
