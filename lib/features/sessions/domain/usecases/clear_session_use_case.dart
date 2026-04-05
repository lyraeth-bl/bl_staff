import 'package:fpdart/fpdart.dart';

import '../repositories/sessions_repository.dart';

/// Removes all stored session data, effectively logging the user out locally.
///
/// Delegates to [SessionsRepository.clearSession]. Does not communicate
/// with a remote server — callers are responsible for any server-side
/// session invalidation before invoking this use case.
///
/// See also:
/// * [SaveAccessTokenUseCase], for persisting a new session.
/// * [GetAccessTokenUseCase], for reading the current token.
class ClearSessionUseCase {
  final SessionsRepository _sessionsRepository;

  /// Creates a [ClearSessionUseCase] backed by the given [_sessionsRepository].
  ClearSessionUseCase(this._sessionsRepository);

  /// Clears the current session from local storage.
  ///
  /// Returns [Unit] on completion.
  Future<Unit> call() => _sessionsRepository.clearSession();
}
