import 'package:get/get.dart';

class TicketRow {
  final int id;
  final String title;
  final String name;
  final String category;
  final String time;
  final String status; // Open / Pending / Resolved
  final String quote;
  const TicketRow({
    required this.id,
    required this.title,
    required this.name,
    required this.category,
    required this.time,
    required this.status,
    required this.quote,
  });
}

class SupportController extends GetxController {
  final RxString filter = 'All'.obs; // All / Open / Resolved

  final RxList<TicketRow> tickets = <TicketRow>[
    const TicketRow(id: 1042, title: 'Subscription billing issue', name: 'Chloe Martin', category: 'Subscription', time: '2h ago', status: 'Open', quote: 'I was charged twice this month. First on May 31, again June 1. Please refund the…'),
    const TicketRow(id: 1041, title: 'Partner invite link not working', name: 'Marco Rossi', category: 'Partner invite', time: '4h ago', status: 'Open', quote: 'I sent the invite link to my partner but they get a 404 error when clicking it. …'),
    const TicketRow(id: 1040, title: 'Analysis not loading after both completed topic', name: 'Yuki Tanaka', category: 'Bug', time: '1h ago', status: 'Open', quote: 'We both finished the Fidelity topic but the analysis screen is stuck loading. Tr…'),
    const TicketRow(id: 1039, title: 'How do I export my data?', name: 'Nina Kovacs', category: 'Privacy & data', time: '30m ago', status: 'Open', quote: 'I would like to get a copy of all my data as per GDPR. How do I request this?…'),
    const TicketRow(id: 1038, title: 'Coach not responding after 10 minutes', name: 'Emma Davis', category: 'Bug', time: '1d ago', status: 'Pending', quote: 'The AI coach started loading but never responded. Waited 10 minutes.…'),
  ].obs;

  List<TicketRow> get visible {
    switch (filter.value) {
      case 'Open':
        return tickets.where((t) => t.status == 'Open').toList();
      case 'Resolved':
        return tickets.where((t) => t.status == 'Resolved').toList();
      default:
        return tickets.toList();
    }
  }

  int get openCount => tickets.where((t) => t.status == 'Open').length;
  int get pendingCount => tickets.where((t) => t.status == 'Pending').length;
  int get resolvedTodayCount => 3;

  void setFilter(String f) => filter.value = f;
  void reply(TicketRow t) => Get.snackbar('Reply', 'Replying to #${t.id}');
  void resolve(TicketRow t) => Get.snackbar('Resolved', 'Ticket #${t.id} resolved');
}
