import 'package:bl_staff/bl_staff.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_bloc.freezed.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase _loginUseCase;
  final LogoutUseCase _logoutUseCase;

  AuthBloc(this._loginUseCase, this._logoutUseCase)
    : super(const AuthState.initial()) {
    on<_LoginRequested>(_onLoginRequested);
    on<_LogoutRequested>(_onLogoutRequested);
  }

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
