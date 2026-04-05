import '../repositories/sessions_repository.dart';

/// Retrieves the access token currently stored on the device.
///
/// Used at app startup to determine whether an active session exists,
/// and by [TokenProvider] to attach the token to outgoing API requests.
///
/// See also:
/// * [SaveAccessTokenUseCase], for persisting a new token after login.
/// * [ClearSessionUseCase], for removing the token on logout.
class GetAccessTokenUseCase {
  final SessionsRepository _sessionsRepository;

  /// Creates a [GetAccessTokenUseCase] backed by the given [_sessionsRepository].
  GetAccessTokenUseCase(this._sessionsRepository);

  /// Returns the stored access token, or `null` if no session exists.
  Future<String?> call() => _sessionsRepository.getAccessToken();
}
