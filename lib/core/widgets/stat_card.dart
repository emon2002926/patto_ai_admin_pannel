import 'package:flutter/material.dart';
import '../app_colors.dart';
import 'text/app_text.dart';

/// The metric cards that sit 4-across at the top of most dashboards.
class StatCard extends StatelessWidget {
  final String label;
  final String value;
  final String? valueEmoji;
  final String? deltaText;
  final Color? deltaColor;
  final bool deltaUp;
  final String? secondaryText;

  const StatCard({
    super.key,
    required this.label,
    required this.value,
    this.valueEmoji,
    this.deltaText,
    this.deltaColor,
    this.deltaUp = true,
    this.secondaryText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x12000000),
            blurRadius: 16,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            data: label.toUpperCase(),
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: AppColors.textMuted,
            letterSpacing: 0.6,
          ),
          const SizedBox(height: 14),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              AppText(
                data: value,
                fontSize: 40,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
              if (valueEmoji != null) ...[
                const SizedBox(width: 8),
                Text(valueEmoji!, style: const TextStyle(fontSize: 24)),
              ],
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              if (deltaText != null)
                Row(
                  children: [
                    Icon(
                      deltaUp ? Icons.arrow_upward : Icons.arrow_downward,
                      size: 15,
                      color: deltaColor ?? AppColors.greenText,
                    ),
                    const SizedBox(width: 4),
                    AppText(
                      data: deltaText!,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: deltaColor ?? AppColors.greenText,
                    ),
                  ],
                ),
              if (deltaText != null && secondaryText != null)
                const SizedBox(width: 12),
              if (secondaryText != null)
                Expanded(
                  child: AppText(
                    data: secondaryText!,
                    fontSize: 14,
                    color: AppColors.textMuted,
                    maxLines: 2,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Lays the stat cards out responsively (4 / 2 / 1 across).
class StatCardRow extends StatelessWidget {
  final List<StatCard> cards;
  const StatCardRow({super.key, required this.cards});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, c) {
        final w = c.maxWidth;
        final perRow = w >= 1100
            ? 4
            : w >= 720
                ? 2
                : 1;
        const spacing = 20.0;
        final cardW = (w - spacing * (perRow - 1)) / perRow;
        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: [
            for (final card in cards) SizedBox(width: cardW, child: card),
          ],
        );
      },
    );
  }
}
