part of 'auth_bloc.dart';

/// Events that trigger changes in the [AuthBloc] state.
///
/// These events represent user actions or system triggers related to authentication.
@freezed
class AuthEvent with _$AuthEvent {
  /// Initial event to start the authentication logic.
  const factory AuthEvent.started() = _Started;

  /// Triggered when a user attempts to log in.
  const factory AuthEvent.loginRequested({
    /// The parameters required to perform the login.
    required LoginParams loginParams,
  }) = _LoginRequested;

  /// Triggered when a user attempts to log out.
  const factory AuthEvent.logoutRequested() = _LogoutRequested;
}
