import '../../domain/entities/login_params/login_params.dart';
import '../models/login_request/login_request.dart';

extension LoginParamsMapper on LoginParams {
  LoginRequest toRequest() =>
      LoginRequest(email: email, password: password, deviceName: deviceName);
}
