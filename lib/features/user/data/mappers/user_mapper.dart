import '../../domain/entities/user_entity/user_entity.dart';
import '../models/user_model/user_model.dart';

extension UserModelMapper on UserModel {
  UserEntity toEntity() => UserEntity(id: id, name: name, email: email);
}

extension UserEntityMapper on UserEntity {
  UserModel toModel() => UserModel(id: id, name: name, email: email);
}
