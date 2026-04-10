part of 'user_bloc.dart';

@freezed
abstract class UserEvent with _$UserEvent {
  const factory UserEvent.started() = _Started;

  const factory UserEvent.fetchUser({@Default(false) bool forceRefresh}) =
      _FetchUser;
}
