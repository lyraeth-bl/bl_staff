import 'package:freezed_annotation/freezed_annotation.dart';

part 'sessions_token_entity.freezed.dart';

@freezed
abstract class SessionsTokenEntity with _$SessionsTokenEntity {
  const factory SessionsTokenEntity({
    required String accessToken,
    required String tokenType,
    required DateTime expiresAt,
  }) = _SessionsTokenEntity;
}
