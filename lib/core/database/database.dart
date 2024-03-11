import 'dart:convert';
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:kafil/features/login/data/models/profile_model.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';

part 'database.g.dart';

@DriftDatabase(tables: [Profiles])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<void> addProfile(ProfileModel profile) async {
    final profileEntry = ProfilesCompanion(
      profileJson: Value(const ProfileModelConverter().toSql(profile)),
    );
    await into(profiles).insert(profileEntry);
  }

  Future<List<ProfileModel>> getProfiles() async {
    return (await select(profiles).get())
        .map((row) => const ProfileModelConverter().fromSql(row.profileJson))
        .toList();
  }

  Future<void> clearProfiles() async {
    await delete(profiles).go();
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));

    if (Platform.isAndroid) {
      await applyWorkaroundToOpenSqlite3OnOldAndroidVersions();
    }

    final cache = (await getTemporaryDirectory()).path;

    sqlite3.tempDirectory = cache;

    return NativeDatabase.createInBackground(file);
  });
}

class Profiles extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get profileJson => text().named('profile_json')();
}

class ProfileModelConverter extends TypeConverter<ProfileModel, String> {
  const ProfileModelConverter();

  @override
  ProfileModel fromSql(String fromDb) {
    final jsonMap = json.decode(fromDb) as Map<String, dynamic>;
    return ProfileModel.fromJson(jsonMap);
  }

  @override
  String toSql(ProfileModel value) {
    return json.encode(value.toJson());
  }
}
