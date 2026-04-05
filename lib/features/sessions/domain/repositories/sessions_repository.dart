import 'package:fpdart/fpdart.dart';

/// The contract for session data operations in the domain layer.
///
/// Defines how the application reads, writes, and invalidates the user's
/// access token. Implementations live in the data layer and are injected
/// via dependency injection, keeping the domain layer free of storage concerns.
///
/// See also:
/// * [SessionsRepositoryImpl], the concrete implementation backed by local storage.
abstract class SessionsRepository {
  /// Returns the currently stored access token, or `null` if no session exists.
  Future<String?> getAccessToken();

  /// Persists [value] as the active access token.
  ///
  /// Returns [Unit] on completion.
  Future<Unit> saveAccessToken(String value);

  /// Removes all session data, invalidating the current user session.
  ///
  /// Returns [Unit] on completion.
  Future<Unit> clearSession();
}
