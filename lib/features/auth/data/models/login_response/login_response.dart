import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../utils/shared/models/sessions_token_model/sessions_token_model.dart';

part 'login_response.freezed.dart';
part 'login_response.g.dart';

@freezed
abstract class LoginResponse with _$LoginResponse {
  const factory LoginResponse({
    required bool error,
    required String message,
    @JsonKey(name: "data") required SessionsTokenModel sessionsToken,
  }) = _LoginResponse;

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);
}
