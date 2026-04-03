import 'package:bl_staff/bl_staff.dart';
import 'package:fpdart/fpdart.dart';

abstract class AuthRepository {
  Future<Result<SessionsTokenEntity>> login(LoginParams loginParams);

  Future<Result<Unit>> logout();
}
