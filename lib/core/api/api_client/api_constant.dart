part of 'api_client.dart';

abstract final class ApiPath {
  // Auth
  static const login = "/auth/login";
  static const logout = "/auth/logout";

  // Profile
  static const me = "/profile/me";
  static const changeName = "/profile/name";
  static const changePassword = "/profile/password";

  // App Configuration
  static const appConfig = "/app-config";

  // Attendance
  static const checkIn = "/attendance/check-in";
  static const checkOut = "/attendance/check-out";
  static const todayAttendance = "/attendance/today";
  static const monthlyAttendance = "/attendance/monthly";
}
