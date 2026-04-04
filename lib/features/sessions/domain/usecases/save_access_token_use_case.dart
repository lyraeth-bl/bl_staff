import 'package:fpdart/fpdart.dart';

import '../repositories/sessions_repository.dart';

class SaveAccessTokenUseCase {
  final SessionsRepository _sessionsRepository;

  SaveAccessTokenUseCase(this._sessionsRepository);

  Future<Unit> call(String value) => _sessionsRepository.saveAccessToken(value);
}
