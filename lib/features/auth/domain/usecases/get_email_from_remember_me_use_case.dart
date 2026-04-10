import '../repositories/auth_repository.dart';

/// A use case that retrieves the email address saved for the "remember me" feature.
///
/// This class interacts with the [AuthRepository] to get any persisted email
/// used in previous login attempts.
class GetEmailFromRememberMeUseCase {
  /// Creates a [GetEmailFromRememberMeUseCase] with the given [AuthRepository].
  GetEmailFromRememberMeUseCase(this._authRepository);

  final AuthRepository _authRepository;

  /// Returns the saved email from the [AuthRepository].
  ///
  /// Returns null if no email is found in storage.
  Future<String?> call() async =>
      await _authRepository.getEmailFromRememberMe();
}
