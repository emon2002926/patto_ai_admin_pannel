import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app_router.dart';

class ForgetPasswordController extends GetxController {
  final emailCtrl = TextEditingController(text: 'esteban_schiller@gmail.com');

  void onContinue() {
    // TODO: request a code from your API.
    appRouter.go(AppRoutes.verify);
  }

  @override
  void onClose() {
    emailCtrl.dispose();
    super.onClose();
  }
}
