import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_params.freezed.dart';

/// A set of parameters used for authenticating a user.
///
/// This data class encapsulates the credentials and metadata required to
/// perform a login operation.
@freezed
abstract class LoginParams with _$LoginParams {
  /// Creates a [LoginParams] instance with the provided credentials.
  const factory LoginParams({
    /// The user's email address.
    required String email,

    /// The user's account password.
    required String password,

    /// The name of the device from which the login attempt is being made.
    String? deviceName,
  }) = _LoginParams;
}
