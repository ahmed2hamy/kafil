import 'package:kafil/core/database/database.dart' as database;
import 'package:kafil/core/models/exception.dart';
import 'package:kafil/features/login/data/models/profile_model.dart';
import 'package:kafil/features/login/domain/entities/profile.dart';

abstract class LoginLocalDataSource {
  Future<Profile> getLoginData();

  Future<bool> saveLoginData(Profile profile);

  Future<bool> hasLoginData();

  Future<void> clearLoginData();
}

class LoginLocalDataSourceImpl implements LoginLocalDataSource {
  final database.AppDatabase _appDatabase;

  const LoginLocalDataSourceImpl({
    required database.AppDatabase appDatabase,
  }) : _appDatabase = appDatabase;

  @override
  Future<Profile> getLoginData() async {
    try {
      List<ProfileModel> profiles = await _appDatabase.getProfiles();

      return profiles.first;
    } on Exception catch (e) {
      throw CacheException(e.toString());
    }
  }

  @override
  Future<bool> saveLoginData(Profile profile) async {
    try {
      await _appDatabase.addProfile(ProfileModel.fromEntity(profile));

      return true;
    } on Exception catch (e) {
      throw CacheException(e.toString());
    }
  }

  @override
  Future<bool> hasLoginData() async {
    try {
      final List<ProfileModel> profiles = await _appDatabase.getProfiles();
      return profiles.isNotEmpty;
    } catch (_) {
      return false;
    }
  }

  @override
  Future<void> clearLoginData() async {
    try {
      await _appDatabase.clearProfiles();
    } on Exception catch (e) {
      throw CacheException(e.toString());
    }
  }
}
