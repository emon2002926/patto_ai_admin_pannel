import 'package:flutter/material.dart';

import '../../../core/app_colors.dart';
import '../../../core/widgets/patto_wordmark.dart';
import '../../../core/widgets/text/app_text.dart';

/// Common centered layout for every auth screen: white background, wordmark,
/// title, optional subtitle, then the screen's own fields/buttons.
class AuthScaffold extends StatelessWidget {
  final String title;
  final String? subtitle;
  final bool centerSubtitle;
  final List<Widget> children;

  const AuthScaffold({
    super.key,
    required this.title,
    this.subtitle,
    this.centerSubtitle = false,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 460),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Center(child: PattoWordmark(fontSize: 60, color: AppColors.wordmark)),
                const SizedBox(height: 56),
                Center(
                  child: AppText(
                    data: title,
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    textAlign: TextAlign.center,
                  ),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 14),
                  Center(
                    child: AppText(
                      data: subtitle!,
                      fontSize: 16,
                      color: AppColors.textSecondary,
                      textAlign: centerSubtitle ? TextAlign.center : TextAlign.start,
                    ),
                  ),
                ],
                const SizedBox(height: 44),
                ...children,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Left-aligned field label used above auth text fields.
class AuthFieldLabel extends StatelessWidget {
  final String text;
  const AuthFieldLabel(this.text, {super.key});

  @override
  Widget build(BuildContext context) => AppText(data: text, fontSize: 15);
}
