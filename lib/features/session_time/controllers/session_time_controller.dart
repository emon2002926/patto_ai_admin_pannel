import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/app_colors.dart';

class FeatureTimeRow {
  final String label;
  final double fraction;
  final Color color;
  final String trailing;
  const FeatureTimeRow(this.label, this.fraction, this.color, this.trailing);
}

class SegmentRow {
  final String segment;
  final String perDay;
  final String perWeek;
  final String perMonth;
  const SegmentRow(this.segment, this.perDay, this.perWeek, this.perMonth);
}

class SessionTimeController extends GetxController {
  final List<double> daily = const [3.2, 3.8, 3.5, 4.1, 3.9, 4.4, 4.0, 4.3];
  final List<String> weekLabels = const ['7', '14', '21', '28', '5', '12', '19', '26'];

  final List<FeatureTimeRow> timeByFeature = const [
    FeatureTimeRow('Daily Question', 0.30, AppColors.green, '~68s'),
    FeatureTimeRow('Topics', 0.95, AppColors.barMaroon, '~8m'),
    FeatureTimeRow('Analysis & Pact', 0.72, AppColors.barMaroon, '~6m'),
    FeatureTimeRow('AI Coach', 0.60, AppColors.amber, '~5m'),
    FeatureTimeRow('Daily Reveal', 0.16, AppColors.green, '~35s'),
    FeatureTimeRow('Challenges', 0.18, AppColors.pink, '~40s'),
    FeatureTimeRow('Moments', 0.20, AppColors.pink, '~45s'),
    FeatureTimeRow('Other', 0.0, AppColors.track, '—'),
  ];

  final RxList<SegmentRow> segments = <SegmentRow>[
    const SegmentRow('Pact confirmed', '6m 10s', '26m', '104m'),
    const SegmentRow('Annual plan', '5m 30s', '24m', '96m'),
    const SegmentRow('Monthly plan', '4m 05s', '17m', '70m'),
    const SegmentRow('New (30 days)', '3m 40s', '15m', '62m'),
    const SegmentRow('Free tier', '2m 50s', '11m', '45m'),
  ].obs;
}
