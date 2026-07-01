import 'package:flutter/material.dart';

import 'edit_administrator_dialog.dart';

class NewAdministratorDialog extends StatelessWidget {
  const NewAdministratorDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return const AdministratorFormDialog(
      title: 'Add user',
      subtitle: 'The new user will receive an email invitation to set up their account.',
      submitLabel: 'Create',
    );
  }
}
