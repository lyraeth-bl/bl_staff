import 'package:bl_staff/bl_staff.dart';
import 'package:fpdart/fpdart.dart';

class ClearSessionUseCase {
  final SessionsRepository _sessionsRepository;

  ClearSessionUseCase(this._sessionsRepository);

  Future<Unit> call() => _sessionsRepository.clearSession();
}
