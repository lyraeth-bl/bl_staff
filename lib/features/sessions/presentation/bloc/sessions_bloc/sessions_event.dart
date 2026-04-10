part of 'sessions_bloc.dart';

/// The set of events that [SessionsBloc] can process.
///
/// Each event represents a distinct user action or system trigger
/// that may cause a session state transition.
@freezed
abstract class SessionsEvent with _$SessionsEvent {
  /// Triggers session restoration on app startup.
  ///
  /// [SessionsBloc] responds by reading the stored token and emitting
  /// either [SessionsState.authenticated] or [SessionsState.unauthenticated].
  const factory SessionsEvent.started() = _Started;

  /// Signals a successful login with the given [token].
  ///
  /// [SessionsBloc] responds by persisting [token] to local storage,
  /// updating [TokenProvider], and emitting [SessionsState.authenticated].
  const factory SessionsEvent.loggedIn({
    /// The access token received from the authentication server.
    required String token,
  }) = _LoggedIn;

  /// Signals a logout request.
  ///
  /// [SessionsBloc] responds by clearing the stored token, resetting
  /// [TokenProvider], and emitting [SessionsState.unauthenticated].
  const factory SessionsEvent.loggedOut() = _LoggedOut;
}
