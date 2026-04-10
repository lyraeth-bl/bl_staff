import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/usecases/get_email_from_remember_me_use_case.dart';
import '../../../domain/usecases/save_email_for_remember_me_use_case.dart';

part 'remember_me_cubit.freezed.dart';
part 'remember_me_state.dart';

class RememberMeCubit extends Cubit<RememberMeState> {
  RememberMeCubit(this._getEmail, this._saveEmail)
    : super(const RememberMeState());

  final GetEmailFromRememberMeUseCase _getEmail;
  final SaveEmailForRememberMeUseCase _saveEmail;

  Future<void> loadSavedEmail() async {
    final email = await _getEmail.call();
    emit(state.copyWith(savedEmail: email ?? ''));
  }

  void toggleCheckBox(bool value) {
    emit(state.copyWith(isChecked: value));
  }

  Future<void> onLoginSuccess(String email) async {
    if (state.isChecked) {
      await _saveEmail.call(email);
    } else {
      await _saveEmail.call('');
    }
  }
}
