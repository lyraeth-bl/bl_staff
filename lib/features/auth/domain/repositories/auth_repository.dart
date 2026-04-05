import 'package:fpdart/fpdart.dart';

import '../../../../utils/shared/entities/sessions_token_entity/sessions_token_entity.dart';
import '../../../../utils/shared/types/types.dart';
import '../entities/login_params/login_params.dart';

/// A repository that manages authentication-related operations.
///
/// This repository handles user sign-in and sign-out processes, as well as
/// managing persistent credentials for the "remember me" feature. It provides
/// an abstraction layer over the underlying authentication mechanisms, such
/// as remote APIs and local storage.
///
/// See also:
/// * [LoginParams], which contains the data required for authentication.
/// * [SessionsTokenEntity], which represents the session information returned after a successful login.
abstract class AuthRepository {
  /// Authenticates a user with the provided credentials.
  ///
  /// Uses [loginParams] to perform the sign-in operation.
  /// Returns a [Result] containing a [SessionsTokenEntity] if the authentication is successful.
  Future<Result<SessionsTokenEntity>> login(LoginParams loginParams);

  /// Signs out the currently authenticated user.
  ///
  /// Clears the active session and invalidates any stored authentication tokens.
  /// Returns a [Result] indicating whether the logout operation succeeded.
  Future<Result<Unit>> logout();
}
