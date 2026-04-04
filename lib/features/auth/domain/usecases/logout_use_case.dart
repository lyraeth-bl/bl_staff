import 'package:fpdart/fpdart.dart';

import '../../../../utils/shared/types/types.dart';
import '../repositories/auth_repository.dart';

class LogoutUseCase {
  final AuthRepository _authRepository;

  LogoutUseCase(this._authRepository);

  Future<Result<Unit>> call() async => await _authRepository.logout();
}
