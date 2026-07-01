import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/app_colors.dart';
import '../../../core/widgets/metric_bar.dart';
import '../../../core/widgets/section_card.dart';
import '../../../core/widgets/simple_bar_chart.dart';
import '../../../core/widgets/stat_card.dart';
import '../../../core/widgets/text/app_text.dart';
import '../controllers/overview_controller.dart';

class OverviewScreen extends StatelessWidget {
  const OverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.put(OverviewController());
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(40, 8, 40, 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StatCardRow(
            cards: const [
              StatCard(
                label: 'Active couples',
                value: '284',
                deltaText: '18 this month',
                secondaryText: '568 total users',
              ),
              StatCard(
                label: 'MRR',
                value: '\$2,890',
                deltaText: '12.4%',
                secondaryText: 'vs last month',
              ),
              StatCard(
                label: 'Churn rate',
                value: '4.2%',
                deltaText: 'improving',
                deltaColor: AppColors.red,
                deltaUp: false,
                secondaryText: '8 cancelled this month',
              ),
              StatCard(
                label: 'Avg streak',
                value: '11',
                valueEmoji: '🔥',
                deltaText: '2 days',
                secondaryText: 'daily question streak',
              ),
            ],
          ),
          const SizedBox(height: 24),
          LayoutBuilder(
            builder: (context, cns) {
              final chart = SectionCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const AppText(data: 'New couples — last 8 weeks', fontSize: 18, fontWeight: FontWeight.w700),
                    const SizedBox(height: 16),
                    SimpleBarChart(
                      values: c.newCouples,
                      topLabels: c.newCouples.map((e) => e.toInt().toString()).toList(),
                      bottomLabels: c.weekLabels,
                    ),
                  ],
                ),
              );
              final plan = _PlanSplitCard(c: c);
              if (cns.maxWidth < 1000) {
                return Column(children: [chart, const SizedBox(height: 24), plan]);
              }
              return IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(flex: 3, child: chart),
                    const SizedBox(width: 24),
                    SizedBox(width: 380, child: plan),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 24),
          LayoutBuilder(
            builder: (context, cns) {
              final alerts = _AlertsCard(c: c);
              final health = _EngagementHealthCard(c: c);
              if (cns.maxWidth < 1000) {
                return Column(children: [alerts, const SizedBox(height: 24), health]);
              }
              return IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(child: alerts),
                    const SizedBox(width: 24),
                    Expanded(child: health),
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

class _PlanSplitCard extends StatelessWidget {
  final OverviewController c;
  const _PlanSplitCard({required this.c});

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppText(data: 'Plan split', fontSize: 18, fontWeight: FontWeight.w700),
          const SizedBox(height: 20),
          _planRow('Monthly \$12', c.monthlyPct, AppColors.barMaroon),
          const SizedBox(height: 20),
          _planRow('Annual \$119', c.annualPct, AppColors.green),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(child: _tile('${c.monthlyCount}', 'monthly', AppColors.planPinkBg, AppColors.planPinkText)),
              const SizedBox(width: 14),
              Expanded(child: _tile('${c.annualCount}', 'annual', AppColors.greenBg, AppColors.greenText)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _planRow(String label, int pct, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            AppText(data: label, fontSize: 16, fontWeight: FontWeight.w600),
            const Spacer(),
            AppText(data: '$pct%', fontSize: 16, fontWeight: FontWeight.w600),
          ],
        ),
        const SizedBox(height: 10),
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: LinearProgressIndicator(
            value: pct / 100,
            minHeight: 10,
            backgroundColor: AppColors.track,
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        ),
      ],
    );
  }

  Widget _tile(String value, String label, Color bg, Color fg) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 18),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(14)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(data: value, fontSize: 30, fontWeight: FontWeight.w700, color: fg),
          const SizedBox(height: 2),
          AppText(data: label, fontSize: 14, color: fg),
        ],
      ),
    );
  }
}

class _AlertsCard extends StatelessWidget {
  final OverviewController c;
  const _AlertsCard({required this.c});

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Text('⚠️', style: TextStyle(fontSize: 18)),
              SizedBox(width: 8),
              AppText(data: 'Alerts', fontSize: 18, fontWeight: FontWeight.w700),
            ],
          ),
          const SizedBox(height: 16),
          Obx(() => Column(
                children: [
                  for (final a in c.alerts)
                    Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      decoration: BoxDecoration(
                        color: a.warning ? const Color(0xFFFBF6E3) : AppColors.greenBg,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Text(a.emoji, style: const TextStyle(fontSize: 16)),
                          const SizedBox(width: 12),
                          Expanded(
                            child: AppText(
                              data: a.text,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: a.warning ? AppColors.amberText : AppColors.greenText,
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

class _EngagementHealthCard extends StatelessWidget {
  final OverviewController c;
  const _EngagementHealthCard({required this.c});

  @override
  Widget build(BuildContext context) {
    Color barColor(int v) => v >= 70
        ? AppColors.green
        : v >= 55
            ? AppColors.barMaroon
            : AppColors.amber;
    return SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppText(data: 'Engagement health', fontSize: 18, fontWeight: FontWeight.w700),
          const SizedBox(height: 8),
          for (final (label, v) in c.engagementHealth)
            MetricBar(
              label: label,
              fraction: v / 100,
              fillColor: barColor(v),
              trailing: '$v%',
              labelWidth: 200,
            ),
        ],
      ),
    );
  }
}
