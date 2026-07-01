import 'package:get/get.dart';

class AlertItem {
  final String emoji;
  final String text;
  final bool warning; // true = amber, false = green/ok
  const AlertItem(this.emoji, this.text, {this.warning = true});
}

class OverviewController extends GetxController {
  // New couples — last 8 weeks
  final List<double> newCouples = const [18, 24, 20, 31, 28, 35, 29, 38];
  final List<String> weekLabels = const ['7', '14', '21', '28', '5', '12', '19', '26'];

  // Plan split
  final int monthlyPct = 62;
  final int annualPct = 38;
  final int monthlyCount = 176;
  final int annualCount = 108;

  final RxList<AlertItem> alerts = <AlertItem>[
    const AlertItem('⏰', '4 open support tickets — oldest 4h'),
    const AlertItem('🗎', '2 GDPR data export requests pending'),
    const AlertItem('✓', 'All API services operational · p99 420ms', warning: false),
  ].obs;

  // Engagement health
  final List<(String, int)> engagementHealth = const [
    ('Daily Q answered', 71),
    ('Pact confirmed', 58),
    ('Challenge completed', 49),
  ];
}
