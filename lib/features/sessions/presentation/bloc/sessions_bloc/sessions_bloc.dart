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

class SessionsBloc extends Bloc<SessionsEvent, SessionsState> {
  final GetAccessTokenUseCase _getAccessTokenUseCase;
  final SaveAccessTokenUseCase _saveAccessTokenUseCase;
  final ClearSessionUseCase _clearSessionUseCase;

  SessionsBloc(
    this._saveAccessTokenUseCase,
    this._getAccessTokenUseCase,
    this._clearSessionUseCase,
  ) : super(const SessionsState.initial()) {
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

    emit(SessionsState.authenticated(accessToken: storedAccessToken));
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
    await _clearSessionUseCase.call();

    getIt<TokenProvider>().clearToken();

    emit(const SessionsState.unauthenticated());
  }
}
