import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../core/api/token_provider/token_provider.dart';
import '../../../../../utils/shared/constant.dart';
import '../../../domain/usecases/clear_session_use_case.dart';
import '../../../domain/usecases/get_access_token_use_case.dart';
import '../../../domain/usecases/save_access_token_use_case.dart';

part 'sessions_bloc.freezed.dart';
part 'sessions_event.dart';
part 'sessions_state.dart';

/// Manages the user's authentication session across the app lifecycle.
///
/// Listens to [SessionsEvent]s and emits [SessionsState]s in response.
/// On startup, restores any existing session from local storage. On login,
/// persists the token and updates [TokenProvider] so API requests are
/// immediately authorized. On logout, clears both local storage and [TokenProvider].
///
/// This BLoC is registered as a singleton and should be provided at the root
/// of the widget tree so all features can observe session changes.
///
/// See also:
/// * [SessionsEvent], for the events this BLoC handles.
/// * [SessionsState], for the states this BLoC emits.
/// * [TokenProvider], which holds the in-memory token used by the HTTP client.
class SessionsBloc extends Bloc<SessionsEvent, SessionsState> {
  /// Creates a [SessionsBloc] with the use cases required to manage session state.
  SessionsBloc(
    this._saveAccessTokenUseCase,
    this._getAccessTokenUseCase,
    this._clearSessionUseCase,
  ) : super(const SessionsState.initial()) {
    on<_Started>(_onStarted);
    on<_LoggedIn>(_onLoggedIn);
    on<_LoggedOut>(_onLoggedOut);
  }

  final GetAccessTokenUseCase _getAccessTokenUseCase;
  final SaveAccessTokenUseCase _saveAccessTokenUseCase;
  final ClearSessionUseCase _clearSessionUseCase;

  /// Restores session state from local storage on app startup.
  ///
  /// Emits [SessionsState.loading] while reading, then
  /// [SessionsState.authenticated] if a token is found, or
  /// [SessionsState.unauthenticated] if none exists.
  Future<void> _onStarted(_Started event, Emitter<SessionsState> emit) async {
    emit(const SessionsState.loading());

    final storedAccessToken = await _getAccessTokenUseCase.call();

    if (storedAccessToken == null) {
      emit(const SessionsState.unauthenticated());
      debugPrint(
        "SessionsState.unauthenticated() because await _getAccessTokenUseCase.call() is null",
      );
      return;
    }

    emit(SessionsState.authenticated(accessToken: storedAccessToken));
  }

  /// Handles a successful login by persisting the token and updating [TokenProvider].
  ///
  /// Emits [SessionsState.loading] while saving, then
  /// [SessionsState.authenticated] with the new token once storage completes.
  Future<void> _onLoggedIn(_LoggedIn event, Emitter<SessionsState> emit) async {
    emit(const SessionsState.loading());

    await _saveAccessTokenUseCase.call(event.token);

    getIt<TokenProvider>().setToken(event.token);

    emit(SessionsState.authenticated(accessToken: event.token));
  }

  /// Handles logout by clearing local storage and resetting [TokenProvider].
  ///
  /// Emits [SessionsState.unauthenticated] after the token is removed,
  /// causing the app to redirect to the login flow.
  Future<void> _onLoggedOut(
    _LoggedOut event,
    Emitter<SessionsState> emit,
  ) async {
    await _clearSessionUseCase.call();

    getIt<TokenProvider>().clearToken();

    emit(const SessionsState.unauthenticated());
  }
}
