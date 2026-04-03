import 'package:bl_staff/bl_staff.dart';
import 'package:fpdart/fpdart.dart';

class LogoutUseCase {
  final AuthRepository _authRepository;

  LogoutUseCase(this._authRepository);

  Future<Result<Unit>> call() async => await _authRepository.logout();
}
