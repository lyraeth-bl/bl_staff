import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../utils/shared/models/sessions_token_model/sessions_token_model.dart';

part 'login_response.freezed.dart';
part 'login_response.g.dart';

/// A data model representing the server's response to a login attempt.
///
/// This class contains the result of the authentication process, including
/// session tokens if the login was successful.
@freezed
abstract class LoginResponse with _$LoginResponse {
  /// Creates a [LoginResponse] with the given status and data.
  const factory LoginResponse({
    /// Whether an error occurred during the login process.
    required bool error,

    /// A message describing the result of the login attempt.
    required String message,

    /// The session token information returned by the server.
    @JsonKey(name: "data") required SessionsTokenModel sessionsToken,
  }) = _LoginResponse;

  /// Creates a [LoginResponse] from a JSON map.
  ///
  /// Returns a [LoginResponse] instance populated with data from the [json] map.
  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);
}
