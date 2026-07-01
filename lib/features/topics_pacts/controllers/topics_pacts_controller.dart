import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/app_colors.dart';

class TopicRow {
  final String emoji;
  final String label;
  final int pct;
  final Color color;
  const TopicRow(this.emoji, this.label, this.pct, this.color);
}

class TopicsPactsController extends GetxController {
  // Colours are taken directly from the design (not a strict value threshold).
  final List<TopicRow> completion = const [
    TopicRow('💗', 'Fidelity', 94, AppColors.green),
    TopicRow('💰', 'Money', 87, AppColors.green),
    TopicRow('👶', 'Children', 61, AppColors.barMaroon),
    TopicRow('🏠', 'Home', 79, AppColors.green),
    TopicRow('✈️', 'Future', 68, AppColors.barMaroon),
    TopicRow('⚡', 'Conflict', 52, AppColors.amber),
    TopicRow('🕊️', 'Separation', 44, AppColors.amber),
    TopicRow('💋', 'Intimacy', 71, AppColors.barMaroon),
    TopicRow('💼', 'Career', 58, AppColors.amber),
    TopicRow('👫', 'Friends', 63, AppColors.barMaroon),
    TopicRow('🏃', 'Health', 55, AppColors.amber),
    TopicRow('👨‍👩‍👧', 'Family', 48, AppColors.amber),
  ];

  final List<TopicRow> alignment = const [
    TopicRow('💗', 'Fidelity', 82, AppColors.green),
    TopicRow('💋', 'Intimacy', 79, AppColors.green),
    TopicRow('🏠', 'Home', 74, AppColors.green),
    TopicRow('💰', 'Money', 71, AppColors.green),
    TopicRow('👫', 'Friends', 68, AppColors.barMaroon),
    TopicRow('🏃', 'Health', 65, AppColors.barMaroon),
    TopicRow('👶', 'Children', 59, AppColors.amber),
    TopicRow('💼', 'Career', 56, AppColors.amber),
    TopicRow('✈️', 'Future', 54, AppColors.amber),
    TopicRow('⚡', 'Conflict', 48, AppColors.amber),
    TopicRow('👨‍👩‍👧', 'Family', 46, AppColors.amber),
    TopicRow('🕊️', 'Separation', 41, AppColors.amber),
  ];
}
