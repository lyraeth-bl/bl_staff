part of 'sessions_bloc.dart';

@freezed
abstract class SessionsState with _$SessionsState {
  const factory SessionsState.initial() = _Initial;

  const factory SessionsState.loading() = _Loading;

  const factory SessionsState.authenticated({required String accessToken}) =
      _Authenticated;

  const factory SessionsState.unauthenticated() = _Unauthenticated;
}
