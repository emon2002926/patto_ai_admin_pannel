import 'package:flutter/material.dart';
import '../app_colors.dart';
import 'text/app_text.dart';

/// Small rounded pill used for plan / pact / status columns across tables.
class StatusBadge extends StatelessWidget {
  final String text;
  final Color bg;
  final Color fg;
  const StatusBadge({
    super.key,
    required this.text,
    required this.bg,
    required this.fg,
  });

  factory StatusBadge.plan(String plan) {
    switch (plan.toLowerCase()) {
      case 'annual':
        return StatusBadge(
            text: plan, bg: AppColors.greenBg, fg: AppColors.greenText);
      case 'free':
        return StatusBadge(
            text: plan, bg: AppColors.neutralBg, fg: AppColors.neutralText);
      default:
        return StatusBadge(
            text: plan, bg: AppColors.planPinkBg, fg: AppColors.planPinkText);
    }
  }

  factory StatusBadge.pact(String pact) {
    switch (pact.toLowerCase()) {
      case 'live':
        return StatusBadge(
            text: pact, bg: AppColors.greenBg, fg: AppColors.greenText);
      case 'in progress':
        return StatusBadge(
            text: pact, bg: AppColors.amberBg, fg: AppColors.amberText);
      default:
        return StatusBadge(
            text: pact, bg: AppColors.neutralBg, fg: AppColors.neutralText);
    }
  }

  factory StatusBadge.status(String status) {
    switch (status.toLowerCase()) {
      case 'active':
        return StatusBadge(
            text: status, bg: AppColors.greenBg, fg: AppColors.greenText);
      case 'at risk':
        return StatusBadge(
            text: status, bg: AppColors.amberBg, fg: AppColors.amberText);
      default:
        return StatusBadge(
            text: status, bg: AppColors.neutralBg, fg: AppColors.neutralText);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration:
          BoxDecoration(color: bg, borderRadius: BorderRadius.circular(20)),
      child: AppText(
          data: text, fontSize: 13, fontWeight: FontWeight.w600, color: fg),
    );
  }
}
