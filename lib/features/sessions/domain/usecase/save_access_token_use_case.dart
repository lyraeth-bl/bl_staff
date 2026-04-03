import 'package:bl_staff/features/sessions/domain/repository/sessions_repository.dart';
import 'package:fpdart/fpdart.dart';

class SaveAccessTokenUseCase {
  final SessionsRepository _sessionsRepository;

  SaveAccessTokenUseCase(this._sessionsRepository);

  Future<Unit> call(String value) => _sessionsRepository.saveAccessToken(value);
}
