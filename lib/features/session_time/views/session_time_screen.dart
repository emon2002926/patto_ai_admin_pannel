import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/app_colors.dart';
import '../../../core/widgets/metric_bar.dart';
import '../../../core/widgets/section_card.dart';
import '../../../core/widgets/simple_bar_chart.dart';
import '../../../core/widgets/stat_card.dart';
import '../../../core/widgets/text/app_text.dart';
import '../controllers/session_time_controller.dart';

class SessionTimeScreen extends StatelessWidget {
  const SessionTimeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.put(SessionTimeController());
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(40, 8, 40, 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StatCardRow(
            cards: const [
              StatCard(label: 'Avg Session / Day', value: '4m 20s', deltaText: '38s vs last month', secondaryText: 'per active user'),
              StatCard(label: 'Avg Time / Week', value: '18m', deltaText: '2m vs last month', secondaryText: 'per active couple'),
              StatCard(label: 'Avg Time / Month', value: '74m', deltaText: '8m vs last month', secondaryText: 'per active couple'),
              StatCard(label: 'Sessions / Week', value: '4.8', secondaryText: 'avg opens per user'),
            ],
          ),
          const SizedBox(height: 24),
          LayoutBuilder(
            builder: (context, cns) {
              final chart = SectionCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const AppText(data: 'Daily session time — last 8 weeks', fontSize: 18, fontWeight: FontWeight.w700),
                    const SizedBox(height: 16),
                    SimpleBarChart(
                      values: c.daily,
                      topLabels: c.daily.map((e) => '${e}m').toList(),
                      bottomLabels: c.weekLabels,
                    ),
                  ],
                ),
              );
              final byFeature = SectionCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const AppText(data: 'Time by feature', fontSize: 18, fontWeight: FontWeight.w700),
                    const SizedBox(height: 8),
                    for (final f in c.timeByFeature)
                      MetricBar(label: f.label, fraction: f.fraction, fillColor: f.color, trailing: f.trailing, labelWidth: 150, trailingWidth: 52),
                  ],
                ),
              );
              if (cns.maxWidth < 1000) {
                return Column(children: [chart, const SizedBox(height: 24), byFeature]);
              }
              return IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(child: chart),
                    const SizedBox(width: 24),
                    Expanded(child: byFeature),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 24),
          _SegmentTable(c: c),
        ],
      ),
    );
  }
}

class _SegmentTable extends StatelessWidget {
  final SessionTimeController c;
  const _SegmentTable({required this.c});

  @override
  Widget build(BuildContext context) {
    Widget h(String t, int flex) => Expanded(
        flex: flex,
        child: AppText(data: t, fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textMuted, letterSpacing: 0.6));
    return SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppText(data: 'Session time by segment', fontSize: 18, fontWeight: FontWeight.w700),
          const SizedBox(height: 18),
          Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: Row(children: [h('SEGMENT', 3), h('AVG / DAY', 2), h('AVG / WEEK', 2), h('AVG / MONTH', 2)]),
          ),
          const Divider(height: 1, color: AppColors.border),
          Obx(() => Column(
                children: [
                  for (int i = 0; i < c.segments.length; i++) ...[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      child: Row(
                        children: [
                          Expanded(flex: 3, child: AppText(data: c.segments[i].segment, fontSize: 16, fontWeight: FontWeight.w600)),
                          Expanded(flex: 2, child: AppText(data: c.segments[i].perDay, fontSize: 16, color: AppColors.textSecondary)),
                          Expanded(flex: 2, child: AppText(data: c.segments[i].perWeek, fontSize: 16, color: AppColors.textSecondary)),
                          Expanded(flex: 2, child: AppText(data: c.segments[i].perMonth, fontSize: 16, color: AppColors.textSecondary)),
                        ],
                      ),
                    ),
                    if (i != c.segments.length - 1) const Divider(height: 1, color: AppColors.border),
                  ],
                ],
              )),
        ],
      ),
    );
  }
}
