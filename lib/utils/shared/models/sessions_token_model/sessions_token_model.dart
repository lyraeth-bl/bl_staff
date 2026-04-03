import 'package:freezed_annotation/freezed_annotation.dart';

part 'sessions_token_model.freezed.dart';
part 'sessions_token_model.g.dart';

@freezed
abstract class SessionsTokenModel with _$SessionsTokenModel {
  const factory SessionsTokenModel({
    @JsonKey(name: "access_token") required String accessToken,
    @JsonKey(name: "token_type") required String tokenType,
    @JsonKey(name: "expires_at") required DateTime expiresAt,
  }) = _SessionsTokenModel;

  factory SessionsTokenModel.fromJson(Map<String, dynamic> json) =>
      _$SessionsTokenModelFromJson(json);
}
