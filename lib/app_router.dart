import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import 'admin_shell.dart';
import 'features/auth/views/login_screen.dart';
import 'features/auth/views/forget_password_screen.dart';
import 'features/auth/views/check_email_screen.dart';
import 'features/auth/views/set_new_password_screen.dart';
import 'features/auth/views/password_updated_screen.dart';
import 'features/overview/views/overview_screen.dart';
import 'features/couples/views/couples_screen.dart';
import 'features/administrator/views/administrators_screen.dart';
import 'features/subscriptions/views/subscriptions_screen.dart';
import 'features/referrals/views/referrals_screen.dart';
import 'features/engagement/views/engagement_screen.dart';
import 'features/session_time/views/session_time_screen.dart';
import 'features/topics_pacts/views/topics_pacts_screen.dart';
import 'features/ai_api_costs/views/ai_api_costs_screen.dart';
import 'features/support/views/support_screen.dart';
import 'features/gdpr_data/views/gdpr_data_screen.dart';

class AppRoutes {
  static const login = '/login';
  static const forgotPassword = '/forgot-password';
  static const verify = '/verify';
  static const resetPassword = '/reset-password';
  static const resetSuccess = '/reset-success';

  static const overview = '/overview';
  static const couples = '/couples';
  static const users = '/users';
  static const subscriptions = '/subscriptions';
  static const referrals = '/referrals';
  static const engagement = '/engagement';
  static const sessionTime = '/session-time';
  static const topicsPacts = '/topics-pacts';
  static const aiApiCosts = '/ai-api-costs';
  static const support = '/support';
  static const gdprData = '/gdpr-data';
}

final GoRouter appRouter = GoRouter(
  // Share GetX's navigator so Get.dialog / Get.back / Get.snackbar work.
  navigatorKey: Get.key,
  initialLocation: AppRoutes.login,
  routes: [
    GoRoute(
        path: AppRoutes.login, builder: (context, state) => const LoginScreen()),
    GoRoute(
        path: AppRoutes.forgotPassword,
        builder: (context, state) => const ForgetPasswordScreen()),
    GoRoute(
        path: AppRoutes.verify,
        builder: (context, state) => const CheckEmailScreen()),
    GoRoute(
        path: AppRoutes.resetPassword,
        builder: (context, state) => const SetNewPasswordScreen()),
    GoRoute(
        path: AppRoutes.resetSuccess,
        builder: (context, state) => const PasswordUpdatedScreen()),

    // Persistent shell: sidebar stays, each branch is its own URL + state.
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          AdminShell(navigationShell: navigationShell),
      branches: [
        StatefulShellBranch(routes: [
          GoRoute(
              path: AppRoutes.overview,
              builder: (context, state) => const OverviewScreen()),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(
              path: AppRoutes.couples,
              builder: (context, state) => const CouplesScreen()),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(
              path: AppRoutes.users,
              builder: (context, state) => const AdministratorsScreen()),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(
              path: AppRoutes.subscriptions,
              builder: (context, state) => const SubscriptionsScreen()),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(
              path: AppRoutes.referrals,
              builder: (context, state) => const ReferralsScreen()),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(
              path: AppRoutes.engagement,
              builder: (context, state) => const EngagementScreen()),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(
              path: AppRoutes.sessionTime,
              builder: (context, state) => const SessionTimeScreen()),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(
              path: AppRoutes.topicsPacts,
              builder: (context, state) => const TopicsPactsScreen()),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(
              path: AppRoutes.aiApiCosts,
              builder: (context, state) => const AiApiCostsScreen()),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(
              path: AppRoutes.support,
              builder: (context, state) => const SupportScreen()),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(
              path: AppRoutes.gdprData,
              builder: (context, state) => const GdprDataScreen()),
        ]),
      ],
    ),
  ],
);
