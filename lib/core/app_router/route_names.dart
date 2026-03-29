/// Centralized route definitions for the application.
///
/// This class is organized by feature to improve scalability
/// and maintainability as the app grows.
///
/// Usage:
/// - context.push(RouteNames.login);
/// - context.push(RouteNames.home);
///
/// Notes:
/// - Always add new routes under the appropriate feature group.
/// - Use consistent naming to avoid duplication and confusion.
/// - Supports better readability for nested/navigation flows.
class RouteNames {
  RouteNames._();

  // Splash Route
  static const String splash = "/";

  // Welcome Route
  static const String welcome = "/welcome";

  // Auth Route
  static const String authLogin = "/auth/login";
}
