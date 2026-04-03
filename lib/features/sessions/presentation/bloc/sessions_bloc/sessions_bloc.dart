import 'package:bl_staff/bl_staff.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sessions_bloc.freezed.dart';
part 'sessions_event.dart';
part 'sessions_state.dart';

class SessionsBloc extends Bloc<SessionsEvent, SessionsState> {
  final GetAccessTokenUseCase _getAccessTokenUseCase;
  final SaveAccessTokenUseCase _saveAccessTokenUseCase;

  SessionsBloc(this._saveAccessTokenUseCase, this._getAccessTokenUseCase)
    : super(const SessionsState.initial()) {
    on<_Started>(_onStarted);
    on<_LoggedIn>(_onLoggedIn);
    on<_LoggedOut>(_onLoggedOut);
  }

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

    emit(
      SessionsState.authenticated(
        accessToken: storedAccessToken,
        isRefreshing: true,
      ),
    );
  }

  Future<void> _onLoggedIn(_LoggedIn event, Emitter<SessionsState> emit) async {
    emit(const SessionsState.loading());

    await _saveAccessTokenUseCase.call(event.token);

    getIt<TokenProvider>().setToken(event.token);

    emit(SessionsState.authenticated(accessToken: event.token));
  }

  Future<void> _onLoggedOut(
    _LoggedOut event,
    Emitter<SessionsState> emit,
  ) async {
    getIt<TokenProvider>().clearToken();

    emit(const SessionsState.unauthenticated());
  }
}
