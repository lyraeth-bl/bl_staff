import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/features.dart';
import 'go_router_refresh_stream.dart';
import 'route_names.dart';

/// {@template app_router}
/// The central navigation controller for the application.
///
/// [AppRouter] defines all routes and navigation behavior using [GoRouter].
/// All route paths are referenced from [RouteNames] to ensure consistency
/// and avoid hardcoded strings throughout the codebase.
///
/// ---
///
/// ## Route Map
///
/// | Path           | Screen           | Description                        |
/// |----------------|------------------|------------------------------------|
/// | `/`            | SplashScreen     | Initial loading screen             |
/// | `/welcome`     | WelcomeScreen    | Landing screen                     |
/// | `/auth/login`  | LoginScreen      | Login form                         |
/// | `/dashboard`   | DashboardScreen  | Dashboard screen                   |
/// | `/attendance`  | AttendanceScreen | Attendance screen                  |
/// | `/profile`     | ProfileScreen    | Profile screen                     |
///
/// ---
///
/// ## Setup
///
/// Register as a singleton via GetIt in your dependency injection setup:
///
/// ```dart
/// getIt.registerLazySingleton(() => AppRouter());
/// ```
///
/// Then pass the [goRouter] instance to [MaterialApp.router]:
///
/// ```dart
/// MaterialApp.router(
///   routerConfig: getIt<AppRouter>().goRouter,
/// )
/// ```
///
/// ---
///
/// ## Navigation
///
/// Use [GoRouter]'s context extensions anywhere in the widget tree:
///
/// ```dart
/// // Replace current route (no back button)
/// context.go(RouteNames.welcome);
///
/// // Push on top of current route (back button visible)
/// context.push(RouteNames.authLogin);
///
/// // Go back
/// context.pop();
/// ```
///
/// ## Adding New Routes
///
/// 1. Add the path constant to [RouteNames].
/// 2. Create the corresponding screen widget under its feature folder.
/// 3. Add a new [GoRoute] entry in the [goRouter] routes list below.
/// 4. If the route requires authentication, ensure it is covered
///    by the redirect guard.
/// {@endtemplate}
class AppRouter {
  final SessionsBloc sessionsBloc;

  /// {@macro app_router}
  AppRouter(this.sessionsBloc);

  late final GoRouter goRouter = GoRouter(
    initialLocation: RouteNames.splash,

    // Refresh router setiap kali sessions state berubah.
    refreshListenable: GoRouterRefreshStream(sessionsBloc.stream),

    redirect: (context, state) {
      final sessionState = sessionsBloc.state;

      final isReady = sessionState.maybeWhen(
        authenticated: (_) => true,
        unauthenticated: () => true,
        orElse: () => false,
      );

      if (!isReady) return null;

      final isLoggedIn = sessionState.maybeWhen(
        authenticated: (_) => true,
        orElse: () => false,
      );

      final isOnSplash = state.matchedLocation == RouteNames.splash;
      final isOnWelcome = state.matchedLocation == RouteNames.welcome;
      final isOnLogin = state.matchedLocation == RouteNames.authLogin;

      // Biarkan splash handle navigasi awal
      if (isOnSplash) return null;

      // Belum login → paksa ke login
      if (!isLoggedIn && !isOnLogin && !isOnWelcome) {
        return RouteNames.authLogin;
      }

      // Sudah login tapi masih di login/welcome → ke dashboard
      if (isLoggedIn && (isOnLogin || isOnWelcome)) return RouteNames.dashboard;

      return null;
    },

    routes: [
      GoRoute(
        path: RouteNames.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: RouteNames.welcome,
        builder: (context, state) => const WelcomeScreen(),
      ),
      GoRoute(
        path: RouteNames.authLogin,
        builder: (context, state) => const AuthScreen(),
      ),

      ShellRoute(
        builder: (context, state, child) => MainShell(child: child),
        routes: [
          GoRoute(
            path: RouteNames.dashboard,
            builder: (context, state) => const DashboardScreen(),
          ),
          GoRoute(
            path: RouteNames.attendance,
            builder: (context, state) => const AttendanceScreen(),
          ),
          GoRoute(
            path: RouteNames.profile,
            builder: (context, state) => const ProfileScreen(),
          ),
        ],
      ),
    ],
  );
}
