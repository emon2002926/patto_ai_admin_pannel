import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/widgets/metric_bar.dart';
import '../../../core/widgets/section_card.dart';
import '../../../core/widgets/text/app_text.dart';
import '../controllers/topics_pacts_controller.dart';

class TopicsPactsScreen extends StatelessWidget {
  const TopicsPactsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.put(TopicsPactsController());
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(40, 8, 40, 40),
      child: LayoutBuilder(
        builder: (context, cns) {
          final left = _card('Completion rate', c.completion);
          final right = _card('Avg alignment score', c.alignment);
          if (cns.maxWidth < 1000) {
            return Column(children: [left, const SizedBox(height: 24), right]);
          }
          return IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(child: left),
                const SizedBox(width: 24),
                Expanded(child: right),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _card(String title, List<TopicRow> rows) {
    return SectionCard(
      padding: const EdgeInsets.all(28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(data: title, fontSize: 18, fontWeight: FontWeight.w700),
          const SizedBox(height: 8),
          for (final r in rows)
            MetricBar(
              label: r.label,
              emoji: r.emoji,
              fraction: r.pct / 100,
              fillColor: r.color,
              trailing: '${r.pct}%',
              labelWidth: 150,
            ),
        ],
      ),
    );
  }
}
