import 'package:flutter/material.dart';

import '../../../app_router.dart';
import '../../../core/widgets/buttons/app_button.dart';
import '../shared_widgets/auth_shared_widgets.dart';

class PasswordUpdatedScreen extends StatelessWidget {
  const PasswordUpdatedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      title: 'Password Updated Successfully!',
      subtitle: 'Your new password has been saved. You can now continue securely.',
      centerSubtitle: true,
      children: [
        AppButton(
          buttonText: 'Sign in',
          onPressed: () => appRouter.go(AppRoutes.login),
          buttonHeight: 56,
        ),
      ],
    );
  }
}
