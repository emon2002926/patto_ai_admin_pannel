import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/app_colors.dart';

class BarRow {
  final String label;
  final int pct;
  final Color color;
  const BarRow(this.label, this.pct, this.color);
}

class EngagementController extends GetxController {
  final List<BarRow> featureAdoption = const [
    BarRow('Daily questions', 91, AppColors.green),
    BarRow('Topics (1+)', 84, AppColors.green),
    BarRow('Pact confirmed', 58, AppColors.barMaroon),
    BarRow('Challenges', 49, AppColors.barMaroon),
    BarRow('AI Coach', 38, AppColors.amber),
    BarRow('Moments', 32, AppColors.amber),
    BarRow('Conflict mode', 18, AppColors.pink),
  ];

  final List<(String, int)> retentionCohort = const [
    ('Week 1', 100),
    ('Week 2', 84),
    ('Week 3', 72),
    ('Week 4', 68),
    ('Week 8', 61),
    ('Week 12', 55),
  ];
}
