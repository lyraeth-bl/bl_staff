import 'package:fpdart/fpdart.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../../core/core.dart';
import '../models/user_model/user_model.dart';

abstract class UserLocalDataSource {
  UserModel? getSavedUserDetail();

  Future<Unit> saveUserDetail(UserModel userModel);
}

class UserLocalDataSourceImpl implements UserLocalDataSource {
  UserLocalDataSourceImpl(this._hive);

  final HiveInterface _hive;

  @override
  UserModel? getSavedUserDetail() {
    final rawData = _hive.box(userBoxKey).get(userDetailKey) as Map?;

    if (rawData == null) return null;

    return UserModel.fromJson(Map<String, dynamic>.from(rawData));
  }

  @override
  Future<Unit> saveUserDetail(UserModel userModel) async {
    _hive.box(userBoxKey).put(userDetailKey, userModel.toJson());

    return unit;
  }
}
