import 'package:flutter/material.dart';
import '../app_colors.dart';
import 'text/app_text.dart';

/// A labelled horizontal progress row: [label] [======bar======] [value].
/// Reused by Engagement, Topics & Pacts, Session Time, Subscriptions, etc.
class MetricBar extends StatelessWidget {
  final String label;
  final String? emoji;
  final double fraction; // 0..1
  final Color fillColor;
  final String trailing;
  final double labelWidth;
  final double trailingWidth;

  const MetricBar({
    super.key,
    required this.label,
    this.emoji,
    required this.fraction,
    required this.fillColor,
    required this.trailing,
    this.labelWidth = 150,
    this.trailingWidth = 60,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          SizedBox(
            width: labelWidth,
            child: Row(
              children: [
                if (emoji != null) ...[
                  Text(emoji!, style: const TextStyle(fontSize: 18)),
                  const SizedBox(width: 10),
                ],
                Expanded(
                  child: AppText(
                    data: label,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textPrimary,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: LinearProgressIndicator(
                value: fraction.clamp(0.0, 1.0),
                minHeight: 10,
                backgroundColor: AppColors.track,
                valueColor: AlwaysStoppedAnimation<Color>(fillColor),
              ),
            ),
          ),
          const SizedBox(width: 16),
          SizedBox(
            width: trailingWidth,
            child: AppText(
              data: trailing,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
