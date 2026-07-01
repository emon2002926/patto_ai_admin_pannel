import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app_router.dart';

class CheckEmailController extends GetxController {
  final List<TextEditingController> digits =
      List.generate(5, (_) => TextEditingController());
  final List<FocusNode> nodes = List.generate(5, (_) => FocusNode());

  String get code => digits.map((d) => d.text).join();

  void onDigitChanged(int index, String value) {
    if (value.isNotEmpty && index < nodes.length - 1) {
      nodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      nodes[index - 1].requestFocus();
    }
  }

  void onVerify() {
    // TODO: verify [code] with your API.
    appRouter.go(AppRoutes.resetPassword);
  }

  void onResend() {
    Get.snackbar('Sent', 'A new code is on its way.');
  }

  @override
  void onClose() {
    for (final d in digits) {
      d.dispose();
    }
    for (final n in nodes) {
      n.dispose();
    }
    super.onClose();
  }
}
