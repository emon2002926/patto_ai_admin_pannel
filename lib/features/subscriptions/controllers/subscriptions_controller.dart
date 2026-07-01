import 'package:get/get.dart';

class TransactionRow {
  final String couple;
  final String amount;
  final String plan;
  final String date;
  final String status;
  const TransactionRow(this.couple, this.amount, this.plan, this.date, this.status);
}

class SubscriptionsController extends GetxController {
  final RxList<TransactionRow> transactions = <TransactionRow>[
    const TransactionRow('Alex & Jordan', '\$12', 'Monthly', 'June 1', 'Paid'),
    const TransactionRow('Alex & Jordan', '\$12', 'Monthly', 'June 1', 'Paid'),
    const TransactionRow('Alex & Jordan', '\$12', 'Monthly', 'June 1', 'Paid'),
    const TransactionRow('Alex & Jordan', '\$12', 'Monthly', 'June 1', 'Paid'),
  ].obs;

  final List<(String, int)> cancellationReasons = const [
    ('Price too high', 37),
    ('Partner inactive', 31),
    ('Relationship ended', 19),
    ('Other', 13),
  ];
}
