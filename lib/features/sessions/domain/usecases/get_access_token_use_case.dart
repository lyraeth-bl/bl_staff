import '../repositories/sessions_repository.dart';

class GetAccessTokenUseCase {
  final SessionsRepository _sessionsRepository;

  GetAccessTokenUseCase(this._sessionsRepository);

  Future<String?> call() => _sessionsRepository.getAccessToken();
}
