part of 'auth_bloc.dart';

/// Represents the various states of the authentication process.
///
/// This state is used by [AuthBloc] to communicate the current status of
/// authentication tasks to the UI.
@freezed
abstract class AuthState with _$AuthState {
  /// The initial state before any authentication action has been taken.
  const factory AuthState.initial() = _Initial;

  /// Indicates that an authentication operation is currently in progress.
  const factory AuthState.loading() = _Loading;

  /// Indicates a successful login.
  const factory AuthState.successLogin({
    /// The access token returned by the server.
    required String accessToken,

    /// The timestamp when the access token expires.
    required DateTime expiresAt,
  }) = _SuccessLogin;

  /// Indicates a successful logout.
  const factory AuthState.successLogout() = _SuccessLogout;

  /// Indicates that an authentication operation failed.
  const factory AuthState.failure(
    /// The failure details.
    Failure failure,
  ) = _Failure;
}
