import 'package:flutter/material.dart';
import '../app_colors.dart';
import 'text/app_text.dart';

/// Lightweight bar chart (no fl_chart dependency) used on Overview and
/// Session Time. Bars are height-proportional to [values]; [topLabels] render
/// above each bar and [bottomLabels] below.
class SimpleBarChart extends StatelessWidget {
  final List<double> values;
  final List<String> topLabels;
  final List<String> bottomLabels;
  final Color barColor;
  final double height;

  const SimpleBarChart({
    super.key,
    required this.values,
    required this.topLabels,
    required this.bottomLabels,
    this.barColor = AppColors.barMaroon,
    this.height = 260,
  });

  @override
  Widget build(BuildContext context) {
    final maxV = values.isEmpty ? 1.0 : values.reduce((a, b) => a > b ? a : b);
    final barMax = height - 64;
    return SizedBox(
      height: height,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          for (int i = 0; i < values.length; i++)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (i < topLabels.length)
                      AppText(
                        data: topLabels[i],
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    const SizedBox(height: 6),
                    Center(
                      child: Container(
                        width: 34,
                        height: maxV == 0
                            ? 6
                            : (values[i] / maxV * barMax).clamp(6.0, barMax),
                        decoration: BoxDecoration(
                          color: barColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    if (i < bottomLabels.length)
                      AppText(
                        data: bottomLabels[i],
                        fontSize: 13,
                        color: AppColors.textMuted,
                      ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
