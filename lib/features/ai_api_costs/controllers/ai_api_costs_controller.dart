import 'package:get/get.dart';

class CostRow {
  final String label;
  final String amount;
  final String pct;
  const CostRow(this.label, this.amount, this.pct);
}

class ScaleRow {
  final String couples;
  final String cost;
  const ScaleRow(this.couples, this.cost);
}

class AiApiCostsController extends GetxController {
  final List<CostRow> costByFeature = const [
    CostRow('Monthly AI feedback', '\$58', '31.5%'),
    CostRow('Challenge generation', '\$32', '17.4%'),
    CostRow('Analysis & insights', '\$29', '15.8%'),
    CostRow('AI Coach sessions', '\$26', '14.1%'),
    CostRow('Clause generation', '\$18', '9.8%'),
    CostRow('AI follow-up Qs', '\$14', '7.6%'),
    CostRow('Other', '\$7', '3.8%'),
  ];

  final List<String> savings = const [
    'Prompt caching active · 62% cache hit · saving ~\$41/mo',
    'Batch API on challenges + monthly feedback · saving ~\$38/mo',
  ];

  final List<ScaleRow> projected = const [
    ScaleRow('500 couples', '~\$95/mo'),
    ScaleRow('1,000 couples', '~\$185/mo'),
    ScaleRow('5,000 couples', '~\$820/mo'),
    ScaleRow('10,000 couples', '~\$1,540/mo'),
  ];
}
