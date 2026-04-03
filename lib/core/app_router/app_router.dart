import 'package:bl_staff/bl_staff.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
/// | Path           | Screen          | Description                        |
/// |----------------|-----------------|------------------------------------|
/// | `/`            | SplashScreen    | Initial loading screen             |
/// | `/welcome`     | WelcomeScreen   | Landing screen                     |
/// | `/auth/login`  | LoginScreen     | Login form                         |
/// | `/home`        | HomeScreen      | Home screen                        |
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

      final isLoggedIn = sessionState.maybeWhen(
        authenticated: (_, _) => true,
        orElse: () => false,
      );

      final isFirstTime = sessionState.maybeWhen(
        firstTime: () => true,
        orElse: () => false,
      );

      final isOnSplash = state.matchedLocation == RouteNames.splash;
      final isOnWelcome = state.matchedLocation == RouteNames.welcome;
      final isOnLogin = state.matchedLocation == RouteNames.authLogin;

      if (isFirstTime && !isOnWelcome) return RouteNames.welcome;
      if (!isLoggedIn && !isOnLogin && !isOnSplash && !isOnWelcome) {
        return RouteNames.authLogin;
      }
      if (isLoggedIn && (isOnLogin || isOnWelcome)) return RouteNames.home;

      return null;
    },

    routes: [
      GoRoute(
        path: RouteNames.splash,
        builder: (context, state) =>
            Scaffold(body: Center(child: Text("Splash Screen"))),
      ),
      GoRoute(
        path: RouteNames.welcome,
        builder: (context, state) =>
            Scaffold(body: Center(child: Text("Welcome Screen"))),
      ),
      GoRoute(
        path: RouteNames.authLogin,
        builder: (context, state) => AuthScreen(),
      ),
      GoRoute(
        path: RouteNames.home,
        builder: (context, state) =>
            Scaffold(body: Center(child: Text("Home Screen"))),
      ),
    ],
  );
}
