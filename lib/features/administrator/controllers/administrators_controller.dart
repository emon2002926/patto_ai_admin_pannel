import 'package:get/get.dart';

import '../widgets/edit_administrator_dialog.dart';
import '../widgets/new_administrator_dialog.dart';
import '../widgets/confirm_remove_access_dialog.dart';

class AdministratorRow {
  final String name;
  final String role; // P1 / P2
  final String email;
  final String language;
  final String plan;
  final String joined;
  final String lastActive;
  final String status; // Active / At risk
  const AdministratorRow({
    required this.name,
    required this.role,
    required this.email,
    required this.language,
    required this.plan,
    required this.joined,
    required this.lastActive,
    required this.status,
  });
}

class AdministratorsController extends GetxController {
  final RxList<AdministratorRow> administrators = <AdministratorRow>[
    const AdministratorRow(name: 'Alex Chen', role: 'P1', email: 'alex@email.com', language: 'English', plan: 'Monthly', joined: 'June 1', lastActive: 'Today', status: 'Active'),
    const AdministratorRow(name: 'Jordan Lee', role: 'P2', email: 'jordan@email.com', language: 'English', plan: 'Free', joined: 'June 1', lastActive: 'Today', status: 'Active'),
    const AdministratorRow(name: 'Sara Rossi', role: 'P1', email: 'sara@email.com', language: 'Italian', plan: 'Annual', joined: 'Apr 12', lastActive: 'Yesterday', status: 'Active'),
    const AdministratorRow(name: 'Luca Bianchi', role: 'P2', email: 'luca@email.com', language: 'Italian', plan: 'Free', joined: 'Apr 12', lastActive: '2 days ago', status: 'Active'),
    const AdministratorRow(name: 'Yuki Tanaka', role: 'P1', email: 'yuki@email.com', language: 'Japanese', plan: 'Monthly', joined: 'June 10', lastActive: '3 days ago', status: 'Active'),
    const AdministratorRow(name: 'Emma Davis', role: 'P1', email: 'emma@email.com', language: 'English', plan: 'Annual', joined: 'Jan 5', lastActive: 'Today', status: 'Active'),
    const AdministratorRow(name: 'Chloe Martin', role: 'P1', email: 'chloe@email.com', language: 'French', plan: 'Monthly', joined: 'June 14', lastActive: '5 days ago', status: 'At risk'),
    const AdministratorRow(name: 'Priya Sharma', role: 'P1', email: 'priya@email.com', language: 'Hindi', plan: 'Annual', joined: 'Mar 3', lastActive: 'Today', status: 'Active'),
  ].obs;

  void openAdd() => Get.dialog(const NewAdministratorDialog());

  void openEdit(AdministratorRow admin) =>
      Get.dialog(EditAdministratorDialog(admin: admin));

  void confirmRemove(AdministratorRow admin) =>
      Get.dialog(ConfirmRemoveAccessDialog(admin: admin));

  void removeAdministrator(AdministratorRow admin) {
    administrators.remove(admin);
    Get.back();
    Get.snackbar('Removed', '${admin.name} no longer has access.');
  }
}
