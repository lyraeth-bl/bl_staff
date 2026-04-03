import 'package:bl_staff/bl_staff.dart';

extension LoginParamsMapper on LoginParams {
  LoginRequest toRequest() =>
      LoginRequest(email: email, password: password, deviceName: deviceName);
}
