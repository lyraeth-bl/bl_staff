import '../entities/sessions_token_entity/sessions_token_entity.dart';
import '../models/sessions_token_model/sessions_token_model.dart';

extension SessionsTokenModelMapper on SessionsTokenModel {
  SessionsTokenEntity toEntity() => SessionsTokenEntity(
    accessToken: accessToken,
    tokenType: tokenType,
    expiresAt: expiresAt,
  );
}
