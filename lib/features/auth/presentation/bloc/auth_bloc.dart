import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/api/failure/failure.dart';
import '../../../../utils/shared/entities/sessions_token_entity/sessions_token_entity.dart';
import '../../domain/entities/login_params/login_params.dart';
import '../../domain/usecases/login_use_case.dart';
import '../../domain/usecases/logout_use_case.dart';

part 'auth_bloc.freezed.dart';
part 'auth_event.dart';
part 'auth_state.dart';

/// A BLoC that manages the authentication state of the application.
///
/// This component coordinates the login and logout processes by interacting with
/// the [LoginUseCase] and [LogoutUseCase]. It transitions between different
/// [AuthState]s based on the [AuthEvent]s it receives.
///
/// See also:
/// * [AuthEvent], for the events that can be dispatched to this BLoC.
/// * [AuthState], for the various states this BLoC can emit.
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  /// Creates an [AuthBloc] with the required use cases.
  AuthBloc(this._loginUseCase, this._logoutUseCase)
    : super(const AuthState.initial()) {
    on<_LoginRequested>(_onLoginRequested);
    on<_LogoutRequested>(_onLogoutRequested);
  }

  final LoginUseCase _loginUseCase;
  final LogoutUseCase _logoutUseCase;

  Future<void> _onLoginRequested(
    _LoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthState.loading());

    final LoginParams params = event.loginParams;

    final result = await _loginUseCase.call(params);

    return result.match(
      (failure) => emit(AuthState.failure(failure)),
      (SessionsTokenEntity sessionsToken) => emit(
        AuthState.successLogin(
          accessToken: sessionsToken.accessToken,
          expiresAt: sessionsToken.expiresAt,
        ),
      ),
    );
  }

  Future<void> _onLogoutRequested(
    _LogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthState.loading());

    await _logoutUseCase.call();

    emit(AuthState.successLogout());
  }
}
