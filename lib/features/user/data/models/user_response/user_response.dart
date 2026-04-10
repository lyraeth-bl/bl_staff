import 'package:freezed_annotation/freezed_annotation.dart';

import '../user_model/user_model.dart';

part 'user_response.freezed.dart';
part 'user_response.g.dart';

@freezed
abstract class UserResponse with _$UserResponse {
  const factory UserResponse({
    required bool error,
    required String message,
    @JsonKey(name: "user") required UserModel userModel,
  }) = _UserResponse;

  factory UserResponse.fromJson(Map<String, dynamic> json) =>
      _$UserResponseFromJson(json);
}
