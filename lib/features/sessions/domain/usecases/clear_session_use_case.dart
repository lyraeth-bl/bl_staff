import 'package:fpdart/fpdart.dart';

import '../repositories/sessions_repository.dart';

class ClearSessionUseCase {
  final SessionsRepository _sessionsRepository;

  ClearSessionUseCase(this._sessionsRepository);

  Future<Unit> call() => _sessionsRepository.clearSession();
}
