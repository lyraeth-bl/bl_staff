import 'package:fpdart/fpdart.dart';

import '../repositories/sessions_repository.dart';

/// Persists an access token to local storage after a successful login.
///
/// Delegates to [SessionsRepository.saveAccessToken]. Should be called
/// immediately after receiving a valid token from the authentication server,
/// before emitting an authenticated state.
///
/// See also:
/// * [GetAccessTokenUseCase], for reading the stored token.
/// * [ClearSessionUseCase], for removing the token on logout.
class SaveAccessTokenUseCase {
  final SessionsRepository _sessionsRepository;

  /// Creates a [SaveAccessTokenUseCase] backed by the given [_sessionsRepository].
  SaveAccessTokenUseCase(this._sessionsRepository);

  /// Saves [value] as the active access token.
  ///
  /// Returns [Unit] on completion.
  Future<Unit> call(String value) => _sessionsRepository.saveAccessToken(value);
}
