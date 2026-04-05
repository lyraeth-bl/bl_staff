import '../../domain/entities/login_params/login_params.dart';
import '../models/login_request/login_request.dart';

/// Extension to map [LoginParams] to [LoginRequest].
extension LoginParamsMapper on LoginParams {
  /// Converts this [LoginParams] instance into a [LoginRequest] data model.
  ///
  /// Returns a [LoginRequest] suitable for network requests.
  LoginRequest toRequest() =>
      LoginRequest(email: email, password: password, deviceName: deviceName);
}
