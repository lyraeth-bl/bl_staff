import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_request.freezed.dart';
part 'login_request.g.dart';

/// A data model representing a login request sent to the server.
///
/// This class is used to serialize the user's credentials and device information
/// into a format compatible with the authentication API.
@freezed
abstract class LoginRequest with _$LoginRequest {
  /// Creates a [LoginRequest] with the given credentials and device info.
  const factory LoginRequest({
    /// The user's email address.
    required String email,

    /// The user's account password.
    required String password,

    /// The name of the device sending the request.
    @JsonKey(name: "device_name") String? deviceName,
  }) = _LoginRequest;

  /// Creates a [LoginRequest] from a JSON map.
  ///
  /// Returns a [LoginRequest] instance populated with data from the [json] map.
  factory LoginRequest.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestFromJson(json);
}
