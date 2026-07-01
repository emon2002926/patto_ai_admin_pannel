import 'package:flutter/material.dart';

import '../../../core/app_colors.dart';
import '../../../core/widgets/section_card.dart';
import '../../../core/widgets/text/app_text.dart';

/// No Figma screen was provided for GDPR & Data, so this is a functional
/// placeholder that keeps the nav route working. Swap in the real layout later.
class GdprDataScreen extends StatelessWidget {
  const GdprDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(40, 8, 40, 40),
      child: SectionCard(
        padding: const EdgeInsets.all(40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(color: AppColors.amberBg, borderRadius: BorderRadius.circular(12)),
                  child: const Icon(Icons.lock_outline, color: AppColors.amberText),
                ),
                const SizedBox(width: 16),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(data: 'GDPR & Data', fontSize: 22, fontWeight: FontWeight.w700),
                      SizedBox(height: 4),
                      AppText(data: '2 data export requests pending', fontSize: 15, color: AppColors.textMuted),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const AppText(
              data: 'This section is a placeholder — no design was supplied for it. '
                  'The route, sidebar entry and badge are wired up so you can drop the '
                  'real data-request queue, export tools and consent logs in here.',
              fontSize: 15,
              color: AppColors.textSecondary,
              height: 1.5,
            ),
          ],
        ),
      ),
    );
  }
}
