import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app_router.dart';

class LoginController extends GetxController {
  final emailCtrl = TextEditingController(text: 'esteban_schiller@gmail.com');
  final passCtrl = TextEditingController();
  final RxBool obscurePass = true.obs;
  final RxBool rememberMe = true.obs;

  void toggleObscure() => obscurePass.value = !obscurePass.value;
  void toggleRemember() => rememberMe.value = !rememberMe.value;

  void onSignIn() {
    // TODO: authenticate against your API, then route in.
    appRouter.go(AppRoutes.overview);
  }

  void goForgotPassword() => appRouter.go(AppRoutes.forgotPassword);

  @override
  void onClose() {
    emailCtrl.dispose();
    passCtrl.dispose();
    super.onClose();
  }
}
