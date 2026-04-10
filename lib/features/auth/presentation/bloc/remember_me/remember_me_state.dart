part of 'remember_me_cubit.dart';

@freezed
abstract class RememberMeState with _$RememberMeState {
  const factory RememberMeState({
    @Default('') String savedEmail,
    @Default(false) bool isChecked,
  }) = _RememberMeState;
}
