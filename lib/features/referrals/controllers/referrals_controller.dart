import 'package:get/get.dart';

class ReferrerRow {
  final String user;
  final int referred;
  final int converted;
  final int freeMonths;
  const ReferrerRow(this.user, this.referred, this.converted, this.freeMonths);
}

class ReferralsController extends GetxController {
  final RxList<ReferrerRow> topReferrers = <ReferrerRow>[
    const ReferrerRow('Emma Davis', 6, 5, 5),
    const ReferrerRow('Priya Sharma', 4, 3, 3),
    const ReferrerRow('Sara Rossi', 3, 3, 3),
    const ReferrerRow('Marco Rossi', 3, 2, 2),
    const ReferrerRow('Alex Chen', 2, 2, 2),
  ].obs;
}
