import 'package:bl_staff/core/app_router/route_names.dart';
import 'package:bl_staff/features/auth/presentation/screen/auth_screen.dart';
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
/// | Path           | Page          | Description                        |
/// |----------------|---------------|------------------------------------|
/// | `/`            | SplashPage    | Initial loading screen             |
/// | `/welcome`     | WelcomePage   | Landing screen                     |
/// | `/auth/login`  | LoginPage     | Login form                         |
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
/// 2. Create the corresponding page widget under its feature folder.
/// 3. Add a new [GoRoute] entry in the [goRouter] routes list below.
/// 4. If the route requires authentication, ensure it is covered
///    by the redirect guard.
/// {@endtemplate}
class AppRouter {
  /// {@macro app_router}
  AppRouter();

  late final GoRouter goRouter = GoRouter(
    initialLocation: RouteNames.authLogin,
    routes: [
      GoRoute(
        path: RouteNames.splash,
        builder: (context, state) =>
            Scaffold(body: Center(child: Text("Splash Screen"))),
      ),
      GoRoute(
        path: RouteNames.welcome,
        builder: (context, state) =>
            Scaffold(body: Center(child: Text("Splash Screen"))),
      ),
      GoRoute(
        path: RouteNames.authLogin,
        builder: (context, state) => AuthScreen(),
      ),
    ],
  );
}
