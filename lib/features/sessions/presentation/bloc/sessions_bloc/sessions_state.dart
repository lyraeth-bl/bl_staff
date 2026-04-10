part of 'sessions_bloc.dart';

/// Represents the authentication state of the current user session.
///
/// States are emitted by [SessionsBloc] in response to [SessionsEvent]s.
/// UI layers should listen to this state to determine whether to show
/// the authenticated or unauthenticated navigation stack.
@freezed
abstract class SessionsState with _$SessionsState {
  /// The session has not yet been checked.
  ///
  /// This is the state before [SessionsEvent.started] is processed.
  /// The UI should show a splash or loading screen until this resolves.
  const factory SessionsState.initial() = _Initial;

  /// A session operation is in progress.
  ///
  /// Emitted while the BLoC is reading or writing token data.
  const factory SessionsState.loading() = _Loading;

  /// The user has an active, valid session.
  const factory SessionsState.authenticated({
    /// The access token for the current session, used to authorize API requests.
    required String accessToken,
  }) = _Authenticated;

  /// No valid session exists; the user must log in.
  const factory SessionsState.unauthenticated() = _Unauthenticated;
}
