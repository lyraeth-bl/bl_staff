import 'package:fpdart/fpdart.dart';

import '../repositories/auth_repository.dart';

/// A use case that persists an email address for the "remember me" feature.
///
/// This class interacts with the [AuthRepository] to save an email string
/// to local storage for future authentication attempts.
class SaveEmailForRememberMeUseCase {
  /// Creates a [SaveEmailForRememberMeUseCase] with the given [AuthRepository].
  SaveEmailForRememberMeUseCase(this._authRepository);

  final AuthRepository _authRepository;

  /// Saves the provided [email] to the [AuthRepository].
  ///
  /// Returns [unit] upon successful completion.
  Future<Unit> call(String email) async =>
      await _authRepository.saveEmailForRememberMe(email);
}
