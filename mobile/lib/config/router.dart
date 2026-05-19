import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../domain/providers/auth_provider.dart';
import '../presentation/screens/auth/login_screen.dart';
import '../presentation/screens/auth/register_screen.dart';
import '../presentation/screens/auth/forgot_password_screen.dart';
import '../presentation/screens/dashboard/dashboard_screen.dart';
import '../presentation/screens/glucose/glucose_analytics_screen.dart';
import '../presentation/screens/meals/meals_screen.dart';
import '../presentation/screens/meals/add_meal_screen.dart';
import '../presentation/screens/bolus/bolus_screen.dart';
import '../presentation/screens/bolus/add_bolus_screen.dart';
import '../presentation/screens/alerts/alerts_screen.dart';
import '../presentation/screens/profile/profile_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateProvider);

  return GoRouter(
    initialLocation: '/',
    redirect: (context, state) {
      final isLoggedIn = authState.valueOrNull != null;
      final isAuthRoute = state.matchedLocation.startsWith('/auth');

      if (!isLoggedIn && !isAuthRoute) {
        return '/auth/login';
      }
      if (isLoggedIn && isAuthRoute) {
        return '/';
      }
      return null;
    },
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const DashboardScreen(),
      ),
      GoRoute(
        path: '/auth/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/auth/register',
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: '/auth/forgot-password',
        builder: (context, state) => const ForgotPasswordScreen(),
      ),
      GoRoute(
        path: '/glucose',
        builder: (context, state) => const GlucoseAnalyticsScreen(),
      ),
      GoRoute(
        path: '/meals',
        builder: (context, state) => const MealsScreen(),
      ),
      GoRoute(
        path: '/meals/add',
        builder: (context, state) => const AddMealScreen(),
      ),
      GoRoute(
        path: '/bolus',
        builder: (context, state) => const BolusScreen(),
      ),
      GoRoute(
        path: '/bolus/add',
        builder: (context, state) => const AddBolusScreen(),
      ),
      GoRoute(
        path: '/alerts',
        builder: (context, state) => const AlertsScreen(),
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) => const ProfileScreen(),
      ),
    ],
  );
});
