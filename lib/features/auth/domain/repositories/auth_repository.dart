import 'package:fpdart/fpdart.dart';

import '../../../../utils/shared/entities/sessions_token_entity/sessions_token_entity.dart';
import '../../../../utils/shared/types/types.dart';
import '../entities/login_params/login_params.dart';

abstract class AuthRepository {
  Future<Result<SessionsTokenEntity>> login(LoginParams loginParams);

  Future<Result<Unit>> logout();

  Future<String?> getEmailFromRememberMe();

  Future<Unit> saveEmailForRememberMe(String email);
}
