import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app_router.dart';

class SetNewPasswordController extends GetxController {
  final newPass = TextEditingController();
  final confirmPass = TextEditingController();
  final RxBool obscureNew = true.obs;
  final RxBool obscureConfirm = true.obs;

  void toggleNew() => obscureNew.value = !obscureNew.value;
  void toggleConfirm() => obscureConfirm.value = !obscureConfirm.value;

  void onReset() {
    if (newPass.text.isEmpty || confirmPass.text.isEmpty) {
      Get.snackbar('Missing info', 'Please fill in both fields.');
      return;
    }
    if (newPass.text != confirmPass.text) {
      Get.snackbar('Mismatch', 'Passwords do not match.');
      return;
    }
    // TODO: submit the new password to your API.
    appRouter.go(AppRoutes.resetSuccess);
  }

  @override
  void onClose() {
    newPass.dispose();
    confirmPass.dispose();
    super.onClose();
  }
}
