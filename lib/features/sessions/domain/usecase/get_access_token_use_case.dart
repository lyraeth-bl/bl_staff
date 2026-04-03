import 'package:bl_staff/features/sessions/domain/repository/sessions_repository.dart';

class GetAccessTokenUseCase {
  final SessionsRepository _sessionsRepository;

  GetAccessTokenUseCase(this._sessionsRepository);

  Future<String?> call() => _sessionsRepository.getAccessToken();
}
