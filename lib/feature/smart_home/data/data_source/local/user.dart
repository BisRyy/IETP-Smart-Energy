import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_home/core/errors/exception.dart';
import 'package:smart_home/feature/smart_home/data/model/user.dart';

abstract class UserLocalDataSource {
  Future<UserModel> getUser();
  Future<void> cacheUser(UserModel userToCache);
  Future<void> deleteUser();
}

const String cacheUserKey = 'CACHED_USER';

class UserLocalDataSourceImpl implements UserLocalDataSource {
  final SharedPreferences sharedPreferences;

  UserLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> cacheUser(UserModel userToCache) {
    return sharedPreferences.setString(
      cacheUserKey,
      json.encode(userToCache.toJson()),
    );
  }

  @override
  Future<UserModel> getUser() {
    final jsonString = sharedPreferences.getString(cacheUserKey);
    if (jsonString != null) {
      return Future.value(UserModel.fromCache(json.decode(jsonString)));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> deleteUser() {
    final jsonString = sharedPreferences.getString(cacheUserKey);
    if (jsonString != null) {
      return sharedPreferences.remove(cacheUserKey);
    } else {
      throw CacheException();
    }
  }
}
