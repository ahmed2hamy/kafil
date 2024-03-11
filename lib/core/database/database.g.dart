// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $ProfilesTable extends Profiles with TableInfo<$ProfilesTable, Profile> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProfilesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _profileJsonMeta =
      const VerificationMeta('profileJson');
  @override
  late final GeneratedColumn<String> profileJson = GeneratedColumn<String>(
      'profile_json', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, profileJson];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'profiles';
  @override
  VerificationContext validateIntegrity(Insertable<Profile> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('profile_json')) {
      context.handle(
          _profileJsonMeta,
          profileJson.isAcceptableOrUnknown(
              data['profile_json']!, _profileJsonMeta));
    } else if (isInserting) {
      context.missing(_profileJsonMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Profile map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Profile(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      profileJson: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}profile_json'])!,
    );
  }

  @override
  $ProfilesTable createAlias(String alias) {
    return $ProfilesTable(attachedDatabase, alias);
  }
}

class Profile extends DataClass implements Insertable<Profile> {
  final int id;
  final String profileJson;
  const Profile({required this.id, required this.profileJson});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['profile_json'] = Variable<String>(profileJson);
    return map;
  }

  ProfilesCompanion toCompanion(bool nullToAbsent) {
    return ProfilesCompanion(
      id: Value(id),
      profileJson: Value(profileJson),
    );
  }

  factory Profile.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Profile(
      id: serializer.fromJson<int>(json['id']),
      profileJson: serializer.fromJson<String>(json['profileJson']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'profileJson': serializer.toJson<String>(profileJson),
    };
  }

  Profile copyWith({int? id, String? profileJson}) => Profile(
        id: id ?? this.id,
        profileJson: profileJson ?? this.profileJson,
      );
  @override
  String toString() {
    return (StringBuffer('Profile(')
          ..write('id: $id, ')
          ..write('profileJson: $profileJson')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, profileJson);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Profile &&
          other.id == this.id &&
          other.profileJson == this.profileJson);
}

class ProfilesCompanion extends UpdateCompanion<Profile> {
  final Value<int> id;
  final Value<String> profileJson;
  const ProfilesCompanion({
    this.id = const Value.absent(),
    this.profileJson = const Value.absent(),
  });
  ProfilesCompanion.insert({
    this.id = const Value.absent(),
    required String profileJson,
  }) : profileJson = Value(profileJson);
  static Insertable<Profile> custom({
    Expression<int>? id,
    Expression<String>? profileJson,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (profileJson != null) 'profile_json': profileJson,
    });
  }

  ProfilesCompanion copyWith({Value<int>? id, Value<String>? profileJson}) {
    return ProfilesCompanion(
      id: id ?? this.id,
      profileJson: profileJson ?? this.profileJson,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (profileJson.present) {
      map['profile_json'] = Variable<String>(profileJson.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProfilesCompanion(')
          ..write('id: $id, ')
          ..write('profileJson: $profileJson')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  late final $ProfilesTable profiles = $ProfilesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [profiles];
}
