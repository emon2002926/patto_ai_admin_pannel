import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../app_router.dart';
import '../views/profile_menu.dart';
import '../views/account_setting_dialog.dart';
import '../views/password_change_dialog.dart';

class ProfileController extends GetxController {
  // ---- Current signed-in admin (replace with real data later) ----
  final RxString name = 'Roberto Massa'.obs;
  final RxString email = 'roberto@patto.app'.obs;
  final RxString phone = '+39 340 555 0192'.obs;
  final RxString role = 'Super Admin'.obs;
  final RxString avatarUrl = ''.obs; // network photo; empty -> initials

  final List<String> roles = const [
    'Super Admin',
    'Admin',
    'Support',
    'Analyst',
  ];

  // ---- Account Setting form ----
  final accName = TextEditingController();
  final accEmail = TextEditingController();
  final accPhone = TextEditingController();
  final RxString accRole = 'Admin'.obs;
  final RxString accImageName = ''.obs;

  // ---- Password Change form ----
  final oldPass = TextEditingController();
  final newPass = TextEditingController();
  final retypePass = TextEditingController();
  final RxBool obscureOld = true.obs;
  final RxBool obscureNew = true.obs;
  final RxBool obscureRetype = true.obs;

  String get initials {
    final parts =
        name.value.trim().split(RegExp(r'\s+')).where((p) => p.isNotEmpty);
    if (parts.isEmpty) return '';
    if (parts.length == 1) return parts.first.characters.first.toUpperCase();
    return (parts.first.characters.first + parts.elementAt(1).characters.first)
        .toUpperCase();
  }

  void openMenu() {
    Get.dialog(const ProfileMenu(), barrierColor: const Color(0x22000000));
  }

  void openAccountSetting() {
    Get.back(); // close the menu first
    accName.text = name.value;
    accEmail.text = email.value;
    accPhone.text = phone.value;
    accRole.value = roles.contains(role.value) ? role.value : 'Admin';
    accImageName.value = '';
    Get.dialog(const AccountSettingDialog());
  }

  void openPasswordChange() {
    Get.back();
    oldPass.clear();
    newPass.clear();
    retypePass.clear();
    obscureOld.value = true;
    obscureNew.value = true;
    obscureRetype.value = true;
    Get.dialog(const PasswordChangeDialog());
  }

  Future<void> pickImage() async {
    try {
      final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (picked != null) accImageName.value = picked.name;
    } catch (_) {
      // ignore picker errors / cancellation
    }
  }

  void saveAccount() {
    // TODO: send to your API.
    name.value = accName.text.trim();
    email.value = accEmail.text.trim();
    phone.value = accPhone.text.trim();
    role.value = accRole.value;
    Get.back();
    Get.snackbar('Saved', 'Account settings updated.');
  }

  void updatePassword() {
    if (oldPass.text.isEmpty ||
        newPass.text.isEmpty ||
        retypePass.text.isEmpty) {
      Get.snackbar('Missing info', 'Please fill in all password fields.');
      return;
    }
    if (newPass.text != retypePass.text) {
      Get.snackbar('Mismatch', 'New passwords do not match.');
      return;
    }
    // TODO: send to your API.
    Get.back();
    Get.snackbar('Updated', 'Your password has been changed.');
  }

  void logout() {
    Get.back();
    // TODO: clear your auth/session here.
    appRouter.go(AppRoutes.login);
  }

  void toggleOld() => obscureOld.value = !obscureOld.value;
  void toggleNew() => obscureNew.value = !obscureNew.value;
  void toggleRetype() => obscureRetype.value = !obscureRetype.value;

  @override
  void onClose() {
    accName.dispose();
    accEmail.dispose();
    accPhone.dispose();
    oldPass.dispose();
    newPass.dispose();
    retypePass.dispose();
    super.onClose();
  }
}
