import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/usecases/get_email_from_remember_me_use_case.dart';
import '../../../domain/usecases/save_email_for_remember_me_use_case.dart';

part 'remember_me_cubit.freezed.dart';
part 'remember_me_state.dart';

/// A Cubit that manages the "remember me" state during the login process.
///
/// This Cubit handles the checkbox state and coordinates the retrieval and
/// persistence of the user's email address via [GetEmailFromRememberMeUseCase]
/// and [SaveEmailForRememberMeUseCase].
///
/// See also:
/// * [RememberMeState], for the state managed by this Cubit.
class RememberMeCubit extends Cubit<RememberMeState> {
  /// Creates a [RememberMeCubit] with the given use cases.
  RememberMeCubit(this._getEmail, this._saveEmail)
    : super(const RememberMeState());

  final GetEmailFromRememberMeUseCase _getEmail;
  final SaveEmailForRememberMeUseCase _saveEmail;

  /// Loads the persisted email address from local storage.
  ///
  /// Updates the state with the retrieved email or an empty string if none exists.
  Future<void> loadSavedEmail() async {
    final email = await _getEmail.call();
    emit(state.copyWith(savedEmail: email ?? ''));
  }

  /// Updates the checkbox state for the "remember me" feature.
  ///
  /// Sets the state's `isChecked` property to [value].
  void toggleCheckBox(bool value) {
    emit(state.copyWith(isChecked: value));
  }

  /// Handles logic to save or clear the email based on the checkbox state.
  ///
  /// This should be called when a login operation completes successfully.
  /// If the checkbox is checked, it saves the [email]; otherwise, it clears it.
  Future<void> onLoginSuccess(String email) async {
    if (state.isChecked) {
      await _saveEmail.call(email);
    } else {
      await _saveEmail.call('');
    }
  }
}
