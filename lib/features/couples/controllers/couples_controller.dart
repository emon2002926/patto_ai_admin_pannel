import 'package:get/get.dart';

class CoupleRow {
  final String couple;
  final String plan;
  final String pact;
  final String topics;
  final String streak;
  final String joined;
  final String lastActive;
  final String mrr;
  const CoupleRow({
    required this.couple,
    required this.plan,
    required this.pact,
    required this.topics,
    required this.streak,
    required this.joined,
    required this.lastActive,
    required this.mrr,
  });
}

class CouplesController extends GetxController {
  final RxList<CoupleRow> couples = <CoupleRow>[
    const CoupleRow(couple: 'Alex & Jordan', plan: 'Monthly', pact: 'Live', topics: '4/12', streak: '13', joined: 'June 1', lastActive: 'Today', mrr: '\$12'),
    const CoupleRow(couple: 'Sara & Luca', plan: 'Annual', pact: 'Live', topics: '8/12', streak: '28', joined: 'Apr 12', lastActive: 'Yesterday', mrr: '\$9.92'),
    const CoupleRow(couple: 'Marco & Sofia', plan: 'Monthly', pact: 'Live', topics: '3/12', streak: '7', joined: 'May 20', lastActive: '2 days ago', mrr: '\$12'),
    const CoupleRow(couple: 'Emma & Tom', plan: 'Annual', pact: 'Live', topics: '12/12', streak: '90', joined: 'Jan 5', lastActive: 'Today', mrr: '\$9.92'),
    const CoupleRow(couple: 'Yuki & Kenji', plan: 'Monthly', pact: 'In progress', topics: '1/12', streak: '3', joined: 'June 10', lastActive: '3 days ago', mrr: '\$12'),
    const CoupleRow(couple: 'Priya & Arjun', plan: 'Annual', pact: 'Live', topics: '6/12', streak: '45', joined: 'Mar 3', lastActive: 'Today', mrr: '\$9.92'),
    const CoupleRow(couple: 'Chloe & Max', plan: 'Monthly', pact: 'No pact', topics: '0/12', streak: '0', joined: 'June 14', lastActive: '5 days ago', mrr: '\$12'),
  ].obs;
}
