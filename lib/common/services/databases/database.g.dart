// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $RolesTable extends Roles with TableInfo<$RolesTable, Role> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RolesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nomRoleMeta = const VerificationMeta(
    'nomRole',
  );
  @override
  late final GeneratedColumn<String> nomRole = GeneratedColumn<String>(
    'nom_role',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [id, nomRole, description];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sie_role';
  @override
  VerificationContext validateIntegrity(
    Insertable<Role> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('nom_role')) {
      context.handle(
        _nomRoleMeta,
        nomRole.isAcceptableOrUnknown(data['nom_role']!, _nomRoleMeta),
      );
    } else if (isInserting) {
      context.missing(_nomRoleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Role map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Role(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      nomRole: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nom_role'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
    );
  }

  @override
  $RolesTable createAlias(String alias) {
    return $RolesTable(attachedDatabase, alias);
  }
}

class Role extends DataClass implements Insertable<Role> {
  final String id;
  final String nomRole;
  final String? description;
  const Role({required this.id, required this.nomRole, this.description});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['nom_role'] = Variable<String>(nomRole);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    return map;
  }

  RolesCompanion toCompanion(bool nullToAbsent) {
    return RolesCompanion(
      id: Value(id),
      nomRole: Value(nomRole),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
    );
  }

  factory Role.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Role(
      id: serializer.fromJson<String>(json['id']),
      nomRole: serializer.fromJson<String>(json['nomRole']),
      description: serializer.fromJson<String?>(json['description']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'nomRole': serializer.toJson<String>(nomRole),
      'description': serializer.toJson<String?>(description),
    };
  }

  Role copyWith({
    String? id,
    String? nomRole,
    Value<String?> description = const Value.absent(),
  }) => Role(
    id: id ?? this.id,
    nomRole: nomRole ?? this.nomRole,
    description: description.present ? description.value : this.description,
  );
  Role copyWithCompanion(RolesCompanion data) {
    return Role(
      id: data.id.present ? data.id.value : this.id,
      nomRole: data.nomRole.present ? data.nomRole.value : this.nomRole,
      description: data.description.present
          ? data.description.value
          : this.description,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Role(')
          ..write('id: $id, ')
          ..write('nomRole: $nomRole, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, nomRole, description);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Role &&
          other.id == this.id &&
          other.nomRole == this.nomRole &&
          other.description == this.description);
}

class RolesCompanion extends UpdateCompanion<Role> {
  final Value<String> id;
  final Value<String> nomRole;
  final Value<String?> description;
  final Value<int> rowid;
  const RolesCompanion({
    this.id = const Value.absent(),
    this.nomRole = const Value.absent(),
    this.description = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RolesCompanion.insert({
    required String id,
    required String nomRole,
    this.description = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       nomRole = Value(nomRole);
  static Insertable<Role> custom({
    Expression<String>? id,
    Expression<String>? nomRole,
    Expression<String>? description,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nomRole != null) 'nom_role': nomRole,
      if (description != null) 'description': description,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RolesCompanion copyWith({
    Value<String>? id,
    Value<String>? nomRole,
    Value<String?>? description,
    Value<int>? rowid,
  }) {
    return RolesCompanion(
      id: id ?? this.id,
      nomRole: nomRole ?? this.nomRole,
      description: description ?? this.description,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (nomRole.present) {
      map['nom_role'] = Variable<String>(nomRole.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RolesCompanion(')
          ..write('id: $id, ')
          ..write('nomRole: $nomRole, ')
          ..write('description: $description, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PermissionsTable extends Permissions
    with TableInfo<$PermissionsTable, Permission> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PermissionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
    'code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  @override
  List<GeneratedColumn> get $columns => [id, code];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sie_permissions';
  @override
  VerificationContext validateIntegrity(
    Insertable<Permission> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('code')) {
      context.handle(
        _codeMeta,
        code.isAcceptableOrUnknown(data['code']!, _codeMeta),
      );
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Permission map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Permission(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      code: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}code'],
      )!,
    );
  }

  @override
  $PermissionsTable createAlias(String alias) {
    return $PermissionsTable(attachedDatabase, alias);
  }
}

class Permission extends DataClass implements Insertable<Permission> {
  final String id;
  final String code;
  const Permission({required this.id, required this.code});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['code'] = Variable<String>(code);
    return map;
  }

  PermissionsCompanion toCompanion(bool nullToAbsent) {
    return PermissionsCompanion(id: Value(id), code: Value(code));
  }

  factory Permission.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Permission(
      id: serializer.fromJson<String>(json['id']),
      code: serializer.fromJson<String>(json['code']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'code': serializer.toJson<String>(code),
    };
  }

  Permission copyWith({String? id, String? code}) =>
      Permission(id: id ?? this.id, code: code ?? this.code);
  Permission copyWithCompanion(PermissionsCompanion data) {
    return Permission(
      id: data.id.present ? data.id.value : this.id,
      code: data.code.present ? data.code.value : this.code,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Permission(')
          ..write('id: $id, ')
          ..write('code: $code')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, code);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Permission && other.id == this.id && other.code == this.code);
}

class PermissionsCompanion extends UpdateCompanion<Permission> {
  final Value<String> id;
  final Value<String> code;
  final Value<int> rowid;
  const PermissionsCompanion({
    this.id = const Value.absent(),
    this.code = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PermissionsCompanion.insert({
    required String id,
    required String code,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       code = Value(code);
  static Insertable<Permission> custom({
    Expression<String>? id,
    Expression<String>? code,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (code != null) 'code': code,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PermissionsCompanion copyWith({
    Value<String>? id,
    Value<String>? code,
    Value<int>? rowid,
  }) {
    return PermissionsCompanion(
      id: id ?? this.id,
      code: code ?? this.code,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PermissionsCompanion(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RolePermissionsTable extends RolePermissions
    with TableInfo<$RolePermissionsTable, RolePermission> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RolePermissionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _roleIdMeta = const VerificationMeta('roleId');
  @override
  late final GeneratedColumn<String> roleId = GeneratedColumn<String>(
    'role_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES sie_role (id)',
    ),
  );
  static const VerificationMeta _permIdMeta = const VerificationMeta('permId');
  @override
  late final GeneratedColumn<String> permId = GeneratedColumn<String>(
    'perm_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES sie_permissions (id)',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [roleId, permId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sie_role_permissions';
  @override
  VerificationContext validateIntegrity(
    Insertable<RolePermission> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('role_id')) {
      context.handle(
        _roleIdMeta,
        roleId.isAcceptableOrUnknown(data['role_id']!, _roleIdMeta),
      );
    } else if (isInserting) {
      context.missing(_roleIdMeta);
    }
    if (data.containsKey('perm_id')) {
      context.handle(
        _permIdMeta,
        permId.isAcceptableOrUnknown(data['perm_id']!, _permIdMeta),
      );
    } else if (isInserting) {
      context.missing(_permIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {roleId, permId};
  @override
  RolePermission map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RolePermission(
      roleId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}role_id'],
      )!,
      permId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}perm_id'],
      )!,
    );
  }

  @override
  $RolePermissionsTable createAlias(String alias) {
    return $RolePermissionsTable(attachedDatabase, alias);
  }
}

class RolePermission extends DataClass implements Insertable<RolePermission> {
  final String roleId;
  final String permId;
  const RolePermission({required this.roleId, required this.permId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['role_id'] = Variable<String>(roleId);
    map['perm_id'] = Variable<String>(permId);
    return map;
  }

  RolePermissionsCompanion toCompanion(bool nullToAbsent) {
    return RolePermissionsCompanion(
      roleId: Value(roleId),
      permId: Value(permId),
    );
  }

  factory RolePermission.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RolePermission(
      roleId: serializer.fromJson<String>(json['roleId']),
      permId: serializer.fromJson<String>(json['permId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'roleId': serializer.toJson<String>(roleId),
      'permId': serializer.toJson<String>(permId),
    };
  }

  RolePermission copyWith({String? roleId, String? permId}) => RolePermission(
    roleId: roleId ?? this.roleId,
    permId: permId ?? this.permId,
  );
  RolePermission copyWithCompanion(RolePermissionsCompanion data) {
    return RolePermission(
      roleId: data.roleId.present ? data.roleId.value : this.roleId,
      permId: data.permId.present ? data.permId.value : this.permId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RolePermission(')
          ..write('roleId: $roleId, ')
          ..write('permId: $permId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(roleId, permId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RolePermission &&
          other.roleId == this.roleId &&
          other.permId == this.permId);
}

class RolePermissionsCompanion extends UpdateCompanion<RolePermission> {
  final Value<String> roleId;
  final Value<String> permId;
  final Value<int> rowid;
  const RolePermissionsCompanion({
    this.roleId = const Value.absent(),
    this.permId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RolePermissionsCompanion.insert({
    required String roleId,
    required String permId,
    this.rowid = const Value.absent(),
  }) : roleId = Value(roleId),
       permId = Value(permId);
  static Insertable<RolePermission> custom({
    Expression<String>? roleId,
    Expression<String>? permId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (roleId != null) 'role_id': roleId,
      if (permId != null) 'perm_id': permId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RolePermissionsCompanion copyWith({
    Value<String>? roleId,
    Value<String>? permId,
    Value<int>? rowid,
  }) {
    return RolePermissionsCompanion(
      roleId: roleId ?? this.roleId,
      permId: permId ?? this.permId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (roleId.present) {
      map['role_id'] = Variable<String>(roleId.value);
    }
    if (permId.present) {
      map['perm_id'] = Variable<String>(permId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RolePermissionsCompanion(')
          ..write('roleId: $roleId, ')
          ..write('permId: $permId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $EcolesTable extends Ecoles with TableInfo<$EcolesTable, Ecole> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EcolesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nomMeta = const VerificationMeta('nom');
  @override
  late final GeneratedColumn<String> nom = GeneratedColumn<String>(
    'nom',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _villeMeta = const VerificationMeta('ville');
  @override
  late final GeneratedColumn<String> ville = GeneratedColumn<String>(
    'ville',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dateCreaMeta = const VerificationMeta(
    'dateCrea',
  );
  @override
  late final GeneratedColumn<int> dateCrea = GeneratedColumn<int>(
    'date_crea',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, nom, ville, dateCrea];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sie_ecole';
  @override
  VerificationContext validateIntegrity(
    Insertable<Ecole> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('nom')) {
      context.handle(
        _nomMeta,
        nom.isAcceptableOrUnknown(data['nom']!, _nomMeta),
      );
    } else if (isInserting) {
      context.missing(_nomMeta);
    }
    if (data.containsKey('ville')) {
      context.handle(
        _villeMeta,
        ville.isAcceptableOrUnknown(data['ville']!, _villeMeta),
      );
    }
    if (data.containsKey('date_crea')) {
      context.handle(
        _dateCreaMeta,
        dateCrea.isAcceptableOrUnknown(data['date_crea']!, _dateCreaMeta),
      );
    } else if (isInserting) {
      context.missing(_dateCreaMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Ecole map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Ecole(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      nom: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nom'],
      )!,
      ville: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ville'],
      ),
      dateCrea: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}date_crea'],
      )!,
    );
  }

  @override
  $EcolesTable createAlias(String alias) {
    return $EcolesTable(attachedDatabase, alias);
  }
}

class Ecole extends DataClass implements Insertable<Ecole> {
  final String id;
  final String nom;
  final String? ville;
  final int dateCrea;
  const Ecole({
    required this.id,
    required this.nom,
    this.ville,
    required this.dateCrea,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['nom'] = Variable<String>(nom);
    if (!nullToAbsent || ville != null) {
      map['ville'] = Variable<String>(ville);
    }
    map['date_crea'] = Variable<int>(dateCrea);
    return map;
  }

  EcolesCompanion toCompanion(bool nullToAbsent) {
    return EcolesCompanion(
      id: Value(id),
      nom: Value(nom),
      ville: ville == null && nullToAbsent
          ? const Value.absent()
          : Value(ville),
      dateCrea: Value(dateCrea),
    );
  }

  factory Ecole.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Ecole(
      id: serializer.fromJson<String>(json['id']),
      nom: serializer.fromJson<String>(json['nom']),
      ville: serializer.fromJson<String?>(json['ville']),
      dateCrea: serializer.fromJson<int>(json['dateCrea']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'nom': serializer.toJson<String>(nom),
      'ville': serializer.toJson<String?>(ville),
      'dateCrea': serializer.toJson<int>(dateCrea),
    };
  }

  Ecole copyWith({
    String? id,
    String? nom,
    Value<String?> ville = const Value.absent(),
    int? dateCrea,
  }) => Ecole(
    id: id ?? this.id,
    nom: nom ?? this.nom,
    ville: ville.present ? ville.value : this.ville,
    dateCrea: dateCrea ?? this.dateCrea,
  );
  Ecole copyWithCompanion(EcolesCompanion data) {
    return Ecole(
      id: data.id.present ? data.id.value : this.id,
      nom: data.nom.present ? data.nom.value : this.nom,
      ville: data.ville.present ? data.ville.value : this.ville,
      dateCrea: data.dateCrea.present ? data.dateCrea.value : this.dateCrea,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Ecole(')
          ..write('id: $id, ')
          ..write('nom: $nom, ')
          ..write('ville: $ville, ')
          ..write('dateCrea: $dateCrea')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, nom, ville, dateCrea);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Ecole &&
          other.id == this.id &&
          other.nom == this.nom &&
          other.ville == this.ville &&
          other.dateCrea == this.dateCrea);
}

class EcolesCompanion extends UpdateCompanion<Ecole> {
  final Value<String> id;
  final Value<String> nom;
  final Value<String?> ville;
  final Value<int> dateCrea;
  final Value<int> rowid;
  const EcolesCompanion({
    this.id = const Value.absent(),
    this.nom = const Value.absent(),
    this.ville = const Value.absent(),
    this.dateCrea = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  EcolesCompanion.insert({
    required String id,
    required String nom,
    this.ville = const Value.absent(),
    required int dateCrea,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       nom = Value(nom),
       dateCrea = Value(dateCrea);
  static Insertable<Ecole> custom({
    Expression<String>? id,
    Expression<String>? nom,
    Expression<String>? ville,
    Expression<int>? dateCrea,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nom != null) 'nom': nom,
      if (ville != null) 'ville': ville,
      if (dateCrea != null) 'date_crea': dateCrea,
      if (rowid != null) 'rowid': rowid,
    });
  }

  EcolesCompanion copyWith({
    Value<String>? id,
    Value<String>? nom,
    Value<String?>? ville,
    Value<int>? dateCrea,
    Value<int>? rowid,
  }) {
    return EcolesCompanion(
      id: id ?? this.id,
      nom: nom ?? this.nom,
      ville: ville ?? this.ville,
      dateCrea: dateCrea ?? this.dateCrea,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (nom.present) {
      map['nom'] = Variable<String>(nom.value);
    }
    if (ville.present) {
      map['ville'] = Variable<String>(ville.value);
    }
    if (dateCrea.present) {
      map['date_crea'] = Variable<int>(dateCrea.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EcolesCompanion(')
          ..write('id: $id, ')
          ..write('nom: $nom, ')
          ..write('ville: $ville, ')
          ..write('dateCrea: $dateCrea, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $NiveauxTable extends Niveaux with TableInfo<$NiveauxTable, Niveau> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NiveauxTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nomNiveauMeta = const VerificationMeta(
    'nomNiveau',
  );
  @override
  late final GeneratedColumn<String> nomNiveau = GeneratedColumn<String>(
    'nom_niveau',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ecoleIdMeta = const VerificationMeta(
    'ecoleId',
  );
  @override
  late final GeneratedColumn<String> ecoleId = GeneratedColumn<String>(
    'ecole_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES sie_ecole (id)',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [id, nomNiveau, ecoleId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sie_niveaux';
  @override
  VerificationContext validateIntegrity(
    Insertable<Niveau> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('nom_niveau')) {
      context.handle(
        _nomNiveauMeta,
        nomNiveau.isAcceptableOrUnknown(data['nom_niveau']!, _nomNiveauMeta),
      );
    } else if (isInserting) {
      context.missing(_nomNiveauMeta);
    }
    if (data.containsKey('ecole_id')) {
      context.handle(
        _ecoleIdMeta,
        ecoleId.isAcceptableOrUnknown(data['ecole_id']!, _ecoleIdMeta),
      );
    } else if (isInserting) {
      context.missing(_ecoleIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Niveau map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Niveau(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      nomNiveau: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nom_niveau'],
      )!,
      ecoleId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ecole_id'],
      )!,
    );
  }

  @override
  $NiveauxTable createAlias(String alias) {
    return $NiveauxTable(attachedDatabase, alias);
  }
}

class Niveau extends DataClass implements Insertable<Niveau> {
  final String id;
  final String nomNiveau;
  final String ecoleId;
  const Niveau({
    required this.id,
    required this.nomNiveau,
    required this.ecoleId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['nom_niveau'] = Variable<String>(nomNiveau);
    map['ecole_id'] = Variable<String>(ecoleId);
    return map;
  }

  NiveauxCompanion toCompanion(bool nullToAbsent) {
    return NiveauxCompanion(
      id: Value(id),
      nomNiveau: Value(nomNiveau),
      ecoleId: Value(ecoleId),
    );
  }

  factory Niveau.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Niveau(
      id: serializer.fromJson<String>(json['id']),
      nomNiveau: serializer.fromJson<String>(json['nomNiveau']),
      ecoleId: serializer.fromJson<String>(json['ecoleId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'nomNiveau': serializer.toJson<String>(nomNiveau),
      'ecoleId': serializer.toJson<String>(ecoleId),
    };
  }

  Niveau copyWith({String? id, String? nomNiveau, String? ecoleId}) => Niveau(
    id: id ?? this.id,
    nomNiveau: nomNiveau ?? this.nomNiveau,
    ecoleId: ecoleId ?? this.ecoleId,
  );
  Niveau copyWithCompanion(NiveauxCompanion data) {
    return Niveau(
      id: data.id.present ? data.id.value : this.id,
      nomNiveau: data.nomNiveau.present ? data.nomNiveau.value : this.nomNiveau,
      ecoleId: data.ecoleId.present ? data.ecoleId.value : this.ecoleId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Niveau(')
          ..write('id: $id, ')
          ..write('nomNiveau: $nomNiveau, ')
          ..write('ecoleId: $ecoleId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, nomNiveau, ecoleId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Niveau &&
          other.id == this.id &&
          other.nomNiveau == this.nomNiveau &&
          other.ecoleId == this.ecoleId);
}

class NiveauxCompanion extends UpdateCompanion<Niveau> {
  final Value<String> id;
  final Value<String> nomNiveau;
  final Value<String> ecoleId;
  final Value<int> rowid;
  const NiveauxCompanion({
    this.id = const Value.absent(),
    this.nomNiveau = const Value.absent(),
    this.ecoleId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  NiveauxCompanion.insert({
    required String id,
    required String nomNiveau,
    required String ecoleId,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       nomNiveau = Value(nomNiveau),
       ecoleId = Value(ecoleId);
  static Insertable<Niveau> custom({
    Expression<String>? id,
    Expression<String>? nomNiveau,
    Expression<String>? ecoleId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nomNiveau != null) 'nom_niveau': nomNiveau,
      if (ecoleId != null) 'ecole_id': ecoleId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  NiveauxCompanion copyWith({
    Value<String>? id,
    Value<String>? nomNiveau,
    Value<String>? ecoleId,
    Value<int>? rowid,
  }) {
    return NiveauxCompanion(
      id: id ?? this.id,
      nomNiveau: nomNiveau ?? this.nomNiveau,
      ecoleId: ecoleId ?? this.ecoleId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (nomNiveau.present) {
      map['nom_niveau'] = Variable<String>(nomNiveau.value);
    }
    if (ecoleId.present) {
      map['ecole_id'] = Variable<String>(ecoleId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NiveauxCompanion(')
          ..write('id: $id, ')
          ..write('nomNiveau: $nomNiveau, ')
          ..write('ecoleId: $ecoleId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $UtilisateursTable extends Utilisateurs
    with TableInfo<$UtilisateursTable, Utilisateur> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UtilisateursTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nomMeta = const VerificationMeta('nom');
  @override
  late final GeneratedColumn<String> nom = GeneratedColumn<String>(
    'nom',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _prenomMeta = const VerificationMeta('prenom');
  @override
  late final GeneratedColumn<String> prenom = GeneratedColumn<String>(
    'prenom',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _mdpMeta = const VerificationMeta('mdp');
  @override
  late final GeneratedColumn<String> mdp = GeneratedColumn<String>(
    'mdp',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _roleIdMeta = const VerificationMeta('roleId');
  @override
  late final GeneratedColumn<String> roleId = GeneratedColumn<String>(
    'role_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES sie_role (id)',
    ),
  );
  static const VerificationMeta _dateCreaMeta = const VerificationMeta(
    'dateCrea',
  );
  @override
  late final GeneratedColumn<int> dateCrea = GeneratedColumn<int>(
    'date_crea',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateDelMeta = const VerificationMeta(
    'dateDel',
  );
  @override
  late final GeneratedColumn<int> dateDel = GeneratedColumn<int>(
    'date_del',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    nom,
    prenom,
    email,
    mdp,
    roleId,
    dateCrea,
    dateDel,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sie_utilisateurs';
  @override
  VerificationContext validateIntegrity(
    Insertable<Utilisateur> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('nom')) {
      context.handle(
        _nomMeta,
        nom.isAcceptableOrUnknown(data['nom']!, _nomMeta),
      );
    } else if (isInserting) {
      context.missing(_nomMeta);
    }
    if (data.containsKey('prenom')) {
      context.handle(
        _prenomMeta,
        prenom.isAcceptableOrUnknown(data['prenom']!, _prenomMeta),
      );
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    if (data.containsKey('mdp')) {
      context.handle(
        _mdpMeta,
        mdp.isAcceptableOrUnknown(data['mdp']!, _mdpMeta),
      );
    } else if (isInserting) {
      context.missing(_mdpMeta);
    }
    if (data.containsKey('role_id')) {
      context.handle(
        _roleIdMeta,
        roleId.isAcceptableOrUnknown(data['role_id']!, _roleIdMeta),
      );
    }
    if (data.containsKey('date_crea')) {
      context.handle(
        _dateCreaMeta,
        dateCrea.isAcceptableOrUnknown(data['date_crea']!, _dateCreaMeta),
      );
    } else if (isInserting) {
      context.missing(_dateCreaMeta);
    }
    if (data.containsKey('date_del')) {
      context.handle(
        _dateDelMeta,
        dateDel.isAcceptableOrUnknown(data['date_del']!, _dateDelMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Utilisateur map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Utilisateur(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      nom: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nom'],
      )!,
      prenom: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}prenom'],
      ),
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      )!,
      mdp: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}mdp'],
      )!,
      roleId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}role_id'],
      ),
      dateCrea: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}date_crea'],
      )!,
      dateDel: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}date_del'],
      ),
    );
  }

  @override
  $UtilisateursTable createAlias(String alias) {
    return $UtilisateursTable(attachedDatabase, alias);
  }
}

class Utilisateur extends DataClass implements Insertable<Utilisateur> {
  final String id;
  final String nom;
  final String? prenom;
  final String email;
  final String mdp;
  final String? roleId;
  final int dateCrea;
  final int? dateDel;
  const Utilisateur({
    required this.id,
    required this.nom,
    this.prenom,
    required this.email,
    required this.mdp,
    this.roleId,
    required this.dateCrea,
    this.dateDel,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['nom'] = Variable<String>(nom);
    if (!nullToAbsent || prenom != null) {
      map['prenom'] = Variable<String>(prenom);
    }
    map['email'] = Variable<String>(email);
    map['mdp'] = Variable<String>(mdp);
    if (!nullToAbsent || roleId != null) {
      map['role_id'] = Variable<String>(roleId);
    }
    map['date_crea'] = Variable<int>(dateCrea);
    if (!nullToAbsent || dateDel != null) {
      map['date_del'] = Variable<int>(dateDel);
    }
    return map;
  }

  UtilisateursCompanion toCompanion(bool nullToAbsent) {
    return UtilisateursCompanion(
      id: Value(id),
      nom: Value(nom),
      prenom: prenom == null && nullToAbsent
          ? const Value.absent()
          : Value(prenom),
      email: Value(email),
      mdp: Value(mdp),
      roleId: roleId == null && nullToAbsent
          ? const Value.absent()
          : Value(roleId),
      dateCrea: Value(dateCrea),
      dateDel: dateDel == null && nullToAbsent
          ? const Value.absent()
          : Value(dateDel),
    );
  }

  factory Utilisateur.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Utilisateur(
      id: serializer.fromJson<String>(json['id']),
      nom: serializer.fromJson<String>(json['nom']),
      prenom: serializer.fromJson<String?>(json['prenom']),
      email: serializer.fromJson<String>(json['email']),
      mdp: serializer.fromJson<String>(json['mdp']),
      roleId: serializer.fromJson<String?>(json['roleId']),
      dateCrea: serializer.fromJson<int>(json['dateCrea']),
      dateDel: serializer.fromJson<int?>(json['dateDel']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'nom': serializer.toJson<String>(nom),
      'prenom': serializer.toJson<String?>(prenom),
      'email': serializer.toJson<String>(email),
      'mdp': serializer.toJson<String>(mdp),
      'roleId': serializer.toJson<String?>(roleId),
      'dateCrea': serializer.toJson<int>(dateCrea),
      'dateDel': serializer.toJson<int?>(dateDel),
    };
  }

  Utilisateur copyWith({
    String? id,
    String? nom,
    Value<String?> prenom = const Value.absent(),
    String? email,
    String? mdp,
    Value<String?> roleId = const Value.absent(),
    int? dateCrea,
    Value<int?> dateDel = const Value.absent(),
  }) => Utilisateur(
    id: id ?? this.id,
    nom: nom ?? this.nom,
    prenom: prenom.present ? prenom.value : this.prenom,
    email: email ?? this.email,
    mdp: mdp ?? this.mdp,
    roleId: roleId.present ? roleId.value : this.roleId,
    dateCrea: dateCrea ?? this.dateCrea,
    dateDel: dateDel.present ? dateDel.value : this.dateDel,
  );
  Utilisateur copyWithCompanion(UtilisateursCompanion data) {
    return Utilisateur(
      id: data.id.present ? data.id.value : this.id,
      nom: data.nom.present ? data.nom.value : this.nom,
      prenom: data.prenom.present ? data.prenom.value : this.prenom,
      email: data.email.present ? data.email.value : this.email,
      mdp: data.mdp.present ? data.mdp.value : this.mdp,
      roleId: data.roleId.present ? data.roleId.value : this.roleId,
      dateCrea: data.dateCrea.present ? data.dateCrea.value : this.dateCrea,
      dateDel: data.dateDel.present ? data.dateDel.value : this.dateDel,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Utilisateur(')
          ..write('id: $id, ')
          ..write('nom: $nom, ')
          ..write('prenom: $prenom, ')
          ..write('email: $email, ')
          ..write('mdp: $mdp, ')
          ..write('roleId: $roleId, ')
          ..write('dateCrea: $dateCrea, ')
          ..write('dateDel: $dateDel')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, nom, prenom, email, mdp, roleId, dateCrea, dateDel);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Utilisateur &&
          other.id == this.id &&
          other.nom == this.nom &&
          other.prenom == this.prenom &&
          other.email == this.email &&
          other.mdp == this.mdp &&
          other.roleId == this.roleId &&
          other.dateCrea == this.dateCrea &&
          other.dateDel == this.dateDel);
}

class UtilisateursCompanion extends UpdateCompanion<Utilisateur> {
  final Value<String> id;
  final Value<String> nom;
  final Value<String?> prenom;
  final Value<String> email;
  final Value<String> mdp;
  final Value<String?> roleId;
  final Value<int> dateCrea;
  final Value<int?> dateDel;
  final Value<int> rowid;
  const UtilisateursCompanion({
    this.id = const Value.absent(),
    this.nom = const Value.absent(),
    this.prenom = const Value.absent(),
    this.email = const Value.absent(),
    this.mdp = const Value.absent(),
    this.roleId = const Value.absent(),
    this.dateCrea = const Value.absent(),
    this.dateDel = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UtilisateursCompanion.insert({
    required String id,
    required String nom,
    this.prenom = const Value.absent(),
    required String email,
    required String mdp,
    this.roleId = const Value.absent(),
    required int dateCrea,
    this.dateDel = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       nom = Value(nom),
       email = Value(email),
       mdp = Value(mdp),
       dateCrea = Value(dateCrea);
  static Insertable<Utilisateur> custom({
    Expression<String>? id,
    Expression<String>? nom,
    Expression<String>? prenom,
    Expression<String>? email,
    Expression<String>? mdp,
    Expression<String>? roleId,
    Expression<int>? dateCrea,
    Expression<int>? dateDel,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nom != null) 'nom': nom,
      if (prenom != null) 'prenom': prenom,
      if (email != null) 'email': email,
      if (mdp != null) 'mdp': mdp,
      if (roleId != null) 'role_id': roleId,
      if (dateCrea != null) 'date_crea': dateCrea,
      if (dateDel != null) 'date_del': dateDel,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UtilisateursCompanion copyWith({
    Value<String>? id,
    Value<String>? nom,
    Value<String?>? prenom,
    Value<String>? email,
    Value<String>? mdp,
    Value<String?>? roleId,
    Value<int>? dateCrea,
    Value<int?>? dateDel,
    Value<int>? rowid,
  }) {
    return UtilisateursCompanion(
      id: id ?? this.id,
      nom: nom ?? this.nom,
      prenom: prenom ?? this.prenom,
      email: email ?? this.email,
      mdp: mdp ?? this.mdp,
      roleId: roleId ?? this.roleId,
      dateCrea: dateCrea ?? this.dateCrea,
      dateDel: dateDel ?? this.dateDel,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (nom.present) {
      map['nom'] = Variable<String>(nom.value);
    }
    if (prenom.present) {
      map['prenom'] = Variable<String>(prenom.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (mdp.present) {
      map['mdp'] = Variable<String>(mdp.value);
    }
    if (roleId.present) {
      map['role_id'] = Variable<String>(roleId.value);
    }
    if (dateCrea.present) {
      map['date_crea'] = Variable<int>(dateCrea.value);
    }
    if (dateDel.present) {
      map['date_del'] = Variable<int>(dateDel.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UtilisateursCompanion(')
          ..write('id: $id, ')
          ..write('nom: $nom, ')
          ..write('prenom: $prenom, ')
          ..write('email: $email, ')
          ..write('mdp: $mdp, ')
          ..write('roleId: $roleId, ')
          ..write('dateCrea: $dateCrea, ')
          ..write('dateDel: $dateDel, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AppartenancesTable extends Appartenances
    with TableInfo<$AppartenancesTable, Appartenance> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppartenancesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES sie_utilisateurs (id)',
    ),
  );
  static const VerificationMeta _ecoleIdMeta = const VerificationMeta(
    'ecoleId',
  );
  @override
  late final GeneratedColumn<String> ecoleId = GeneratedColumn<String>(
    'ecole_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES sie_ecole (id)',
    ),
  );
  static const VerificationMeta _niveauIdMeta = const VerificationMeta(
    'niveauId',
  );
  @override
  late final GeneratedColumn<String> niveauId = GeneratedColumn<String>(
    'niveau_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES sie_niveaux (id)',
    ),
  );
  static const VerificationMeta _anneeScoMeta = const VerificationMeta(
    'anneeSco',
  );
  @override
  late final GeneratedColumn<String> anneeSco = GeneratedColumn<String>(
    'annee_sco',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _estActifMeta = const VerificationMeta(
    'estActif',
  );
  @override
  late final GeneratedColumn<bool> estActif = GeneratedColumn<bool>(
    'est_actif',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("est_actif" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _dateMiseAJourMeta = const VerificationMeta(
    'dateMiseAJour',
  );
  @override
  late final GeneratedColumn<int> dateMiseAJour = GeneratedColumn<int>(
    'date_mise_a_jour',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    userId,
    ecoleId,
    niveauId,
    anneeSco,
    estActif,
    dateMiseAJour,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sie_appartenance';
  @override
  VerificationContext validateIntegrity(
    Insertable<Appartenance> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('ecole_id')) {
      context.handle(
        _ecoleIdMeta,
        ecoleId.isAcceptableOrUnknown(data['ecole_id']!, _ecoleIdMeta),
      );
    } else if (isInserting) {
      context.missing(_ecoleIdMeta);
    }
    if (data.containsKey('niveau_id')) {
      context.handle(
        _niveauIdMeta,
        niveauId.isAcceptableOrUnknown(data['niveau_id']!, _niveauIdMeta),
      );
    }
    if (data.containsKey('annee_sco')) {
      context.handle(
        _anneeScoMeta,
        anneeSco.isAcceptableOrUnknown(data['annee_sco']!, _anneeScoMeta),
      );
    } else if (isInserting) {
      context.missing(_anneeScoMeta);
    }
    if (data.containsKey('est_actif')) {
      context.handle(
        _estActifMeta,
        estActif.isAcceptableOrUnknown(data['est_actif']!, _estActifMeta),
      );
    }
    if (data.containsKey('date_mise_a_jour')) {
      context.handle(
        _dateMiseAJourMeta,
        dateMiseAJour.isAcceptableOrUnknown(
          data['date_mise_a_jour']!,
          _dateMiseAJourMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_dateMiseAJourMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Appartenance map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Appartenance(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      ecoleId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ecole_id'],
      )!,
      niveauId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}niveau_id'],
      ),
      anneeSco: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}annee_sco'],
      )!,
      estActif: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}est_actif'],
      )!,
      dateMiseAJour: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}date_mise_a_jour'],
      )!,
    );
  }

  @override
  $AppartenancesTable createAlias(String alias) {
    return $AppartenancesTable(attachedDatabase, alias);
  }
}

class Appartenance extends DataClass implements Insertable<Appartenance> {
  final String id;
  final String userId;
  final String ecoleId;
  final String? niveauId;
  final String anneeSco;
  final bool estActif;
  final int dateMiseAJour;
  const Appartenance({
    required this.id,
    required this.userId,
    required this.ecoleId,
    this.niveauId,
    required this.anneeSco,
    required this.estActif,
    required this.dateMiseAJour,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['user_id'] = Variable<String>(userId);
    map['ecole_id'] = Variable<String>(ecoleId);
    if (!nullToAbsent || niveauId != null) {
      map['niveau_id'] = Variable<String>(niveauId);
    }
    map['annee_sco'] = Variable<String>(anneeSco);
    map['est_actif'] = Variable<bool>(estActif);
    map['date_mise_a_jour'] = Variable<int>(dateMiseAJour);
    return map;
  }

  AppartenancesCompanion toCompanion(bool nullToAbsent) {
    return AppartenancesCompanion(
      id: Value(id),
      userId: Value(userId),
      ecoleId: Value(ecoleId),
      niveauId: niveauId == null && nullToAbsent
          ? const Value.absent()
          : Value(niveauId),
      anneeSco: Value(anneeSco),
      estActif: Value(estActif),
      dateMiseAJour: Value(dateMiseAJour),
    );
  }

  factory Appartenance.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Appartenance(
      id: serializer.fromJson<String>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      ecoleId: serializer.fromJson<String>(json['ecoleId']),
      niveauId: serializer.fromJson<String?>(json['niveauId']),
      anneeSco: serializer.fromJson<String>(json['anneeSco']),
      estActif: serializer.fromJson<bool>(json['estActif']),
      dateMiseAJour: serializer.fromJson<int>(json['dateMiseAJour']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'userId': serializer.toJson<String>(userId),
      'ecoleId': serializer.toJson<String>(ecoleId),
      'niveauId': serializer.toJson<String?>(niveauId),
      'anneeSco': serializer.toJson<String>(anneeSco),
      'estActif': serializer.toJson<bool>(estActif),
      'dateMiseAJour': serializer.toJson<int>(dateMiseAJour),
    };
  }

  Appartenance copyWith({
    String? id,
    String? userId,
    String? ecoleId,
    Value<String?> niveauId = const Value.absent(),
    String? anneeSco,
    bool? estActif,
    int? dateMiseAJour,
  }) => Appartenance(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    ecoleId: ecoleId ?? this.ecoleId,
    niveauId: niveauId.present ? niveauId.value : this.niveauId,
    anneeSco: anneeSco ?? this.anneeSco,
    estActif: estActif ?? this.estActif,
    dateMiseAJour: dateMiseAJour ?? this.dateMiseAJour,
  );
  Appartenance copyWithCompanion(AppartenancesCompanion data) {
    return Appartenance(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      ecoleId: data.ecoleId.present ? data.ecoleId.value : this.ecoleId,
      niveauId: data.niveauId.present ? data.niveauId.value : this.niveauId,
      anneeSco: data.anneeSco.present ? data.anneeSco.value : this.anneeSco,
      estActif: data.estActif.present ? data.estActif.value : this.estActif,
      dateMiseAJour: data.dateMiseAJour.present
          ? data.dateMiseAJour.value
          : this.dateMiseAJour,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Appartenance(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('ecoleId: $ecoleId, ')
          ..write('niveauId: $niveauId, ')
          ..write('anneeSco: $anneeSco, ')
          ..write('estActif: $estActif, ')
          ..write('dateMiseAJour: $dateMiseAJour')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    userId,
    ecoleId,
    niveauId,
    anneeSco,
    estActif,
    dateMiseAJour,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Appartenance &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.ecoleId == this.ecoleId &&
          other.niveauId == this.niveauId &&
          other.anneeSco == this.anneeSco &&
          other.estActif == this.estActif &&
          other.dateMiseAJour == this.dateMiseAJour);
}

class AppartenancesCompanion extends UpdateCompanion<Appartenance> {
  final Value<String> id;
  final Value<String> userId;
  final Value<String> ecoleId;
  final Value<String?> niveauId;
  final Value<String> anneeSco;
  final Value<bool> estActif;
  final Value<int> dateMiseAJour;
  final Value<int> rowid;
  const AppartenancesCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.ecoleId = const Value.absent(),
    this.niveauId = const Value.absent(),
    this.anneeSco = const Value.absent(),
    this.estActif = const Value.absent(),
    this.dateMiseAJour = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AppartenancesCompanion.insert({
    required String id,
    required String userId,
    required String ecoleId,
    this.niveauId = const Value.absent(),
    required String anneeSco,
    this.estActif = const Value.absent(),
    required int dateMiseAJour,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       userId = Value(userId),
       ecoleId = Value(ecoleId),
       anneeSco = Value(anneeSco),
       dateMiseAJour = Value(dateMiseAJour);
  static Insertable<Appartenance> custom({
    Expression<String>? id,
    Expression<String>? userId,
    Expression<String>? ecoleId,
    Expression<String>? niveauId,
    Expression<String>? anneeSco,
    Expression<bool>? estActif,
    Expression<int>? dateMiseAJour,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (ecoleId != null) 'ecole_id': ecoleId,
      if (niveauId != null) 'niveau_id': niveauId,
      if (anneeSco != null) 'annee_sco': anneeSco,
      if (estActif != null) 'est_actif': estActif,
      if (dateMiseAJour != null) 'date_mise_a_jour': dateMiseAJour,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AppartenancesCompanion copyWith({
    Value<String>? id,
    Value<String>? userId,
    Value<String>? ecoleId,
    Value<String?>? niveauId,
    Value<String>? anneeSco,
    Value<bool>? estActif,
    Value<int>? dateMiseAJour,
    Value<int>? rowid,
  }) {
    return AppartenancesCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      ecoleId: ecoleId ?? this.ecoleId,
      niveauId: niveauId ?? this.niveauId,
      anneeSco: anneeSco ?? this.anneeSco,
      estActif: estActif ?? this.estActif,
      dateMiseAJour: dateMiseAJour ?? this.dateMiseAJour,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (ecoleId.present) {
      map['ecole_id'] = Variable<String>(ecoleId.value);
    }
    if (niveauId.present) {
      map['niveau_id'] = Variable<String>(niveauId.value);
    }
    if (anneeSco.present) {
      map['annee_sco'] = Variable<String>(anneeSco.value);
    }
    if (estActif.present) {
      map['est_actif'] = Variable<bool>(estActif.value);
    }
    if (dateMiseAJour.present) {
      map['date_mise_a_jour'] = Variable<int>(dateMiseAJour.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppartenancesCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('ecoleId: $ecoleId, ')
          ..write('niveauId: $niveauId, ')
          ..write('anneeSco: $anneeSco, ')
          ..write('estActif: $estActif, ')
          ..write('dateMiseAJour: $dateMiseAJour, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MatieresTable extends Matieres with TableInfo<$MatieresTable, Matiere> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MatieresTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nomMeta = const VerificationMeta('nom');
  @override
  late final GeneratedColumn<String> nom = GeneratedColumn<String>(
    'nom',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _codeMatiereMeta = const VerificationMeta(
    'codeMatiere',
  );
  @override
  late final GeneratedColumn<String> codeMatiere = GeneratedColumn<String>(
    'code_matiere',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  @override
  List<GeneratedColumn> get $columns => [id, nom, codeMatiere];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sie_matieres';
  @override
  VerificationContext validateIntegrity(
    Insertable<Matiere> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('nom')) {
      context.handle(
        _nomMeta,
        nom.isAcceptableOrUnknown(data['nom']!, _nomMeta),
      );
    } else if (isInserting) {
      context.missing(_nomMeta);
    }
    if (data.containsKey('code_matiere')) {
      context.handle(
        _codeMatiereMeta,
        codeMatiere.isAcceptableOrUnknown(
          data['code_matiere']!,
          _codeMatiereMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Matiere map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Matiere(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      nom: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nom'],
      )!,
      codeMatiere: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}code_matiere'],
      ),
    );
  }

  @override
  $MatieresTable createAlias(String alias) {
    return $MatieresTable(attachedDatabase, alias);
  }
}

class Matiere extends DataClass implements Insertable<Matiere> {
  final String id;
  final String nom;
  final String? codeMatiere;
  const Matiere({required this.id, required this.nom, this.codeMatiere});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['nom'] = Variable<String>(nom);
    if (!nullToAbsent || codeMatiere != null) {
      map['code_matiere'] = Variable<String>(codeMatiere);
    }
    return map;
  }

  MatieresCompanion toCompanion(bool nullToAbsent) {
    return MatieresCompanion(
      id: Value(id),
      nom: Value(nom),
      codeMatiere: codeMatiere == null && nullToAbsent
          ? const Value.absent()
          : Value(codeMatiere),
    );
  }

  factory Matiere.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Matiere(
      id: serializer.fromJson<String>(json['id']),
      nom: serializer.fromJson<String>(json['nom']),
      codeMatiere: serializer.fromJson<String?>(json['codeMatiere']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'nom': serializer.toJson<String>(nom),
      'codeMatiere': serializer.toJson<String?>(codeMatiere),
    };
  }

  Matiere copyWith({
    String? id,
    String? nom,
    Value<String?> codeMatiere = const Value.absent(),
  }) => Matiere(
    id: id ?? this.id,
    nom: nom ?? this.nom,
    codeMatiere: codeMatiere.present ? codeMatiere.value : this.codeMatiere,
  );
  Matiere copyWithCompanion(MatieresCompanion data) {
    return Matiere(
      id: data.id.present ? data.id.value : this.id,
      nom: data.nom.present ? data.nom.value : this.nom,
      codeMatiere: data.codeMatiere.present
          ? data.codeMatiere.value
          : this.codeMatiere,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Matiere(')
          ..write('id: $id, ')
          ..write('nom: $nom, ')
          ..write('codeMatiere: $codeMatiere')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, nom, codeMatiere);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Matiere &&
          other.id == this.id &&
          other.nom == this.nom &&
          other.codeMatiere == this.codeMatiere);
}

class MatieresCompanion extends UpdateCompanion<Matiere> {
  final Value<String> id;
  final Value<String> nom;
  final Value<String?> codeMatiere;
  final Value<int> rowid;
  const MatieresCompanion({
    this.id = const Value.absent(),
    this.nom = const Value.absent(),
    this.codeMatiere = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MatieresCompanion.insert({
    required String id,
    required String nom,
    this.codeMatiere = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       nom = Value(nom);
  static Insertable<Matiere> custom({
    Expression<String>? id,
    Expression<String>? nom,
    Expression<String>? codeMatiere,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nom != null) 'nom': nom,
      if (codeMatiere != null) 'code_matiere': codeMatiere,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MatieresCompanion copyWith({
    Value<String>? id,
    Value<String>? nom,
    Value<String?>? codeMatiere,
    Value<int>? rowid,
  }) {
    return MatieresCompanion(
      id: id ?? this.id,
      nom: nom ?? this.nom,
      codeMatiere: codeMatiere ?? this.codeMatiere,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (nom.present) {
      map['nom'] = Variable<String>(nom.value);
    }
    if (codeMatiere.present) {
      map['code_matiere'] = Variable<String>(codeMatiere.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MatieresCompanion(')
          ..write('id: $id, ')
          ..write('nom: $nom, ')
          ..write('codeMatiere: $codeMatiere, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LeconsTable extends Lecons with TableInfo<$LeconsTable, Lecon> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LeconsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titreMeta = const VerificationMeta('titre');
  @override
  late final GeneratedColumn<String> titre = GeneratedColumn<String>(
    'titre',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _contenuBrutMeta = const VerificationMeta(
    'contenuBrut',
  );
  @override
  late final GeneratedColumn<String> contenuBrut = GeneratedColumn<String>(
    'contenu_brut',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _contenuStylMeta = const VerificationMeta(
    'contenuStyl',
  );
  @override
  late final GeneratedColumn<String> contenuStyl = GeneratedColumn<String>(
    'contenu_styl',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _visibiliteMeta = const VerificationMeta(
    'visibilite',
  );
  @override
  late final GeneratedColumn<String> visibilite = GeneratedColumn<String>(
    'visibilite',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('PRIVE'),
  );
  static const VerificationMeta _auteurIdMeta = const VerificationMeta(
    'auteurId',
  );
  @override
  late final GeneratedColumn<String> auteurId = GeneratedColumn<String>(
    'auteur_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES sie_utilisateurs (id)',
    ),
  );
  static const VerificationMeta _matiereIdMeta = const VerificationMeta(
    'matiereId',
  );
  @override
  late final GeneratedColumn<String> matiereId = GeneratedColumn<String>(
    'matiere_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES sie_matieres (id)',
    ),
  );
  static const VerificationMeta _niveauIdMeta = const VerificationMeta(
    'niveauId',
  );
  @override
  late final GeneratedColumn<String> niveauId = GeneratedColumn<String>(
    'niveau_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES sie_niveaux (id)',
    ),
  );
  static const VerificationMeta _ecoleIdMeta = const VerificationMeta(
    'ecoleId',
  );
  @override
  late final GeneratedColumn<String> ecoleId = GeneratedColumn<String>(
    'ecole_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES sie_ecole (id)',
    ),
  );
  static const VerificationMeta _dateUpdMeta = const VerificationMeta(
    'dateUpd',
  );
  @override
  late final GeneratedColumn<int> dateUpd = GeneratedColumn<int>(
    'date_upd',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateDelMeta = const VerificationMeta(
    'dateDel',
  );
  @override
  late final GeneratedColumn<int> dateDel = GeneratedColumn<int>(
    'date_del',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sourceTypeMeta = const VerificationMeta(
    'sourceType',
  );
  @override
  late final GeneratedColumn<String> sourceType = GeneratedColumn<String>(
    'source_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('scan'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    titre,
    contenuBrut,
    contenuStyl,
    visibilite,
    auteurId,
    matiereId,
    niveauId,
    ecoleId,
    dateUpd,
    dateDel,
    sourceType,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sie_lecon';
  @override
  VerificationContext validateIntegrity(
    Insertable<Lecon> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('titre')) {
      context.handle(
        _titreMeta,
        titre.isAcceptableOrUnknown(data['titre']!, _titreMeta),
      );
    } else if (isInserting) {
      context.missing(_titreMeta);
    }
    if (data.containsKey('contenu_brut')) {
      context.handle(
        _contenuBrutMeta,
        contenuBrut.isAcceptableOrUnknown(
          data['contenu_brut']!,
          _contenuBrutMeta,
        ),
      );
    }
    if (data.containsKey('contenu_styl')) {
      context.handle(
        _contenuStylMeta,
        contenuStyl.isAcceptableOrUnknown(
          data['contenu_styl']!,
          _contenuStylMeta,
        ),
      );
    }
    if (data.containsKey('visibilite')) {
      context.handle(
        _visibiliteMeta,
        visibilite.isAcceptableOrUnknown(data['visibilite']!, _visibiliteMeta),
      );
    }
    if (data.containsKey('auteur_id')) {
      context.handle(
        _auteurIdMeta,
        auteurId.isAcceptableOrUnknown(data['auteur_id']!, _auteurIdMeta),
      );
    }
    if (data.containsKey('matiere_id')) {
      context.handle(
        _matiereIdMeta,
        matiereId.isAcceptableOrUnknown(data['matiere_id']!, _matiereIdMeta),
      );
    }
    if (data.containsKey('niveau_id')) {
      context.handle(
        _niveauIdMeta,
        niveauId.isAcceptableOrUnknown(data['niveau_id']!, _niveauIdMeta),
      );
    }
    if (data.containsKey('ecole_id')) {
      context.handle(
        _ecoleIdMeta,
        ecoleId.isAcceptableOrUnknown(data['ecole_id']!, _ecoleIdMeta),
      );
    }
    if (data.containsKey('date_upd')) {
      context.handle(
        _dateUpdMeta,
        dateUpd.isAcceptableOrUnknown(data['date_upd']!, _dateUpdMeta),
      );
    } else if (isInserting) {
      context.missing(_dateUpdMeta);
    }
    if (data.containsKey('date_del')) {
      context.handle(
        _dateDelMeta,
        dateDel.isAcceptableOrUnknown(data['date_del']!, _dateDelMeta),
      );
    }
    if (data.containsKey('source_type')) {
      context.handle(
        _sourceTypeMeta,
        sourceType.isAcceptableOrUnknown(data['source_type']!, _sourceTypeMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Lecon map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Lecon(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      titre: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}titre'],
      )!,
      contenuBrut: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}contenu_brut'],
      ),
      contenuStyl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}contenu_styl'],
      ),
      visibilite: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}visibilite'],
      )!,
      auteurId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}auteur_id'],
      ),
      matiereId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}matiere_id'],
      ),
      niveauId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}niveau_id'],
      ),
      ecoleId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ecole_id'],
      ),
      dateUpd: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}date_upd'],
      )!,
      dateDel: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}date_del'],
      ),
      sourceType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_type'],
      )!,
    );
  }

  @override
  $LeconsTable createAlias(String alias) {
    return $LeconsTable(attachedDatabase, alias);
  }
}

class Lecon extends DataClass implements Insertable<Lecon> {
  final String id;
  final String titre;
  final String? contenuBrut;
  final String? contenuStyl;
  final String visibilite;
  final String? auteurId;
  final String? matiereId;
  final String? niveauId;
  final String? ecoleId;
  final int dateUpd;
  final int? dateDel;
  final String sourceType;
  const Lecon({
    required this.id,
    required this.titre,
    this.contenuBrut,
    this.contenuStyl,
    required this.visibilite,
    this.auteurId,
    this.matiereId,
    this.niveauId,
    this.ecoleId,
    required this.dateUpd,
    this.dateDel,
    required this.sourceType,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['titre'] = Variable<String>(titre);
    if (!nullToAbsent || contenuBrut != null) {
      map['contenu_brut'] = Variable<String>(contenuBrut);
    }
    if (!nullToAbsent || contenuStyl != null) {
      map['contenu_styl'] = Variable<String>(contenuStyl);
    }
    map['visibilite'] = Variable<String>(visibilite);
    if (!nullToAbsent || auteurId != null) {
      map['auteur_id'] = Variable<String>(auteurId);
    }
    if (!nullToAbsent || matiereId != null) {
      map['matiere_id'] = Variable<String>(matiereId);
    }
    if (!nullToAbsent || niveauId != null) {
      map['niveau_id'] = Variable<String>(niveauId);
    }
    if (!nullToAbsent || ecoleId != null) {
      map['ecole_id'] = Variable<String>(ecoleId);
    }
    map['date_upd'] = Variable<int>(dateUpd);
    if (!nullToAbsent || dateDel != null) {
      map['date_del'] = Variable<int>(dateDel);
    }
    map['source_type'] = Variable<String>(sourceType);
    return map;
  }

  LeconsCompanion toCompanion(bool nullToAbsent) {
    return LeconsCompanion(
      id: Value(id),
      titre: Value(titre),
      contenuBrut: contenuBrut == null && nullToAbsent
          ? const Value.absent()
          : Value(contenuBrut),
      contenuStyl: contenuStyl == null && nullToAbsent
          ? const Value.absent()
          : Value(contenuStyl),
      visibilite: Value(visibilite),
      auteurId: auteurId == null && nullToAbsent
          ? const Value.absent()
          : Value(auteurId),
      matiereId: matiereId == null && nullToAbsent
          ? const Value.absent()
          : Value(matiereId),
      niveauId: niveauId == null && nullToAbsent
          ? const Value.absent()
          : Value(niveauId),
      ecoleId: ecoleId == null && nullToAbsent
          ? const Value.absent()
          : Value(ecoleId),
      dateUpd: Value(dateUpd),
      dateDel: dateDel == null && nullToAbsent
          ? const Value.absent()
          : Value(dateDel),
      sourceType: Value(sourceType),
    );
  }

  factory Lecon.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Lecon(
      id: serializer.fromJson<String>(json['id']),
      titre: serializer.fromJson<String>(json['titre']),
      contenuBrut: serializer.fromJson<String?>(json['contenuBrut']),
      contenuStyl: serializer.fromJson<String?>(json['contenuStyl']),
      visibilite: serializer.fromJson<String>(json['visibilite']),
      auteurId: serializer.fromJson<String?>(json['auteurId']),
      matiereId: serializer.fromJson<String?>(json['matiereId']),
      niveauId: serializer.fromJson<String?>(json['niveauId']),
      ecoleId: serializer.fromJson<String?>(json['ecoleId']),
      dateUpd: serializer.fromJson<int>(json['dateUpd']),
      dateDel: serializer.fromJson<int?>(json['dateDel']),
      sourceType: serializer.fromJson<String>(json['sourceType']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'titre': serializer.toJson<String>(titre),
      'contenuBrut': serializer.toJson<String?>(contenuBrut),
      'contenuStyl': serializer.toJson<String?>(contenuStyl),
      'visibilite': serializer.toJson<String>(visibilite),
      'auteurId': serializer.toJson<String?>(auteurId),
      'matiereId': serializer.toJson<String?>(matiereId),
      'niveauId': serializer.toJson<String?>(niveauId),
      'ecoleId': serializer.toJson<String?>(ecoleId),
      'dateUpd': serializer.toJson<int>(dateUpd),
      'dateDel': serializer.toJson<int?>(dateDel),
      'sourceType': serializer.toJson<String>(sourceType),
    };
  }

  Lecon copyWith({
    String? id,
    String? titre,
    Value<String?> contenuBrut = const Value.absent(),
    Value<String?> contenuStyl = const Value.absent(),
    String? visibilite,
    Value<String?> auteurId = const Value.absent(),
    Value<String?> matiereId = const Value.absent(),
    Value<String?> niveauId = const Value.absent(),
    Value<String?> ecoleId = const Value.absent(),
    int? dateUpd,
    Value<int?> dateDel = const Value.absent(),
    String? sourceType,
  }) => Lecon(
    id: id ?? this.id,
    titre: titre ?? this.titre,
    contenuBrut: contenuBrut.present ? contenuBrut.value : this.contenuBrut,
    contenuStyl: contenuStyl.present ? contenuStyl.value : this.contenuStyl,
    visibilite: visibilite ?? this.visibilite,
    auteurId: auteurId.present ? auteurId.value : this.auteurId,
    matiereId: matiereId.present ? matiereId.value : this.matiereId,
    niveauId: niveauId.present ? niveauId.value : this.niveauId,
    ecoleId: ecoleId.present ? ecoleId.value : this.ecoleId,
    dateUpd: dateUpd ?? this.dateUpd,
    dateDel: dateDel.present ? dateDel.value : this.dateDel,
    sourceType: sourceType ?? this.sourceType,
  );
  Lecon copyWithCompanion(LeconsCompanion data) {
    return Lecon(
      id: data.id.present ? data.id.value : this.id,
      titre: data.titre.present ? data.titre.value : this.titre,
      contenuBrut: data.contenuBrut.present
          ? data.contenuBrut.value
          : this.contenuBrut,
      contenuStyl: data.contenuStyl.present
          ? data.contenuStyl.value
          : this.contenuStyl,
      visibilite: data.visibilite.present
          ? data.visibilite.value
          : this.visibilite,
      auteurId: data.auteurId.present ? data.auteurId.value : this.auteurId,
      matiereId: data.matiereId.present ? data.matiereId.value : this.matiereId,
      niveauId: data.niveauId.present ? data.niveauId.value : this.niveauId,
      ecoleId: data.ecoleId.present ? data.ecoleId.value : this.ecoleId,
      dateUpd: data.dateUpd.present ? data.dateUpd.value : this.dateUpd,
      dateDel: data.dateDel.present ? data.dateDel.value : this.dateDel,
      sourceType: data.sourceType.present
          ? data.sourceType.value
          : this.sourceType,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Lecon(')
          ..write('id: $id, ')
          ..write('titre: $titre, ')
          ..write('contenuBrut: $contenuBrut, ')
          ..write('contenuStyl: $contenuStyl, ')
          ..write('visibilite: $visibilite, ')
          ..write('auteurId: $auteurId, ')
          ..write('matiereId: $matiereId, ')
          ..write('niveauId: $niveauId, ')
          ..write('ecoleId: $ecoleId, ')
          ..write('dateUpd: $dateUpd, ')
          ..write('dateDel: $dateDel, ')
          ..write('sourceType: $sourceType')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    titre,
    contenuBrut,
    contenuStyl,
    visibilite,
    auteurId,
    matiereId,
    niveauId,
    ecoleId,
    dateUpd,
    dateDel,
    sourceType,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Lecon &&
          other.id == this.id &&
          other.titre == this.titre &&
          other.contenuBrut == this.contenuBrut &&
          other.contenuStyl == this.contenuStyl &&
          other.visibilite == this.visibilite &&
          other.auteurId == this.auteurId &&
          other.matiereId == this.matiereId &&
          other.niveauId == this.niveauId &&
          other.ecoleId == this.ecoleId &&
          other.dateUpd == this.dateUpd &&
          other.dateDel == this.dateDel &&
          other.sourceType == this.sourceType);
}

class LeconsCompanion extends UpdateCompanion<Lecon> {
  final Value<String> id;
  final Value<String> titre;
  final Value<String?> contenuBrut;
  final Value<String?> contenuStyl;
  final Value<String> visibilite;
  final Value<String?> auteurId;
  final Value<String?> matiereId;
  final Value<String?> niveauId;
  final Value<String?> ecoleId;
  final Value<int> dateUpd;
  final Value<int?> dateDel;
  final Value<String> sourceType;
  final Value<int> rowid;
  const LeconsCompanion({
    this.id = const Value.absent(),
    this.titre = const Value.absent(),
    this.contenuBrut = const Value.absent(),
    this.contenuStyl = const Value.absent(),
    this.visibilite = const Value.absent(),
    this.auteurId = const Value.absent(),
    this.matiereId = const Value.absent(),
    this.niveauId = const Value.absent(),
    this.ecoleId = const Value.absent(),
    this.dateUpd = const Value.absent(),
    this.dateDel = const Value.absent(),
    this.sourceType = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LeconsCompanion.insert({
    required String id,
    required String titre,
    this.contenuBrut = const Value.absent(),
    this.contenuStyl = const Value.absent(),
    this.visibilite = const Value.absent(),
    this.auteurId = const Value.absent(),
    this.matiereId = const Value.absent(),
    this.niveauId = const Value.absent(),
    this.ecoleId = const Value.absent(),
    required int dateUpd,
    this.dateDel = const Value.absent(),
    this.sourceType = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       titre = Value(titre),
       dateUpd = Value(dateUpd);
  static Insertable<Lecon> custom({
    Expression<String>? id,
    Expression<String>? titre,
    Expression<String>? contenuBrut,
    Expression<String>? contenuStyl,
    Expression<String>? visibilite,
    Expression<String>? auteurId,
    Expression<String>? matiereId,
    Expression<String>? niveauId,
    Expression<String>? ecoleId,
    Expression<int>? dateUpd,
    Expression<int>? dateDel,
    Expression<String>? sourceType,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (titre != null) 'titre': titre,
      if (contenuBrut != null) 'contenu_brut': contenuBrut,
      if (contenuStyl != null) 'contenu_styl': contenuStyl,
      if (visibilite != null) 'visibilite': visibilite,
      if (auteurId != null) 'auteur_id': auteurId,
      if (matiereId != null) 'matiere_id': matiereId,
      if (niveauId != null) 'niveau_id': niveauId,
      if (ecoleId != null) 'ecole_id': ecoleId,
      if (dateUpd != null) 'date_upd': dateUpd,
      if (dateDel != null) 'date_del': dateDel,
      if (sourceType != null) 'source_type': sourceType,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LeconsCompanion copyWith({
    Value<String>? id,
    Value<String>? titre,
    Value<String?>? contenuBrut,
    Value<String?>? contenuStyl,
    Value<String>? visibilite,
    Value<String?>? auteurId,
    Value<String?>? matiereId,
    Value<String?>? niveauId,
    Value<String?>? ecoleId,
    Value<int>? dateUpd,
    Value<int?>? dateDel,
    Value<String>? sourceType,
    Value<int>? rowid,
  }) {
    return LeconsCompanion(
      id: id ?? this.id,
      titre: titre ?? this.titre,
      contenuBrut: contenuBrut ?? this.contenuBrut,
      contenuStyl: contenuStyl ?? this.contenuStyl,
      visibilite: visibilite ?? this.visibilite,
      auteurId: auteurId ?? this.auteurId,
      matiereId: matiereId ?? this.matiereId,
      niveauId: niveauId ?? this.niveauId,
      ecoleId: ecoleId ?? this.ecoleId,
      dateUpd: dateUpd ?? this.dateUpd,
      dateDel: dateDel ?? this.dateDel,
      sourceType: sourceType ?? this.sourceType,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (titre.present) {
      map['titre'] = Variable<String>(titre.value);
    }
    if (contenuBrut.present) {
      map['contenu_brut'] = Variable<String>(contenuBrut.value);
    }
    if (contenuStyl.present) {
      map['contenu_styl'] = Variable<String>(contenuStyl.value);
    }
    if (visibilite.present) {
      map['visibilite'] = Variable<String>(visibilite.value);
    }
    if (auteurId.present) {
      map['auteur_id'] = Variable<String>(auteurId.value);
    }
    if (matiereId.present) {
      map['matiere_id'] = Variable<String>(matiereId.value);
    }
    if (niveauId.present) {
      map['niveau_id'] = Variable<String>(niveauId.value);
    }
    if (ecoleId.present) {
      map['ecole_id'] = Variable<String>(ecoleId.value);
    }
    if (dateUpd.present) {
      map['date_upd'] = Variable<int>(dateUpd.value);
    }
    if (dateDel.present) {
      map['date_del'] = Variable<int>(dateDel.value);
    }
    if (sourceType.present) {
      map['source_type'] = Variable<String>(sourceType.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LeconsCompanion(')
          ..write('id: $id, ')
          ..write('titre: $titre, ')
          ..write('contenuBrut: $contenuBrut, ')
          ..write('contenuStyl: $contenuStyl, ')
          ..write('visibilite: $visibilite, ')
          ..write('auteurId: $auteurId, ')
          ..write('matiereId: $matiereId, ')
          ..write('niveauId: $niveauId, ')
          ..write('ecoleId: $ecoleId, ')
          ..write('dateUpd: $dateUpd, ')
          ..write('dateDel: $dateDel, ')
          ..write('sourceType: $sourceType, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CurriculumsTable extends Curriculums
    with TableInfo<$CurriculumsTable, Curriculum> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CurriculumsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ecoleIdMeta = const VerificationMeta(
    'ecoleId',
  );
  @override
  late final GeneratedColumn<String> ecoleId = GeneratedColumn<String>(
    'ecole_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES sie_ecole (id)',
    ),
  );
  static const VerificationMeta _niveauIdMeta = const VerificationMeta(
    'niveauId',
  );
  @override
  late final GeneratedColumn<String> niveauId = GeneratedColumn<String>(
    'niveau_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES sie_niveaux (id)',
    ),
  );
  static const VerificationMeta _matiereIdMeta = const VerificationMeta(
    'matiereId',
  );
  @override
  late final GeneratedColumn<String> matiereId = GeneratedColumn<String>(
    'matiere_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES sie_matieres (id)',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [id, ecoleId, niveauId, matiereId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sie_curriculum';
  @override
  VerificationContext validateIntegrity(
    Insertable<Curriculum> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('ecole_id')) {
      context.handle(
        _ecoleIdMeta,
        ecoleId.isAcceptableOrUnknown(data['ecole_id']!, _ecoleIdMeta),
      );
    } else if (isInserting) {
      context.missing(_ecoleIdMeta);
    }
    if (data.containsKey('niveau_id')) {
      context.handle(
        _niveauIdMeta,
        niveauId.isAcceptableOrUnknown(data['niveau_id']!, _niveauIdMeta),
      );
    } else if (isInserting) {
      context.missing(_niveauIdMeta);
    }
    if (data.containsKey('matiere_id')) {
      context.handle(
        _matiereIdMeta,
        matiereId.isAcceptableOrUnknown(data['matiere_id']!, _matiereIdMeta),
      );
    } else if (isInserting) {
      context.missing(_matiereIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {ecoleId, niveauId, matiereId},
  ];
  @override
  Curriculum map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Curriculum(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      ecoleId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ecole_id'],
      )!,
      niveauId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}niveau_id'],
      )!,
      matiereId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}matiere_id'],
      )!,
    );
  }

  @override
  $CurriculumsTable createAlias(String alias) {
    return $CurriculumsTable(attachedDatabase, alias);
  }
}

class Curriculum extends DataClass implements Insertable<Curriculum> {
  final String id;
  final String ecoleId;
  final String niveauId;
  final String matiereId;
  const Curriculum({
    required this.id,
    required this.ecoleId,
    required this.niveauId,
    required this.matiereId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['ecole_id'] = Variable<String>(ecoleId);
    map['niveau_id'] = Variable<String>(niveauId);
    map['matiere_id'] = Variable<String>(matiereId);
    return map;
  }

  CurriculumsCompanion toCompanion(bool nullToAbsent) {
    return CurriculumsCompanion(
      id: Value(id),
      ecoleId: Value(ecoleId),
      niveauId: Value(niveauId),
      matiereId: Value(matiereId),
    );
  }

  factory Curriculum.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Curriculum(
      id: serializer.fromJson<String>(json['id']),
      ecoleId: serializer.fromJson<String>(json['ecoleId']),
      niveauId: serializer.fromJson<String>(json['niveauId']),
      matiereId: serializer.fromJson<String>(json['matiereId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'ecoleId': serializer.toJson<String>(ecoleId),
      'niveauId': serializer.toJson<String>(niveauId),
      'matiereId': serializer.toJson<String>(matiereId),
    };
  }

  Curriculum copyWith({
    String? id,
    String? ecoleId,
    String? niveauId,
    String? matiereId,
  }) => Curriculum(
    id: id ?? this.id,
    ecoleId: ecoleId ?? this.ecoleId,
    niveauId: niveauId ?? this.niveauId,
    matiereId: matiereId ?? this.matiereId,
  );
  Curriculum copyWithCompanion(CurriculumsCompanion data) {
    return Curriculum(
      id: data.id.present ? data.id.value : this.id,
      ecoleId: data.ecoleId.present ? data.ecoleId.value : this.ecoleId,
      niveauId: data.niveauId.present ? data.niveauId.value : this.niveauId,
      matiereId: data.matiereId.present ? data.matiereId.value : this.matiereId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Curriculum(')
          ..write('id: $id, ')
          ..write('ecoleId: $ecoleId, ')
          ..write('niveauId: $niveauId, ')
          ..write('matiereId: $matiereId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, ecoleId, niveauId, matiereId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Curriculum &&
          other.id == this.id &&
          other.ecoleId == this.ecoleId &&
          other.niveauId == this.niveauId &&
          other.matiereId == this.matiereId);
}

class CurriculumsCompanion extends UpdateCompanion<Curriculum> {
  final Value<String> id;
  final Value<String> ecoleId;
  final Value<String> niveauId;
  final Value<String> matiereId;
  final Value<int> rowid;
  const CurriculumsCompanion({
    this.id = const Value.absent(),
    this.ecoleId = const Value.absent(),
    this.niveauId = const Value.absent(),
    this.matiereId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CurriculumsCompanion.insert({
    required String id,
    required String ecoleId,
    required String niveauId,
    required String matiereId,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       ecoleId = Value(ecoleId),
       niveauId = Value(niveauId),
       matiereId = Value(matiereId);
  static Insertable<Curriculum> custom({
    Expression<String>? id,
    Expression<String>? ecoleId,
    Expression<String>? niveauId,
    Expression<String>? matiereId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (ecoleId != null) 'ecole_id': ecoleId,
      if (niveauId != null) 'niveau_id': niveauId,
      if (matiereId != null) 'matiere_id': matiereId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CurriculumsCompanion copyWith({
    Value<String>? id,
    Value<String>? ecoleId,
    Value<String>? niveauId,
    Value<String>? matiereId,
    Value<int>? rowid,
  }) {
    return CurriculumsCompanion(
      id: id ?? this.id,
      ecoleId: ecoleId ?? this.ecoleId,
      niveauId: niveauId ?? this.niveauId,
      matiereId: matiereId ?? this.matiereId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (ecoleId.present) {
      map['ecole_id'] = Variable<String>(ecoleId.value);
    }
    if (niveauId.present) {
      map['niveau_id'] = Variable<String>(niveauId.value);
    }
    if (matiereId.present) {
      map['matiere_id'] = Variable<String>(matiereId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CurriculumsCompanion(')
          ..write('id: $id, ')
          ..write('ecoleId: $ecoleId, ')
          ..write('niveauId: $niveauId, ')
          ..write('matiereId: $matiereId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PagesTable extends Pages with TableInfo<$PagesTable, Page> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PagesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _leconIdMeta = const VerificationMeta(
    'leconId',
  );
  @override
  late final GeneratedColumn<String> leconId = GeneratedColumn<String>(
    'lecon_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES sie_lecon (id)',
    ),
  );
  static const VerificationMeta _numeroPageMeta = const VerificationMeta(
    'numeroPage',
  );
  @override
  late final GeneratedColumn<int> numeroPage = GeneratedColumn<int>(
    'numero_page',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cheminImageMeta = const VerificationMeta(
    'cheminImage',
  );
  @override
  late final GeneratedColumn<String> cheminImage = GeneratedColumn<String>(
    'chemin_image',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _ocrTexteMeta = const VerificationMeta(
    'ocrTexte',
  );
  @override
  late final GeneratedColumn<String> ocrTexte = GeneratedColumn<String>(
    'ocr_texte',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _contenuStylMeta = const VerificationMeta(
    'contenuStyl',
  );
  @override
  late final GeneratedColumn<String> contenuStyl = GeneratedColumn<String>(
    'contenu_styl',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _ordreMeta = const VerificationMeta('ordre');
  @override
  late final GeneratedColumn<int> ordre = GeneratedColumn<int>(
    'ordre',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    leconId,
    numeroPage,
    cheminImage,
    ocrTexte,
    contenuStyl,
    ordre,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sie_pages';
  @override
  VerificationContext validateIntegrity(
    Insertable<Page> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('lecon_id')) {
      context.handle(
        _leconIdMeta,
        leconId.isAcceptableOrUnknown(data['lecon_id']!, _leconIdMeta),
      );
    } else if (isInserting) {
      context.missing(_leconIdMeta);
    }
    if (data.containsKey('numero_page')) {
      context.handle(
        _numeroPageMeta,
        numeroPage.isAcceptableOrUnknown(data['numero_page']!, _numeroPageMeta),
      );
    } else if (isInserting) {
      context.missing(_numeroPageMeta);
    }
    if (data.containsKey('chemin_image')) {
      context.handle(
        _cheminImageMeta,
        cheminImage.isAcceptableOrUnknown(
          data['chemin_image']!,
          _cheminImageMeta,
        ),
      );
    }
    if (data.containsKey('ocr_texte')) {
      context.handle(
        _ocrTexteMeta,
        ocrTexte.isAcceptableOrUnknown(data['ocr_texte']!, _ocrTexteMeta),
      );
    }
    if (data.containsKey('contenu_styl')) {
      context.handle(
        _contenuStylMeta,
        contenuStyl.isAcceptableOrUnknown(
          data['contenu_styl']!,
          _contenuStylMeta,
        ),
      );
    }
    if (data.containsKey('ordre')) {
      context.handle(
        _ordreMeta,
        ordre.isAcceptableOrUnknown(data['ordre']!, _ordreMeta),
      );
    } else if (isInserting) {
      context.missing(_ordreMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Page map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Page(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      leconId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}lecon_id'],
      )!,
      numeroPage: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}numero_page'],
      )!,
      cheminImage: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}chemin_image'],
      ),
      ocrTexte: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ocr_texte'],
      ),
      contenuStyl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}contenu_styl'],
      ),
      ordre: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}ordre'],
      )!,
    );
  }

  @override
  $PagesTable createAlias(String alias) {
    return $PagesTable(attachedDatabase, alias);
  }
}

class Page extends DataClass implements Insertable<Page> {
  final String id;
  final String leconId;
  final int numeroPage;
  final String? cheminImage;
  final String? ocrTexte;
  final String? contenuStyl;
  final int ordre;
  const Page({
    required this.id,
    required this.leconId,
    required this.numeroPage,
    this.cheminImage,
    this.ocrTexte,
    this.contenuStyl,
    required this.ordre,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['lecon_id'] = Variable<String>(leconId);
    map['numero_page'] = Variable<int>(numeroPage);
    if (!nullToAbsent || cheminImage != null) {
      map['chemin_image'] = Variable<String>(cheminImage);
    }
    if (!nullToAbsent || ocrTexte != null) {
      map['ocr_texte'] = Variable<String>(ocrTexte);
    }
    if (!nullToAbsent || contenuStyl != null) {
      map['contenu_styl'] = Variable<String>(contenuStyl);
    }
    map['ordre'] = Variable<int>(ordre);
    return map;
  }

  PagesCompanion toCompanion(bool nullToAbsent) {
    return PagesCompanion(
      id: Value(id),
      leconId: Value(leconId),
      numeroPage: Value(numeroPage),
      cheminImage: cheminImage == null && nullToAbsent
          ? const Value.absent()
          : Value(cheminImage),
      ocrTexte: ocrTexte == null && nullToAbsent
          ? const Value.absent()
          : Value(ocrTexte),
      contenuStyl: contenuStyl == null && nullToAbsent
          ? const Value.absent()
          : Value(contenuStyl),
      ordre: Value(ordre),
    );
  }

  factory Page.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Page(
      id: serializer.fromJson<String>(json['id']),
      leconId: serializer.fromJson<String>(json['leconId']),
      numeroPage: serializer.fromJson<int>(json['numeroPage']),
      cheminImage: serializer.fromJson<String?>(json['cheminImage']),
      ocrTexte: serializer.fromJson<String?>(json['ocrTexte']),
      contenuStyl: serializer.fromJson<String?>(json['contenuStyl']),
      ordre: serializer.fromJson<int>(json['ordre']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'leconId': serializer.toJson<String>(leconId),
      'numeroPage': serializer.toJson<int>(numeroPage),
      'cheminImage': serializer.toJson<String?>(cheminImage),
      'ocrTexte': serializer.toJson<String?>(ocrTexte),
      'contenuStyl': serializer.toJson<String?>(contenuStyl),
      'ordre': serializer.toJson<int>(ordre),
    };
  }

  Page copyWith({
    String? id,
    String? leconId,
    int? numeroPage,
    Value<String?> cheminImage = const Value.absent(),
    Value<String?> ocrTexte = const Value.absent(),
    Value<String?> contenuStyl = const Value.absent(),
    int? ordre,
  }) => Page(
    id: id ?? this.id,
    leconId: leconId ?? this.leconId,
    numeroPage: numeroPage ?? this.numeroPage,
    cheminImage: cheminImage.present ? cheminImage.value : this.cheminImage,
    ocrTexte: ocrTexte.present ? ocrTexte.value : this.ocrTexte,
    contenuStyl: contenuStyl.present ? contenuStyl.value : this.contenuStyl,
    ordre: ordre ?? this.ordre,
  );
  Page copyWithCompanion(PagesCompanion data) {
    return Page(
      id: data.id.present ? data.id.value : this.id,
      leconId: data.leconId.present ? data.leconId.value : this.leconId,
      numeroPage: data.numeroPage.present
          ? data.numeroPage.value
          : this.numeroPage,
      cheminImage: data.cheminImage.present
          ? data.cheminImage.value
          : this.cheminImage,
      ocrTexte: data.ocrTexte.present ? data.ocrTexte.value : this.ocrTexte,
      contenuStyl: data.contenuStyl.present
          ? data.contenuStyl.value
          : this.contenuStyl,
      ordre: data.ordre.present ? data.ordre.value : this.ordre,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Page(')
          ..write('id: $id, ')
          ..write('leconId: $leconId, ')
          ..write('numeroPage: $numeroPage, ')
          ..write('cheminImage: $cheminImage, ')
          ..write('ocrTexte: $ocrTexte, ')
          ..write('contenuStyl: $contenuStyl, ')
          ..write('ordre: $ordre')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    leconId,
    numeroPage,
    cheminImage,
    ocrTexte,
    contenuStyl,
    ordre,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Page &&
          other.id == this.id &&
          other.leconId == this.leconId &&
          other.numeroPage == this.numeroPage &&
          other.cheminImage == this.cheminImage &&
          other.ocrTexte == this.ocrTexte &&
          other.contenuStyl == this.contenuStyl &&
          other.ordre == this.ordre);
}

class PagesCompanion extends UpdateCompanion<Page> {
  final Value<String> id;
  final Value<String> leconId;
  final Value<int> numeroPage;
  final Value<String?> cheminImage;
  final Value<String?> ocrTexte;
  final Value<String?> contenuStyl;
  final Value<int> ordre;
  final Value<int> rowid;
  const PagesCompanion({
    this.id = const Value.absent(),
    this.leconId = const Value.absent(),
    this.numeroPage = const Value.absent(),
    this.cheminImage = const Value.absent(),
    this.ocrTexte = const Value.absent(),
    this.contenuStyl = const Value.absent(),
    this.ordre = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PagesCompanion.insert({
    required String id,
    required String leconId,
    required int numeroPage,
    this.cheminImage = const Value.absent(),
    this.ocrTexte = const Value.absent(),
    this.contenuStyl = const Value.absent(),
    required int ordre,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       leconId = Value(leconId),
       numeroPage = Value(numeroPage),
       ordre = Value(ordre);
  static Insertable<Page> custom({
    Expression<String>? id,
    Expression<String>? leconId,
    Expression<int>? numeroPage,
    Expression<String>? cheminImage,
    Expression<String>? ocrTexte,
    Expression<String>? contenuStyl,
    Expression<int>? ordre,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (leconId != null) 'lecon_id': leconId,
      if (numeroPage != null) 'numero_page': numeroPage,
      if (cheminImage != null) 'chemin_image': cheminImage,
      if (ocrTexte != null) 'ocr_texte': ocrTexte,
      if (contenuStyl != null) 'contenu_styl': contenuStyl,
      if (ordre != null) 'ordre': ordre,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PagesCompanion copyWith({
    Value<String>? id,
    Value<String>? leconId,
    Value<int>? numeroPage,
    Value<String?>? cheminImage,
    Value<String?>? ocrTexte,
    Value<String?>? contenuStyl,
    Value<int>? ordre,
    Value<int>? rowid,
  }) {
    return PagesCompanion(
      id: id ?? this.id,
      leconId: leconId ?? this.leconId,
      numeroPage: numeroPage ?? this.numeroPage,
      cheminImage: cheminImage ?? this.cheminImage,
      ocrTexte: ocrTexte ?? this.ocrTexte,
      contenuStyl: contenuStyl ?? this.contenuStyl,
      ordre: ordre ?? this.ordre,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (leconId.present) {
      map['lecon_id'] = Variable<String>(leconId.value);
    }
    if (numeroPage.present) {
      map['numero_page'] = Variable<int>(numeroPage.value);
    }
    if (cheminImage.present) {
      map['chemin_image'] = Variable<String>(cheminImage.value);
    }
    if (ocrTexte.present) {
      map['ocr_texte'] = Variable<String>(ocrTexte.value);
    }
    if (contenuStyl.present) {
      map['contenu_styl'] = Variable<String>(contenuStyl.value);
    }
    if (ordre.present) {
      map['ordre'] = Variable<int>(ordre.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PagesCompanion(')
          ..write('id: $id, ')
          ..write('leconId: $leconId, ')
          ..write('numeroPage: $numeroPage, ')
          ..write('cheminImage: $cheminImage, ')
          ..write('ocrTexte: $ocrTexte, ')
          ..write('contenuStyl: $contenuStyl, ')
          ..write('ordre: $ordre, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $FlashcardsTable extends Flashcards
    with TableInfo<$FlashcardsTable, Flashcard> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FlashcardsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ecoleIdMeta = const VerificationMeta(
    'ecoleId',
  );
  @override
  late final GeneratedColumn<String> ecoleId = GeneratedColumn<String>(
    'ecole_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES sie_ecole (id)',
    ),
  );
  static const VerificationMeta _niveauIdMeta = const VerificationMeta(
    'niveauId',
  );
  @override
  late final GeneratedColumn<String> niveauId = GeneratedColumn<String>(
    'niveau_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES sie_niveaux (id)',
    ),
  );
  static const VerificationMeta _leconIdMeta = const VerificationMeta(
    'leconId',
  );
  @override
  late final GeneratedColumn<String> leconId = GeneratedColumn<String>(
    'lecon_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES sie_lecon (id)',
    ),
  );
  static const VerificationMeta _matiereIdMeta = const VerificationMeta(
    'matiereId',
  );
  @override
  late final GeneratedColumn<String> matiereId = GeneratedColumn<String>(
    'matiere_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES sie_matieres (id)',
    ),
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES sie_utilisateurs (id)',
    ),
  );
  static const VerificationMeta _questionMeta = const VerificationMeta(
    'question',
  );
  @override
  late final GeneratedColumn<String> question = GeneratedColumn<String>(
    'question',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _reponseMeta = const VerificationMeta(
    'reponse',
  );
  @override
  late final GeneratedColumn<String> reponse = GeneratedColumn<String>(
    'reponse',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _explicationMeta = const VerificationMeta(
    'explication',
  );
  @override
  late final GeneratedColumn<String> explication = GeneratedColumn<String>(
    'explication',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _intervalDaysMeta = const VerificationMeta(
    'intervalDays',
  );
  @override
  late final GeneratedColumn<int> intervalDays = GeneratedColumn<int>(
    'interval_days',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _repetitionsMeta = const VerificationMeta(
    'repetitions',
  );
  @override
  late final GeneratedColumn<int> repetitions = GeneratedColumn<int>(
    'repetitions',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _easinessFactorMeta = const VerificationMeta(
    'easinessFactor',
  );
  @override
  late final GeneratedColumn<double> easinessFactor = GeneratedColumn<double>(
    'easiness_factor',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(2.5),
  );
  static const VerificationMeta _nextReviewDateMeta = const VerificationMeta(
    'nextReviewDate',
  );
  @override
  late final GeneratedColumn<int> nextReviewDate = GeneratedColumn<int>(
    'next_review_date',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    ecoleId,
    niveauId,
    leconId,
    matiereId,
    userId,
    question,
    reponse,
    explication,
    intervalDays,
    repetitions,
    easinessFactor,
    nextReviewDate,
    isActive,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'flashcards';
  @override
  VerificationContext validateIntegrity(
    Insertable<Flashcard> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('ecole_id')) {
      context.handle(
        _ecoleIdMeta,
        ecoleId.isAcceptableOrUnknown(data['ecole_id']!, _ecoleIdMeta),
      );
    }
    if (data.containsKey('niveau_id')) {
      context.handle(
        _niveauIdMeta,
        niveauId.isAcceptableOrUnknown(data['niveau_id']!, _niveauIdMeta),
      );
    }
    if (data.containsKey('lecon_id')) {
      context.handle(
        _leconIdMeta,
        leconId.isAcceptableOrUnknown(data['lecon_id']!, _leconIdMeta),
      );
    }
    if (data.containsKey('matiere_id')) {
      context.handle(
        _matiereIdMeta,
        matiereId.isAcceptableOrUnknown(data['matiere_id']!, _matiereIdMeta),
      );
    } else if (isInserting) {
      context.missing(_matiereIdMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('question')) {
      context.handle(
        _questionMeta,
        question.isAcceptableOrUnknown(data['question']!, _questionMeta),
      );
    } else if (isInserting) {
      context.missing(_questionMeta);
    }
    if (data.containsKey('reponse')) {
      context.handle(
        _reponseMeta,
        reponse.isAcceptableOrUnknown(data['reponse']!, _reponseMeta),
      );
    } else if (isInserting) {
      context.missing(_reponseMeta);
    }
    if (data.containsKey('explication')) {
      context.handle(
        _explicationMeta,
        explication.isAcceptableOrUnknown(
          data['explication']!,
          _explicationMeta,
        ),
      );
    }
    if (data.containsKey('interval_days')) {
      context.handle(
        _intervalDaysMeta,
        intervalDays.isAcceptableOrUnknown(
          data['interval_days']!,
          _intervalDaysMeta,
        ),
      );
    }
    if (data.containsKey('repetitions')) {
      context.handle(
        _repetitionsMeta,
        repetitions.isAcceptableOrUnknown(
          data['repetitions']!,
          _repetitionsMeta,
        ),
      );
    }
    if (data.containsKey('easiness_factor')) {
      context.handle(
        _easinessFactorMeta,
        easinessFactor.isAcceptableOrUnknown(
          data['easiness_factor']!,
          _easinessFactorMeta,
        ),
      );
    }
    if (data.containsKey('next_review_date')) {
      context.handle(
        _nextReviewDateMeta,
        nextReviewDate.isAcceptableOrUnknown(
          data['next_review_date']!,
          _nextReviewDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_nextReviewDateMeta);
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Flashcard map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Flashcard(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      ecoleId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ecole_id'],
      ),
      niveauId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}niveau_id'],
      ),
      leconId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}lecon_id'],
      ),
      matiereId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}matiere_id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      question: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}question'],
      )!,
      reponse: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reponse'],
      )!,
      explication: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}explication'],
      ),
      intervalDays: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}interval_days'],
      )!,
      repetitions: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}repetitions'],
      )!,
      easinessFactor: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}easiness_factor'],
      )!,
      nextReviewDate: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}next_review_date'],
      )!,
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $FlashcardsTable createAlias(String alias) {
    return $FlashcardsTable(attachedDatabase, alias);
  }
}

class Flashcard extends DataClass implements Insertable<Flashcard> {
  final String id;
  final String? ecoleId;
  final String? niveauId;
  final String? leconId;
  final String matiereId;
  final String userId;
  final String question;
  final String reponse;
  final String? explication;
  final int intervalDays;
  final int repetitions;
  final double easinessFactor;
  final int nextReviewDate;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Flashcard({
    required this.id,
    this.ecoleId,
    this.niveauId,
    this.leconId,
    required this.matiereId,
    required this.userId,
    required this.question,
    required this.reponse,
    this.explication,
    required this.intervalDays,
    required this.repetitions,
    required this.easinessFactor,
    required this.nextReviewDate,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || ecoleId != null) {
      map['ecole_id'] = Variable<String>(ecoleId);
    }
    if (!nullToAbsent || niveauId != null) {
      map['niveau_id'] = Variable<String>(niveauId);
    }
    if (!nullToAbsent || leconId != null) {
      map['lecon_id'] = Variable<String>(leconId);
    }
    map['matiere_id'] = Variable<String>(matiereId);
    map['user_id'] = Variable<String>(userId);
    map['question'] = Variable<String>(question);
    map['reponse'] = Variable<String>(reponse);
    if (!nullToAbsent || explication != null) {
      map['explication'] = Variable<String>(explication);
    }
    map['interval_days'] = Variable<int>(intervalDays);
    map['repetitions'] = Variable<int>(repetitions);
    map['easiness_factor'] = Variable<double>(easinessFactor);
    map['next_review_date'] = Variable<int>(nextReviewDate);
    map['is_active'] = Variable<bool>(isActive);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  FlashcardsCompanion toCompanion(bool nullToAbsent) {
    return FlashcardsCompanion(
      id: Value(id),
      ecoleId: ecoleId == null && nullToAbsent
          ? const Value.absent()
          : Value(ecoleId),
      niveauId: niveauId == null && nullToAbsent
          ? const Value.absent()
          : Value(niveauId),
      leconId: leconId == null && nullToAbsent
          ? const Value.absent()
          : Value(leconId),
      matiereId: Value(matiereId),
      userId: Value(userId),
      question: Value(question),
      reponse: Value(reponse),
      explication: explication == null && nullToAbsent
          ? const Value.absent()
          : Value(explication),
      intervalDays: Value(intervalDays),
      repetitions: Value(repetitions),
      easinessFactor: Value(easinessFactor),
      nextReviewDate: Value(nextReviewDate),
      isActive: Value(isActive),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Flashcard.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Flashcard(
      id: serializer.fromJson<String>(json['id']),
      ecoleId: serializer.fromJson<String?>(json['ecoleId']),
      niveauId: serializer.fromJson<String?>(json['niveauId']),
      leconId: serializer.fromJson<String?>(json['leconId']),
      matiereId: serializer.fromJson<String>(json['matiereId']),
      userId: serializer.fromJson<String>(json['userId']),
      question: serializer.fromJson<String>(json['question']),
      reponse: serializer.fromJson<String>(json['reponse']),
      explication: serializer.fromJson<String?>(json['explication']),
      intervalDays: serializer.fromJson<int>(json['intervalDays']),
      repetitions: serializer.fromJson<int>(json['repetitions']),
      easinessFactor: serializer.fromJson<double>(json['easinessFactor']),
      nextReviewDate: serializer.fromJson<int>(json['nextReviewDate']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'ecoleId': serializer.toJson<String?>(ecoleId),
      'niveauId': serializer.toJson<String?>(niveauId),
      'leconId': serializer.toJson<String?>(leconId),
      'matiereId': serializer.toJson<String>(matiereId),
      'userId': serializer.toJson<String>(userId),
      'question': serializer.toJson<String>(question),
      'reponse': serializer.toJson<String>(reponse),
      'explication': serializer.toJson<String?>(explication),
      'intervalDays': serializer.toJson<int>(intervalDays),
      'repetitions': serializer.toJson<int>(repetitions),
      'easinessFactor': serializer.toJson<double>(easinessFactor),
      'nextReviewDate': serializer.toJson<int>(nextReviewDate),
      'isActive': serializer.toJson<bool>(isActive),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Flashcard copyWith({
    String? id,
    Value<String?> ecoleId = const Value.absent(),
    Value<String?> niveauId = const Value.absent(),
    Value<String?> leconId = const Value.absent(),
    String? matiereId,
    String? userId,
    String? question,
    String? reponse,
    Value<String?> explication = const Value.absent(),
    int? intervalDays,
    int? repetitions,
    double? easinessFactor,
    int? nextReviewDate,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Flashcard(
    id: id ?? this.id,
    ecoleId: ecoleId.present ? ecoleId.value : this.ecoleId,
    niveauId: niveauId.present ? niveauId.value : this.niveauId,
    leconId: leconId.present ? leconId.value : this.leconId,
    matiereId: matiereId ?? this.matiereId,
    userId: userId ?? this.userId,
    question: question ?? this.question,
    reponse: reponse ?? this.reponse,
    explication: explication.present ? explication.value : this.explication,
    intervalDays: intervalDays ?? this.intervalDays,
    repetitions: repetitions ?? this.repetitions,
    easinessFactor: easinessFactor ?? this.easinessFactor,
    nextReviewDate: nextReviewDate ?? this.nextReviewDate,
    isActive: isActive ?? this.isActive,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Flashcard copyWithCompanion(FlashcardsCompanion data) {
    return Flashcard(
      id: data.id.present ? data.id.value : this.id,
      ecoleId: data.ecoleId.present ? data.ecoleId.value : this.ecoleId,
      niveauId: data.niveauId.present ? data.niveauId.value : this.niveauId,
      leconId: data.leconId.present ? data.leconId.value : this.leconId,
      matiereId: data.matiereId.present ? data.matiereId.value : this.matiereId,
      userId: data.userId.present ? data.userId.value : this.userId,
      question: data.question.present ? data.question.value : this.question,
      reponse: data.reponse.present ? data.reponse.value : this.reponse,
      explication: data.explication.present
          ? data.explication.value
          : this.explication,
      intervalDays: data.intervalDays.present
          ? data.intervalDays.value
          : this.intervalDays,
      repetitions: data.repetitions.present
          ? data.repetitions.value
          : this.repetitions,
      easinessFactor: data.easinessFactor.present
          ? data.easinessFactor.value
          : this.easinessFactor,
      nextReviewDate: data.nextReviewDate.present
          ? data.nextReviewDate.value
          : this.nextReviewDate,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Flashcard(')
          ..write('id: $id, ')
          ..write('ecoleId: $ecoleId, ')
          ..write('niveauId: $niveauId, ')
          ..write('leconId: $leconId, ')
          ..write('matiereId: $matiereId, ')
          ..write('userId: $userId, ')
          ..write('question: $question, ')
          ..write('reponse: $reponse, ')
          ..write('explication: $explication, ')
          ..write('intervalDays: $intervalDays, ')
          ..write('repetitions: $repetitions, ')
          ..write('easinessFactor: $easinessFactor, ')
          ..write('nextReviewDate: $nextReviewDate, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    ecoleId,
    niveauId,
    leconId,
    matiereId,
    userId,
    question,
    reponse,
    explication,
    intervalDays,
    repetitions,
    easinessFactor,
    nextReviewDate,
    isActive,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Flashcard &&
          other.id == this.id &&
          other.ecoleId == this.ecoleId &&
          other.niveauId == this.niveauId &&
          other.leconId == this.leconId &&
          other.matiereId == this.matiereId &&
          other.userId == this.userId &&
          other.question == this.question &&
          other.reponse == this.reponse &&
          other.explication == this.explication &&
          other.intervalDays == this.intervalDays &&
          other.repetitions == this.repetitions &&
          other.easinessFactor == this.easinessFactor &&
          other.nextReviewDate == this.nextReviewDate &&
          other.isActive == this.isActive &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class FlashcardsCompanion extends UpdateCompanion<Flashcard> {
  final Value<String> id;
  final Value<String?> ecoleId;
  final Value<String?> niveauId;
  final Value<String?> leconId;
  final Value<String> matiereId;
  final Value<String> userId;
  final Value<String> question;
  final Value<String> reponse;
  final Value<String?> explication;
  final Value<int> intervalDays;
  final Value<int> repetitions;
  final Value<double> easinessFactor;
  final Value<int> nextReviewDate;
  final Value<bool> isActive;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const FlashcardsCompanion({
    this.id = const Value.absent(),
    this.ecoleId = const Value.absent(),
    this.niveauId = const Value.absent(),
    this.leconId = const Value.absent(),
    this.matiereId = const Value.absent(),
    this.userId = const Value.absent(),
    this.question = const Value.absent(),
    this.reponse = const Value.absent(),
    this.explication = const Value.absent(),
    this.intervalDays = const Value.absent(),
    this.repetitions = const Value.absent(),
    this.easinessFactor = const Value.absent(),
    this.nextReviewDate = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FlashcardsCompanion.insert({
    required String id,
    this.ecoleId = const Value.absent(),
    this.niveauId = const Value.absent(),
    this.leconId = const Value.absent(),
    required String matiereId,
    required String userId,
    required String question,
    required String reponse,
    this.explication = const Value.absent(),
    this.intervalDays = const Value.absent(),
    this.repetitions = const Value.absent(),
    this.easinessFactor = const Value.absent(),
    required int nextReviewDate,
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       matiereId = Value(matiereId),
       userId = Value(userId),
       question = Value(question),
       reponse = Value(reponse),
       nextReviewDate = Value(nextReviewDate);
  static Insertable<Flashcard> custom({
    Expression<String>? id,
    Expression<String>? ecoleId,
    Expression<String>? niveauId,
    Expression<String>? leconId,
    Expression<String>? matiereId,
    Expression<String>? userId,
    Expression<String>? question,
    Expression<String>? reponse,
    Expression<String>? explication,
    Expression<int>? intervalDays,
    Expression<int>? repetitions,
    Expression<double>? easinessFactor,
    Expression<int>? nextReviewDate,
    Expression<bool>? isActive,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (ecoleId != null) 'ecole_id': ecoleId,
      if (niveauId != null) 'niveau_id': niveauId,
      if (leconId != null) 'lecon_id': leconId,
      if (matiereId != null) 'matiere_id': matiereId,
      if (userId != null) 'user_id': userId,
      if (question != null) 'question': question,
      if (reponse != null) 'reponse': reponse,
      if (explication != null) 'explication': explication,
      if (intervalDays != null) 'interval_days': intervalDays,
      if (repetitions != null) 'repetitions': repetitions,
      if (easinessFactor != null) 'easiness_factor': easinessFactor,
      if (nextReviewDate != null) 'next_review_date': nextReviewDate,
      if (isActive != null) 'is_active': isActive,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FlashcardsCompanion copyWith({
    Value<String>? id,
    Value<String?>? ecoleId,
    Value<String?>? niveauId,
    Value<String?>? leconId,
    Value<String>? matiereId,
    Value<String>? userId,
    Value<String>? question,
    Value<String>? reponse,
    Value<String?>? explication,
    Value<int>? intervalDays,
    Value<int>? repetitions,
    Value<double>? easinessFactor,
    Value<int>? nextReviewDate,
    Value<bool>? isActive,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return FlashcardsCompanion(
      id: id ?? this.id,
      ecoleId: ecoleId ?? this.ecoleId,
      niveauId: niveauId ?? this.niveauId,
      leconId: leconId ?? this.leconId,
      matiereId: matiereId ?? this.matiereId,
      userId: userId ?? this.userId,
      question: question ?? this.question,
      reponse: reponse ?? this.reponse,
      explication: explication ?? this.explication,
      intervalDays: intervalDays ?? this.intervalDays,
      repetitions: repetitions ?? this.repetitions,
      easinessFactor: easinessFactor ?? this.easinessFactor,
      nextReviewDate: nextReviewDate ?? this.nextReviewDate,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (ecoleId.present) {
      map['ecole_id'] = Variable<String>(ecoleId.value);
    }
    if (niveauId.present) {
      map['niveau_id'] = Variable<String>(niveauId.value);
    }
    if (leconId.present) {
      map['lecon_id'] = Variable<String>(leconId.value);
    }
    if (matiereId.present) {
      map['matiere_id'] = Variable<String>(matiereId.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (question.present) {
      map['question'] = Variable<String>(question.value);
    }
    if (reponse.present) {
      map['reponse'] = Variable<String>(reponse.value);
    }
    if (explication.present) {
      map['explication'] = Variable<String>(explication.value);
    }
    if (intervalDays.present) {
      map['interval_days'] = Variable<int>(intervalDays.value);
    }
    if (repetitions.present) {
      map['repetitions'] = Variable<int>(repetitions.value);
    }
    if (easinessFactor.present) {
      map['easiness_factor'] = Variable<double>(easinessFactor.value);
    }
    if (nextReviewDate.present) {
      map['next_review_date'] = Variable<int>(nextReviewDate.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FlashcardsCompanion(')
          ..write('id: $id, ')
          ..write('ecoleId: $ecoleId, ')
          ..write('niveauId: $niveauId, ')
          ..write('leconId: $leconId, ')
          ..write('matiereId: $matiereId, ')
          ..write('userId: $userId, ')
          ..write('question: $question, ')
          ..write('reponse: $reponse, ')
          ..write('explication: $explication, ')
          ..write('intervalDays: $intervalDays, ')
          ..write('repetitions: $repetitions, ')
          ..write('easinessFactor: $easinessFactor, ')
          ..write('nextReviewDate: $nextReviewDate, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AssignationsEcoleTable extends AssignationsEcole
    with TableInfo<$AssignationsEcoleTable, AssignationEcole> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AssignationsEcoleTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ecoleIdMeta = const VerificationMeta(
    'ecoleId',
  );
  @override
  late final GeneratedColumn<String> ecoleId = GeneratedColumn<String>(
    'ecole_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _roleIdMeta = const VerificationMeta('roleId');
  @override
  late final GeneratedColumn<String> roleId = GeneratedColumn<String>(
    'role_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateDebutMeta = const VerificationMeta(
    'dateDebut',
  );
  @override
  late final GeneratedColumn<DateTime> dateDebut = GeneratedColumn<DateTime>(
    'date_debut',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateFinMeta = const VerificationMeta(
    'dateFin',
  );
  @override
  late final GeneratedColumn<DateTime> dateFin = GeneratedColumn<DateTime>(
    'date_fin',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _statutMeta = const VerificationMeta('statut');
  @override
  late final GeneratedColumn<String> statut = GeneratedColumn<String>(
    'statut',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('PENDING'),
  );
  static const VerificationMeta _estActifMeta = const VerificationMeta(
    'estActif',
  );
  @override
  late final GeneratedColumn<bool> estActif = GeneratedColumn<bool>(
    'est_actif',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("est_actif" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    userId,
    ecoleId,
    roleId,
    dateDebut,
    dateFin,
    statut,
    estActif,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'assignations_ecole';
  @override
  VerificationContext validateIntegrity(
    Insertable<AssignationEcole> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('ecole_id')) {
      context.handle(
        _ecoleIdMeta,
        ecoleId.isAcceptableOrUnknown(data['ecole_id']!, _ecoleIdMeta),
      );
    } else if (isInserting) {
      context.missing(_ecoleIdMeta);
    }
    if (data.containsKey('role_id')) {
      context.handle(
        _roleIdMeta,
        roleId.isAcceptableOrUnknown(data['role_id']!, _roleIdMeta),
      );
    } else if (isInserting) {
      context.missing(_roleIdMeta);
    }
    if (data.containsKey('date_debut')) {
      context.handle(
        _dateDebutMeta,
        dateDebut.isAcceptableOrUnknown(data['date_debut']!, _dateDebutMeta),
      );
    } else if (isInserting) {
      context.missing(_dateDebutMeta);
    }
    if (data.containsKey('date_fin')) {
      context.handle(
        _dateFinMeta,
        dateFin.isAcceptableOrUnknown(data['date_fin']!, _dateFinMeta),
      );
    }
    if (data.containsKey('statut')) {
      context.handle(
        _statutMeta,
        statut.isAcceptableOrUnknown(data['statut']!, _statutMeta),
      );
    }
    if (data.containsKey('est_actif')) {
      context.handle(
        _estActifMeta,
        estActif.isAcceptableOrUnknown(data['est_actif']!, _estActifMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AssignationEcole map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AssignationEcole(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      ecoleId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ecole_id'],
      )!,
      roleId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}role_id'],
      )!,
      dateDebut: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date_debut'],
      )!,
      dateFin: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date_fin'],
      ),
      statut: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}statut'],
      )!,
      estActif: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}est_actif'],
      )!,
    );
  }

  @override
  $AssignationsEcoleTable createAlias(String alias) {
    return $AssignationsEcoleTable(attachedDatabase, alias);
  }
}

class AssignationEcole extends DataClass
    implements Insertable<AssignationEcole> {
  final String id;
  final String userId;
  final String ecoleId;
  final String roleId;
  final DateTime dateDebut;
  final DateTime? dateFin;
  final String statut;
  final bool estActif;
  const AssignationEcole({
    required this.id,
    required this.userId,
    required this.ecoleId,
    required this.roleId,
    required this.dateDebut,
    this.dateFin,
    required this.statut,
    required this.estActif,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['user_id'] = Variable<String>(userId);
    map['ecole_id'] = Variable<String>(ecoleId);
    map['role_id'] = Variable<String>(roleId);
    map['date_debut'] = Variable<DateTime>(dateDebut);
    if (!nullToAbsent || dateFin != null) {
      map['date_fin'] = Variable<DateTime>(dateFin);
    }
    map['statut'] = Variable<String>(statut);
    map['est_actif'] = Variable<bool>(estActif);
    return map;
  }

  AssignationsEcoleCompanion toCompanion(bool nullToAbsent) {
    return AssignationsEcoleCompanion(
      id: Value(id),
      userId: Value(userId),
      ecoleId: Value(ecoleId),
      roleId: Value(roleId),
      dateDebut: Value(dateDebut),
      dateFin: dateFin == null && nullToAbsent
          ? const Value.absent()
          : Value(dateFin),
      statut: Value(statut),
      estActif: Value(estActif),
    );
  }

  factory AssignationEcole.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AssignationEcole(
      id: serializer.fromJson<String>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      ecoleId: serializer.fromJson<String>(json['ecoleId']),
      roleId: serializer.fromJson<String>(json['roleId']),
      dateDebut: serializer.fromJson<DateTime>(json['dateDebut']),
      dateFin: serializer.fromJson<DateTime?>(json['dateFin']),
      statut: serializer.fromJson<String>(json['statut']),
      estActif: serializer.fromJson<bool>(json['estActif']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'userId': serializer.toJson<String>(userId),
      'ecoleId': serializer.toJson<String>(ecoleId),
      'roleId': serializer.toJson<String>(roleId),
      'dateDebut': serializer.toJson<DateTime>(dateDebut),
      'dateFin': serializer.toJson<DateTime?>(dateFin),
      'statut': serializer.toJson<String>(statut),
      'estActif': serializer.toJson<bool>(estActif),
    };
  }

  AssignationEcole copyWith({
    String? id,
    String? userId,
    String? ecoleId,
    String? roleId,
    DateTime? dateDebut,
    Value<DateTime?> dateFin = const Value.absent(),
    String? statut,
    bool? estActif,
  }) => AssignationEcole(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    ecoleId: ecoleId ?? this.ecoleId,
    roleId: roleId ?? this.roleId,
    dateDebut: dateDebut ?? this.dateDebut,
    dateFin: dateFin.present ? dateFin.value : this.dateFin,
    statut: statut ?? this.statut,
    estActif: estActif ?? this.estActif,
  );
  AssignationEcole copyWithCompanion(AssignationsEcoleCompanion data) {
    return AssignationEcole(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      ecoleId: data.ecoleId.present ? data.ecoleId.value : this.ecoleId,
      roleId: data.roleId.present ? data.roleId.value : this.roleId,
      dateDebut: data.dateDebut.present ? data.dateDebut.value : this.dateDebut,
      dateFin: data.dateFin.present ? data.dateFin.value : this.dateFin,
      statut: data.statut.present ? data.statut.value : this.statut,
      estActif: data.estActif.present ? data.estActif.value : this.estActif,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AssignationEcole(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('ecoleId: $ecoleId, ')
          ..write('roleId: $roleId, ')
          ..write('dateDebut: $dateDebut, ')
          ..write('dateFin: $dateFin, ')
          ..write('statut: $statut, ')
          ..write('estActif: $estActif')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    userId,
    ecoleId,
    roleId,
    dateDebut,
    dateFin,
    statut,
    estActif,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AssignationEcole &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.ecoleId == this.ecoleId &&
          other.roleId == this.roleId &&
          other.dateDebut == this.dateDebut &&
          other.dateFin == this.dateFin &&
          other.statut == this.statut &&
          other.estActif == this.estActif);
}

class AssignationsEcoleCompanion extends UpdateCompanion<AssignationEcole> {
  final Value<String> id;
  final Value<String> userId;
  final Value<String> ecoleId;
  final Value<String> roleId;
  final Value<DateTime> dateDebut;
  final Value<DateTime?> dateFin;
  final Value<String> statut;
  final Value<bool> estActif;
  final Value<int> rowid;
  const AssignationsEcoleCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.ecoleId = const Value.absent(),
    this.roleId = const Value.absent(),
    this.dateDebut = const Value.absent(),
    this.dateFin = const Value.absent(),
    this.statut = const Value.absent(),
    this.estActif = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AssignationsEcoleCompanion.insert({
    required String id,
    required String userId,
    required String ecoleId,
    required String roleId,
    required DateTime dateDebut,
    this.dateFin = const Value.absent(),
    this.statut = const Value.absent(),
    this.estActif = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       userId = Value(userId),
       ecoleId = Value(ecoleId),
       roleId = Value(roleId),
       dateDebut = Value(dateDebut);
  static Insertable<AssignationEcole> custom({
    Expression<String>? id,
    Expression<String>? userId,
    Expression<String>? ecoleId,
    Expression<String>? roleId,
    Expression<DateTime>? dateDebut,
    Expression<DateTime>? dateFin,
    Expression<String>? statut,
    Expression<bool>? estActif,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (ecoleId != null) 'ecole_id': ecoleId,
      if (roleId != null) 'role_id': roleId,
      if (dateDebut != null) 'date_debut': dateDebut,
      if (dateFin != null) 'date_fin': dateFin,
      if (statut != null) 'statut': statut,
      if (estActif != null) 'est_actif': estActif,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AssignationsEcoleCompanion copyWith({
    Value<String>? id,
    Value<String>? userId,
    Value<String>? ecoleId,
    Value<String>? roleId,
    Value<DateTime>? dateDebut,
    Value<DateTime?>? dateFin,
    Value<String>? statut,
    Value<bool>? estActif,
    Value<int>? rowid,
  }) {
    return AssignationsEcoleCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      ecoleId: ecoleId ?? this.ecoleId,
      roleId: roleId ?? this.roleId,
      dateDebut: dateDebut ?? this.dateDebut,
      dateFin: dateFin ?? this.dateFin,
      statut: statut ?? this.statut,
      estActif: estActif ?? this.estActif,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (ecoleId.present) {
      map['ecole_id'] = Variable<String>(ecoleId.value);
    }
    if (roleId.present) {
      map['role_id'] = Variable<String>(roleId.value);
    }
    if (dateDebut.present) {
      map['date_debut'] = Variable<DateTime>(dateDebut.value);
    }
    if (dateFin.present) {
      map['date_fin'] = Variable<DateTime>(dateFin.value);
    }
    if (statut.present) {
      map['statut'] = Variable<String>(statut.value);
    }
    if (estActif.present) {
      map['est_actif'] = Variable<bool>(estActif.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AssignationsEcoleCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('ecoleId: $ecoleId, ')
          ..write('roleId: $roleId, ')
          ..write('dateDebut: $dateDebut, ')
          ..write('dateFin: $dateFin, ')
          ..write('statut: $statut, ')
          ..write('estActif: $estActif, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $RolesTable roles = $RolesTable(this);
  late final $PermissionsTable permissions = $PermissionsTable(this);
  late final $RolePermissionsTable rolePermissions = $RolePermissionsTable(
    this,
  );
  late final $EcolesTable ecoles = $EcolesTable(this);
  late final $NiveauxTable niveaux = $NiveauxTable(this);
  late final $UtilisateursTable utilisateurs = $UtilisateursTable(this);
  late final $AppartenancesTable appartenances = $AppartenancesTable(this);
  late final $MatieresTable matieres = $MatieresTable(this);
  late final $LeconsTable lecons = $LeconsTable(this);
  late final $CurriculumsTable curriculums = $CurriculumsTable(this);
  late final $PagesTable pages = $PagesTable(this);
  late final $FlashcardsTable flashcards = $FlashcardsTable(this);
  late final $AssignationsEcoleTable assignationsEcole =
      $AssignationsEcoleTable(this);
  late final LeconDao leconDao = LeconDao(this as AppDatabase);
  late final UtilisateurDao utilisateurDao = UtilisateurDao(
    this as AppDatabase,
  );
  late final MatiereDao matiereDao = MatiereDao(this as AppDatabase);
  late final RoleDao roleDao = RoleDao(this as AppDatabase);
  late final CurriculumDao curriculumDao = CurriculumDao(this as AppDatabase);
  late final AppartenanceDao appartenanceDao = AppartenanceDao(
    this as AppDatabase,
  );
  late final FlashcardDao flashcardDao = FlashcardDao(this as AppDatabase);
  late final NiveauDao niveauDao = NiveauDao(this as AppDatabase);
  late final EcoleDao ecoleDao = EcoleDao(this as AppDatabase);
  late final PageDao pageDao = PageDao(this as AppDatabase);
  late final AssignationEcoleDao assignationEcoleDao = AssignationEcoleDao(
    this as AppDatabase,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    roles,
    permissions,
    rolePermissions,
    ecoles,
    niveaux,
    utilisateurs,
    appartenances,
    matieres,
    lecons,
    curriculums,
    pages,
    flashcards,
    assignationsEcole,
  ];
}

typedef $$RolesTableCreateCompanionBuilder =
    RolesCompanion Function({
      required String id,
      required String nomRole,
      Value<String?> description,
      Value<int> rowid,
    });
typedef $$RolesTableUpdateCompanionBuilder =
    RolesCompanion Function({
      Value<String> id,
      Value<String> nomRole,
      Value<String?> description,
      Value<int> rowid,
    });

final class $$RolesTableReferences
    extends BaseReferences<_$AppDatabase, $RolesTable, Role> {
  $$RolesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$RolePermissionsTable, List<RolePermission>>
  _rolePermissionsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.rolePermissions,
    aliasName: $_aliasNameGenerator(db.roles.id, db.rolePermissions.roleId),
  );

  $$RolePermissionsTableProcessedTableManager get rolePermissionsRefs {
    final manager = $$RolePermissionsTableTableManager(
      $_db,
      $_db.rolePermissions,
    ).filter((f) => f.roleId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _rolePermissionsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$UtilisateursTable, List<Utilisateur>>
  _utilisateursRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.utilisateurs,
    aliasName: $_aliasNameGenerator(db.roles.id, db.utilisateurs.roleId),
  );

  $$UtilisateursTableProcessedTableManager get utilisateursRefs {
    final manager = $$UtilisateursTableTableManager(
      $_db,
      $_db.utilisateurs,
    ).filter((f) => f.roleId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_utilisateursRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$RolesTableFilterComposer extends Composer<_$AppDatabase, $RolesTable> {
  $$RolesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nomRole => $composableBuilder(
    column: $table.nomRole,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> rolePermissionsRefs(
    Expression<bool> Function($$RolePermissionsTableFilterComposer f) f,
  ) {
    final $$RolePermissionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.rolePermissions,
      getReferencedColumn: (t) => t.roleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RolePermissionsTableFilterComposer(
            $db: $db,
            $table: $db.rolePermissions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> utilisateursRefs(
    Expression<bool> Function($$UtilisateursTableFilterComposer f) f,
  ) {
    final $$UtilisateursTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.utilisateurs,
      getReferencedColumn: (t) => t.roleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UtilisateursTableFilterComposer(
            $db: $db,
            $table: $db.utilisateurs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$RolesTableOrderingComposer
    extends Composer<_$AppDatabase, $RolesTable> {
  $$RolesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nomRole => $composableBuilder(
    column: $table.nomRole,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$RolesTableAnnotationComposer
    extends Composer<_$AppDatabase, $RolesTable> {
  $$RolesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nomRole =>
      $composableBuilder(column: $table.nomRole, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  Expression<T> rolePermissionsRefs<T extends Object>(
    Expression<T> Function($$RolePermissionsTableAnnotationComposer a) f,
  ) {
    final $$RolePermissionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.rolePermissions,
      getReferencedColumn: (t) => t.roleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RolePermissionsTableAnnotationComposer(
            $db: $db,
            $table: $db.rolePermissions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> utilisateursRefs<T extends Object>(
    Expression<T> Function($$UtilisateursTableAnnotationComposer a) f,
  ) {
    final $$UtilisateursTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.utilisateurs,
      getReferencedColumn: (t) => t.roleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UtilisateursTableAnnotationComposer(
            $db: $db,
            $table: $db.utilisateurs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$RolesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RolesTable,
          Role,
          $$RolesTableFilterComposer,
          $$RolesTableOrderingComposer,
          $$RolesTableAnnotationComposer,
          $$RolesTableCreateCompanionBuilder,
          $$RolesTableUpdateCompanionBuilder,
          (Role, $$RolesTableReferences),
          Role,
          PrefetchHooks Function({
            bool rolePermissionsRefs,
            bool utilisateursRefs,
          })
        > {
  $$RolesTableTableManager(_$AppDatabase db, $RolesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RolesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RolesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RolesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> nomRole = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RolesCompanion(
                id: id,
                nomRole: nomRole,
                description: description,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String nomRole,
                Value<String?> description = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RolesCompanion.insert(
                id: id,
                nomRole: nomRole,
                description: description,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$RolesTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback:
              ({rolePermissionsRefs = false, utilisateursRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (rolePermissionsRefs) db.rolePermissions,
                    if (utilisateursRefs) db.utilisateurs,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (rolePermissionsRefs)
                        await $_getPrefetchedData<
                          Role,
                          $RolesTable,
                          RolePermission
                        >(
                          currentTable: table,
                          referencedTable: $$RolesTableReferences
                              ._rolePermissionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$RolesTableReferences(
                                db,
                                table,
                                p0,
                              ).rolePermissionsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.roleId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (utilisateursRefs)
                        await $_getPrefetchedData<
                          Role,
                          $RolesTable,
                          Utilisateur
                        >(
                          currentTable: table,
                          referencedTable: $$RolesTableReferences
                              ._utilisateursRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$RolesTableReferences(
                                db,
                                table,
                                p0,
                              ).utilisateursRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.roleId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$RolesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RolesTable,
      Role,
      $$RolesTableFilterComposer,
      $$RolesTableOrderingComposer,
      $$RolesTableAnnotationComposer,
      $$RolesTableCreateCompanionBuilder,
      $$RolesTableUpdateCompanionBuilder,
      (Role, $$RolesTableReferences),
      Role,
      PrefetchHooks Function({bool rolePermissionsRefs, bool utilisateursRefs})
    >;
typedef $$PermissionsTableCreateCompanionBuilder =
    PermissionsCompanion Function({
      required String id,
      required String code,
      Value<int> rowid,
    });
typedef $$PermissionsTableUpdateCompanionBuilder =
    PermissionsCompanion Function({
      Value<String> id,
      Value<String> code,
      Value<int> rowid,
    });

final class $$PermissionsTableReferences
    extends BaseReferences<_$AppDatabase, $PermissionsTable, Permission> {
  $$PermissionsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$RolePermissionsTable, List<RolePermission>>
  _rolePermissionsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.rolePermissions,
    aliasName: $_aliasNameGenerator(
      db.permissions.id,
      db.rolePermissions.permId,
    ),
  );

  $$RolePermissionsTableProcessedTableManager get rolePermissionsRefs {
    final manager = $$RolePermissionsTableTableManager(
      $_db,
      $_db.rolePermissions,
    ).filter((f) => f.permId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _rolePermissionsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$PermissionsTableFilterComposer
    extends Composer<_$AppDatabase, $PermissionsTable> {
  $$PermissionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> rolePermissionsRefs(
    Expression<bool> Function($$RolePermissionsTableFilterComposer f) f,
  ) {
    final $$RolePermissionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.rolePermissions,
      getReferencedColumn: (t) => t.permId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RolePermissionsTableFilterComposer(
            $db: $db,
            $table: $db.rolePermissions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PermissionsTableOrderingComposer
    extends Composer<_$AppDatabase, $PermissionsTable> {
  $$PermissionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PermissionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PermissionsTable> {
  $$PermissionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  Expression<T> rolePermissionsRefs<T extends Object>(
    Expression<T> Function($$RolePermissionsTableAnnotationComposer a) f,
  ) {
    final $$RolePermissionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.rolePermissions,
      getReferencedColumn: (t) => t.permId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RolePermissionsTableAnnotationComposer(
            $db: $db,
            $table: $db.rolePermissions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PermissionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PermissionsTable,
          Permission,
          $$PermissionsTableFilterComposer,
          $$PermissionsTableOrderingComposer,
          $$PermissionsTableAnnotationComposer,
          $$PermissionsTableCreateCompanionBuilder,
          $$PermissionsTableUpdateCompanionBuilder,
          (Permission, $$PermissionsTableReferences),
          Permission,
          PrefetchHooks Function({bool rolePermissionsRefs})
        > {
  $$PermissionsTableTableManager(_$AppDatabase db, $PermissionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PermissionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PermissionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PermissionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> code = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PermissionsCompanion(id: id, code: code, rowid: rowid),
          createCompanionCallback:
              ({
                required String id,
                required String code,
                Value<int> rowid = const Value.absent(),
              }) =>
                  PermissionsCompanion.insert(id: id, code: code, rowid: rowid),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PermissionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({rolePermissionsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (rolePermissionsRefs) db.rolePermissions,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (rolePermissionsRefs)
                    await $_getPrefetchedData<
                      Permission,
                      $PermissionsTable,
                      RolePermission
                    >(
                      currentTable: table,
                      referencedTable: $$PermissionsTableReferences
                          ._rolePermissionsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$PermissionsTableReferences(
                            db,
                            table,
                            p0,
                          ).rolePermissionsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.permId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$PermissionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PermissionsTable,
      Permission,
      $$PermissionsTableFilterComposer,
      $$PermissionsTableOrderingComposer,
      $$PermissionsTableAnnotationComposer,
      $$PermissionsTableCreateCompanionBuilder,
      $$PermissionsTableUpdateCompanionBuilder,
      (Permission, $$PermissionsTableReferences),
      Permission,
      PrefetchHooks Function({bool rolePermissionsRefs})
    >;
typedef $$RolePermissionsTableCreateCompanionBuilder =
    RolePermissionsCompanion Function({
      required String roleId,
      required String permId,
      Value<int> rowid,
    });
typedef $$RolePermissionsTableUpdateCompanionBuilder =
    RolePermissionsCompanion Function({
      Value<String> roleId,
      Value<String> permId,
      Value<int> rowid,
    });

final class $$RolePermissionsTableReferences
    extends
        BaseReferences<_$AppDatabase, $RolePermissionsTable, RolePermission> {
  $$RolePermissionsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $RolesTable _roleIdTable(_$AppDatabase db) => db.roles.createAlias(
    $_aliasNameGenerator(db.rolePermissions.roleId, db.roles.id),
  );

  $$RolesTableProcessedTableManager get roleId {
    final $_column = $_itemColumn<String>('role_id')!;

    final manager = $$RolesTableTableManager(
      $_db,
      $_db.roles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_roleIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $PermissionsTable _permIdTable(_$AppDatabase db) =>
      db.permissions.createAlias(
        $_aliasNameGenerator(db.rolePermissions.permId, db.permissions.id),
      );

  $$PermissionsTableProcessedTableManager get permId {
    final $_column = $_itemColumn<String>('perm_id')!;

    final manager = $$PermissionsTableTableManager(
      $_db,
      $_db.permissions,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_permIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$RolePermissionsTableFilterComposer
    extends Composer<_$AppDatabase, $RolePermissionsTable> {
  $$RolePermissionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$RolesTableFilterComposer get roleId {
    final $$RolesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.roleId,
      referencedTable: $db.roles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RolesTableFilterComposer(
            $db: $db,
            $table: $db.roles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PermissionsTableFilterComposer get permId {
    final $$PermissionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.permId,
      referencedTable: $db.permissions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PermissionsTableFilterComposer(
            $db: $db,
            $table: $db.permissions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RolePermissionsTableOrderingComposer
    extends Composer<_$AppDatabase, $RolePermissionsTable> {
  $$RolePermissionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$RolesTableOrderingComposer get roleId {
    final $$RolesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.roleId,
      referencedTable: $db.roles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RolesTableOrderingComposer(
            $db: $db,
            $table: $db.roles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PermissionsTableOrderingComposer get permId {
    final $$PermissionsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.permId,
      referencedTable: $db.permissions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PermissionsTableOrderingComposer(
            $db: $db,
            $table: $db.permissions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RolePermissionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $RolePermissionsTable> {
  $$RolePermissionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$RolesTableAnnotationComposer get roleId {
    final $$RolesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.roleId,
      referencedTable: $db.roles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RolesTableAnnotationComposer(
            $db: $db,
            $table: $db.roles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PermissionsTableAnnotationComposer get permId {
    final $$PermissionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.permId,
      referencedTable: $db.permissions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PermissionsTableAnnotationComposer(
            $db: $db,
            $table: $db.permissions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RolePermissionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RolePermissionsTable,
          RolePermission,
          $$RolePermissionsTableFilterComposer,
          $$RolePermissionsTableOrderingComposer,
          $$RolePermissionsTableAnnotationComposer,
          $$RolePermissionsTableCreateCompanionBuilder,
          $$RolePermissionsTableUpdateCompanionBuilder,
          (RolePermission, $$RolePermissionsTableReferences),
          RolePermission,
          PrefetchHooks Function({bool roleId, bool permId})
        > {
  $$RolePermissionsTableTableManager(
    _$AppDatabase db,
    $RolePermissionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RolePermissionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RolePermissionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RolePermissionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> roleId = const Value.absent(),
                Value<String> permId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RolePermissionsCompanion(
                roleId: roleId,
                permId: permId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String roleId,
                required String permId,
                Value<int> rowid = const Value.absent(),
              }) => RolePermissionsCompanion.insert(
                roleId: roleId,
                permId: permId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$RolePermissionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({roleId = false, permId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (roleId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.roleId,
                                referencedTable:
                                    $$RolePermissionsTableReferences
                                        ._roleIdTable(db),
                                referencedColumn:
                                    $$RolePermissionsTableReferences
                                        ._roleIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (permId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.permId,
                                referencedTable:
                                    $$RolePermissionsTableReferences
                                        ._permIdTable(db),
                                referencedColumn:
                                    $$RolePermissionsTableReferences
                                        ._permIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$RolePermissionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RolePermissionsTable,
      RolePermission,
      $$RolePermissionsTableFilterComposer,
      $$RolePermissionsTableOrderingComposer,
      $$RolePermissionsTableAnnotationComposer,
      $$RolePermissionsTableCreateCompanionBuilder,
      $$RolePermissionsTableUpdateCompanionBuilder,
      (RolePermission, $$RolePermissionsTableReferences),
      RolePermission,
      PrefetchHooks Function({bool roleId, bool permId})
    >;
typedef $$EcolesTableCreateCompanionBuilder =
    EcolesCompanion Function({
      required String id,
      required String nom,
      Value<String?> ville,
      required int dateCrea,
      Value<int> rowid,
    });
typedef $$EcolesTableUpdateCompanionBuilder =
    EcolesCompanion Function({
      Value<String> id,
      Value<String> nom,
      Value<String?> ville,
      Value<int> dateCrea,
      Value<int> rowid,
    });

final class $$EcolesTableReferences
    extends BaseReferences<_$AppDatabase, $EcolesTable, Ecole> {
  $$EcolesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$NiveauxTable, List<Niveau>> _niveauxRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.niveaux,
    aliasName: $_aliasNameGenerator(db.ecoles.id, db.niveaux.ecoleId),
  );

  $$NiveauxTableProcessedTableManager get niveauxRefs {
    final manager = $$NiveauxTableTableManager(
      $_db,
      $_db.niveaux,
    ).filter((f) => f.ecoleId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_niveauxRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$AppartenancesTable, List<Appartenance>>
  _appartenancesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.appartenances,
    aliasName: $_aliasNameGenerator(db.ecoles.id, db.appartenances.ecoleId),
  );

  $$AppartenancesTableProcessedTableManager get appartenancesRefs {
    final manager = $$AppartenancesTableTableManager(
      $_db,
      $_db.appartenances,
    ).filter((f) => f.ecoleId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_appartenancesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$LeconsTable, List<Lecon>> _leconsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.lecons,
    aliasName: $_aliasNameGenerator(db.ecoles.id, db.lecons.ecoleId),
  );

  $$LeconsTableProcessedTableManager get leconsRefs {
    final manager = $$LeconsTableTableManager(
      $_db,
      $_db.lecons,
    ).filter((f) => f.ecoleId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_leconsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$CurriculumsTable, List<Curriculum>>
  _curriculumsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.curriculums,
    aliasName: $_aliasNameGenerator(db.ecoles.id, db.curriculums.ecoleId),
  );

  $$CurriculumsTableProcessedTableManager get curriculumsRefs {
    final manager = $$CurriculumsTableTableManager(
      $_db,
      $_db.curriculums,
    ).filter((f) => f.ecoleId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_curriculumsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$FlashcardsTable, List<Flashcard>>
  _flashcardsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.flashcards,
    aliasName: $_aliasNameGenerator(db.ecoles.id, db.flashcards.ecoleId),
  );

  $$FlashcardsTableProcessedTableManager get flashcardsRefs {
    final manager = $$FlashcardsTableTableManager(
      $_db,
      $_db.flashcards,
    ).filter((f) => f.ecoleId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_flashcardsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$EcolesTableFilterComposer
    extends Composer<_$AppDatabase, $EcolesTable> {
  $$EcolesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nom => $composableBuilder(
    column: $table.nom,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ville => $composableBuilder(
    column: $table.ville,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get dateCrea => $composableBuilder(
    column: $table.dateCrea,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> niveauxRefs(
    Expression<bool> Function($$NiveauxTableFilterComposer f) f,
  ) {
    final $$NiveauxTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.niveaux,
      getReferencedColumn: (t) => t.ecoleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$NiveauxTableFilterComposer(
            $db: $db,
            $table: $db.niveaux,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> appartenancesRefs(
    Expression<bool> Function($$AppartenancesTableFilterComposer f) f,
  ) {
    final $$AppartenancesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.appartenances,
      getReferencedColumn: (t) => t.ecoleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AppartenancesTableFilterComposer(
            $db: $db,
            $table: $db.appartenances,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> leconsRefs(
    Expression<bool> Function($$LeconsTableFilterComposer f) f,
  ) {
    final $$LeconsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.lecons,
      getReferencedColumn: (t) => t.ecoleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LeconsTableFilterComposer(
            $db: $db,
            $table: $db.lecons,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> curriculumsRefs(
    Expression<bool> Function($$CurriculumsTableFilterComposer f) f,
  ) {
    final $$CurriculumsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.curriculums,
      getReferencedColumn: (t) => t.ecoleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CurriculumsTableFilterComposer(
            $db: $db,
            $table: $db.curriculums,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> flashcardsRefs(
    Expression<bool> Function($$FlashcardsTableFilterComposer f) f,
  ) {
    final $$FlashcardsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.flashcards,
      getReferencedColumn: (t) => t.ecoleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FlashcardsTableFilterComposer(
            $db: $db,
            $table: $db.flashcards,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$EcolesTableOrderingComposer
    extends Composer<_$AppDatabase, $EcolesTable> {
  $$EcolesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nom => $composableBuilder(
    column: $table.nom,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ville => $composableBuilder(
    column: $table.ville,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get dateCrea => $composableBuilder(
    column: $table.dateCrea,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$EcolesTableAnnotationComposer
    extends Composer<_$AppDatabase, $EcolesTable> {
  $$EcolesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nom =>
      $composableBuilder(column: $table.nom, builder: (column) => column);

  GeneratedColumn<String> get ville =>
      $composableBuilder(column: $table.ville, builder: (column) => column);

  GeneratedColumn<int> get dateCrea =>
      $composableBuilder(column: $table.dateCrea, builder: (column) => column);

  Expression<T> niveauxRefs<T extends Object>(
    Expression<T> Function($$NiveauxTableAnnotationComposer a) f,
  ) {
    final $$NiveauxTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.niveaux,
      getReferencedColumn: (t) => t.ecoleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$NiveauxTableAnnotationComposer(
            $db: $db,
            $table: $db.niveaux,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> appartenancesRefs<T extends Object>(
    Expression<T> Function($$AppartenancesTableAnnotationComposer a) f,
  ) {
    final $$AppartenancesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.appartenances,
      getReferencedColumn: (t) => t.ecoleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AppartenancesTableAnnotationComposer(
            $db: $db,
            $table: $db.appartenances,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> leconsRefs<T extends Object>(
    Expression<T> Function($$LeconsTableAnnotationComposer a) f,
  ) {
    final $$LeconsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.lecons,
      getReferencedColumn: (t) => t.ecoleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LeconsTableAnnotationComposer(
            $db: $db,
            $table: $db.lecons,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> curriculumsRefs<T extends Object>(
    Expression<T> Function($$CurriculumsTableAnnotationComposer a) f,
  ) {
    final $$CurriculumsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.curriculums,
      getReferencedColumn: (t) => t.ecoleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CurriculumsTableAnnotationComposer(
            $db: $db,
            $table: $db.curriculums,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> flashcardsRefs<T extends Object>(
    Expression<T> Function($$FlashcardsTableAnnotationComposer a) f,
  ) {
    final $$FlashcardsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.flashcards,
      getReferencedColumn: (t) => t.ecoleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FlashcardsTableAnnotationComposer(
            $db: $db,
            $table: $db.flashcards,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$EcolesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $EcolesTable,
          Ecole,
          $$EcolesTableFilterComposer,
          $$EcolesTableOrderingComposer,
          $$EcolesTableAnnotationComposer,
          $$EcolesTableCreateCompanionBuilder,
          $$EcolesTableUpdateCompanionBuilder,
          (Ecole, $$EcolesTableReferences),
          Ecole,
          PrefetchHooks Function({
            bool niveauxRefs,
            bool appartenancesRefs,
            bool leconsRefs,
            bool curriculumsRefs,
            bool flashcardsRefs,
          })
        > {
  $$EcolesTableTableManager(_$AppDatabase db, $EcolesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EcolesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EcolesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EcolesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> nom = const Value.absent(),
                Value<String?> ville = const Value.absent(),
                Value<int> dateCrea = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => EcolesCompanion(
                id: id,
                nom: nom,
                ville: ville,
                dateCrea: dateCrea,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String nom,
                Value<String?> ville = const Value.absent(),
                required int dateCrea,
                Value<int> rowid = const Value.absent(),
              }) => EcolesCompanion.insert(
                id: id,
                nom: nom,
                ville: ville,
                dateCrea: dateCrea,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$EcolesTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                niveauxRefs = false,
                appartenancesRefs = false,
                leconsRefs = false,
                curriculumsRefs = false,
                flashcardsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (niveauxRefs) db.niveaux,
                    if (appartenancesRefs) db.appartenances,
                    if (leconsRefs) db.lecons,
                    if (curriculumsRefs) db.curriculums,
                    if (flashcardsRefs) db.flashcards,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (niveauxRefs)
                        await $_getPrefetchedData<Ecole, $EcolesTable, Niveau>(
                          currentTable: table,
                          referencedTable: $$EcolesTableReferences
                              ._niveauxRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$EcolesTableReferences(
                                db,
                                table,
                                p0,
                              ).niveauxRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.ecoleId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (appartenancesRefs)
                        await $_getPrefetchedData<
                          Ecole,
                          $EcolesTable,
                          Appartenance
                        >(
                          currentTable: table,
                          referencedTable: $$EcolesTableReferences
                              ._appartenancesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$EcolesTableReferences(
                                db,
                                table,
                                p0,
                              ).appartenancesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.ecoleId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (leconsRefs)
                        await $_getPrefetchedData<Ecole, $EcolesTable, Lecon>(
                          currentTable: table,
                          referencedTable: $$EcolesTableReferences
                              ._leconsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$EcolesTableReferences(db, table, p0).leconsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.ecoleId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (curriculumsRefs)
                        await $_getPrefetchedData<
                          Ecole,
                          $EcolesTable,
                          Curriculum
                        >(
                          currentTable: table,
                          referencedTable: $$EcolesTableReferences
                              ._curriculumsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$EcolesTableReferences(
                                db,
                                table,
                                p0,
                              ).curriculumsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.ecoleId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (flashcardsRefs)
                        await $_getPrefetchedData<
                          Ecole,
                          $EcolesTable,
                          Flashcard
                        >(
                          currentTable: table,
                          referencedTable: $$EcolesTableReferences
                              ._flashcardsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$EcolesTableReferences(
                                db,
                                table,
                                p0,
                              ).flashcardsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.ecoleId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$EcolesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $EcolesTable,
      Ecole,
      $$EcolesTableFilterComposer,
      $$EcolesTableOrderingComposer,
      $$EcolesTableAnnotationComposer,
      $$EcolesTableCreateCompanionBuilder,
      $$EcolesTableUpdateCompanionBuilder,
      (Ecole, $$EcolesTableReferences),
      Ecole,
      PrefetchHooks Function({
        bool niveauxRefs,
        bool appartenancesRefs,
        bool leconsRefs,
        bool curriculumsRefs,
        bool flashcardsRefs,
      })
    >;
typedef $$NiveauxTableCreateCompanionBuilder =
    NiveauxCompanion Function({
      required String id,
      required String nomNiveau,
      required String ecoleId,
      Value<int> rowid,
    });
typedef $$NiveauxTableUpdateCompanionBuilder =
    NiveauxCompanion Function({
      Value<String> id,
      Value<String> nomNiveau,
      Value<String> ecoleId,
      Value<int> rowid,
    });

final class $$NiveauxTableReferences
    extends BaseReferences<_$AppDatabase, $NiveauxTable, Niveau> {
  $$NiveauxTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $EcolesTable _ecoleIdTable(_$AppDatabase db) => db.ecoles.createAlias(
    $_aliasNameGenerator(db.niveaux.ecoleId, db.ecoles.id),
  );

  $$EcolesTableProcessedTableManager get ecoleId {
    final $_column = $_itemColumn<String>('ecole_id')!;

    final manager = $$EcolesTableTableManager(
      $_db,
      $_db.ecoles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_ecoleIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$AppartenancesTable, List<Appartenance>>
  _appartenancesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.appartenances,
    aliasName: $_aliasNameGenerator(db.niveaux.id, db.appartenances.niveauId),
  );

  $$AppartenancesTableProcessedTableManager get appartenancesRefs {
    final manager = $$AppartenancesTableTableManager(
      $_db,
      $_db.appartenances,
    ).filter((f) => f.niveauId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_appartenancesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$LeconsTable, List<Lecon>> _leconsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.lecons,
    aliasName: $_aliasNameGenerator(db.niveaux.id, db.lecons.niveauId),
  );

  $$LeconsTableProcessedTableManager get leconsRefs {
    final manager = $$LeconsTableTableManager(
      $_db,
      $_db.lecons,
    ).filter((f) => f.niveauId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_leconsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$CurriculumsTable, List<Curriculum>>
  _curriculumsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.curriculums,
    aliasName: $_aliasNameGenerator(db.niveaux.id, db.curriculums.niveauId),
  );

  $$CurriculumsTableProcessedTableManager get curriculumsRefs {
    final manager = $$CurriculumsTableTableManager(
      $_db,
      $_db.curriculums,
    ).filter((f) => f.niveauId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_curriculumsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$FlashcardsTable, List<Flashcard>>
  _flashcardsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.flashcards,
    aliasName: $_aliasNameGenerator(db.niveaux.id, db.flashcards.niveauId),
  );

  $$FlashcardsTableProcessedTableManager get flashcardsRefs {
    final manager = $$FlashcardsTableTableManager(
      $_db,
      $_db.flashcards,
    ).filter((f) => f.niveauId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_flashcardsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$NiveauxTableFilterComposer
    extends Composer<_$AppDatabase, $NiveauxTable> {
  $$NiveauxTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nomNiveau => $composableBuilder(
    column: $table.nomNiveau,
    builder: (column) => ColumnFilters(column),
  );

  $$EcolesTableFilterComposer get ecoleId {
    final $$EcolesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ecoleId,
      referencedTable: $db.ecoles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EcolesTableFilterComposer(
            $db: $db,
            $table: $db.ecoles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> appartenancesRefs(
    Expression<bool> Function($$AppartenancesTableFilterComposer f) f,
  ) {
    final $$AppartenancesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.appartenances,
      getReferencedColumn: (t) => t.niveauId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AppartenancesTableFilterComposer(
            $db: $db,
            $table: $db.appartenances,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> leconsRefs(
    Expression<bool> Function($$LeconsTableFilterComposer f) f,
  ) {
    final $$LeconsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.lecons,
      getReferencedColumn: (t) => t.niveauId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LeconsTableFilterComposer(
            $db: $db,
            $table: $db.lecons,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> curriculumsRefs(
    Expression<bool> Function($$CurriculumsTableFilterComposer f) f,
  ) {
    final $$CurriculumsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.curriculums,
      getReferencedColumn: (t) => t.niveauId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CurriculumsTableFilterComposer(
            $db: $db,
            $table: $db.curriculums,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> flashcardsRefs(
    Expression<bool> Function($$FlashcardsTableFilterComposer f) f,
  ) {
    final $$FlashcardsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.flashcards,
      getReferencedColumn: (t) => t.niveauId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FlashcardsTableFilterComposer(
            $db: $db,
            $table: $db.flashcards,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$NiveauxTableOrderingComposer
    extends Composer<_$AppDatabase, $NiveauxTable> {
  $$NiveauxTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nomNiveau => $composableBuilder(
    column: $table.nomNiveau,
    builder: (column) => ColumnOrderings(column),
  );

  $$EcolesTableOrderingComposer get ecoleId {
    final $$EcolesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ecoleId,
      referencedTable: $db.ecoles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EcolesTableOrderingComposer(
            $db: $db,
            $table: $db.ecoles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$NiveauxTableAnnotationComposer
    extends Composer<_$AppDatabase, $NiveauxTable> {
  $$NiveauxTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nomNiveau =>
      $composableBuilder(column: $table.nomNiveau, builder: (column) => column);

  $$EcolesTableAnnotationComposer get ecoleId {
    final $$EcolesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ecoleId,
      referencedTable: $db.ecoles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EcolesTableAnnotationComposer(
            $db: $db,
            $table: $db.ecoles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> appartenancesRefs<T extends Object>(
    Expression<T> Function($$AppartenancesTableAnnotationComposer a) f,
  ) {
    final $$AppartenancesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.appartenances,
      getReferencedColumn: (t) => t.niveauId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AppartenancesTableAnnotationComposer(
            $db: $db,
            $table: $db.appartenances,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> leconsRefs<T extends Object>(
    Expression<T> Function($$LeconsTableAnnotationComposer a) f,
  ) {
    final $$LeconsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.lecons,
      getReferencedColumn: (t) => t.niveauId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LeconsTableAnnotationComposer(
            $db: $db,
            $table: $db.lecons,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> curriculumsRefs<T extends Object>(
    Expression<T> Function($$CurriculumsTableAnnotationComposer a) f,
  ) {
    final $$CurriculumsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.curriculums,
      getReferencedColumn: (t) => t.niveauId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CurriculumsTableAnnotationComposer(
            $db: $db,
            $table: $db.curriculums,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> flashcardsRefs<T extends Object>(
    Expression<T> Function($$FlashcardsTableAnnotationComposer a) f,
  ) {
    final $$FlashcardsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.flashcards,
      getReferencedColumn: (t) => t.niveauId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FlashcardsTableAnnotationComposer(
            $db: $db,
            $table: $db.flashcards,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$NiveauxTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $NiveauxTable,
          Niveau,
          $$NiveauxTableFilterComposer,
          $$NiveauxTableOrderingComposer,
          $$NiveauxTableAnnotationComposer,
          $$NiveauxTableCreateCompanionBuilder,
          $$NiveauxTableUpdateCompanionBuilder,
          (Niveau, $$NiveauxTableReferences),
          Niveau,
          PrefetchHooks Function({
            bool ecoleId,
            bool appartenancesRefs,
            bool leconsRefs,
            bool curriculumsRefs,
            bool flashcardsRefs,
          })
        > {
  $$NiveauxTableTableManager(_$AppDatabase db, $NiveauxTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$NiveauxTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$NiveauxTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$NiveauxTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> nomNiveau = const Value.absent(),
                Value<String> ecoleId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => NiveauxCompanion(
                id: id,
                nomNiveau: nomNiveau,
                ecoleId: ecoleId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String nomNiveau,
                required String ecoleId,
                Value<int> rowid = const Value.absent(),
              }) => NiveauxCompanion.insert(
                id: id,
                nomNiveau: nomNiveau,
                ecoleId: ecoleId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$NiveauxTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                ecoleId = false,
                appartenancesRefs = false,
                leconsRefs = false,
                curriculumsRefs = false,
                flashcardsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (appartenancesRefs) db.appartenances,
                    if (leconsRefs) db.lecons,
                    if (curriculumsRefs) db.curriculums,
                    if (flashcardsRefs) db.flashcards,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (ecoleId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.ecoleId,
                                    referencedTable: $$NiveauxTableReferences
                                        ._ecoleIdTable(db),
                                    referencedColumn: $$NiveauxTableReferences
                                        ._ecoleIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (appartenancesRefs)
                        await $_getPrefetchedData<
                          Niveau,
                          $NiveauxTable,
                          Appartenance
                        >(
                          currentTable: table,
                          referencedTable: $$NiveauxTableReferences
                              ._appartenancesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$NiveauxTableReferences(
                                db,
                                table,
                                p0,
                              ).appartenancesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.niveauId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (leconsRefs)
                        await $_getPrefetchedData<Niveau, $NiveauxTable, Lecon>(
                          currentTable: table,
                          referencedTable: $$NiveauxTableReferences
                              ._leconsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$NiveauxTableReferences(
                                db,
                                table,
                                p0,
                              ).leconsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.niveauId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (curriculumsRefs)
                        await $_getPrefetchedData<
                          Niveau,
                          $NiveauxTable,
                          Curriculum
                        >(
                          currentTable: table,
                          referencedTable: $$NiveauxTableReferences
                              ._curriculumsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$NiveauxTableReferences(
                                db,
                                table,
                                p0,
                              ).curriculumsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.niveauId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (flashcardsRefs)
                        await $_getPrefetchedData<
                          Niveau,
                          $NiveauxTable,
                          Flashcard
                        >(
                          currentTable: table,
                          referencedTable: $$NiveauxTableReferences
                              ._flashcardsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$NiveauxTableReferences(
                                db,
                                table,
                                p0,
                              ).flashcardsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.niveauId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$NiveauxTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $NiveauxTable,
      Niveau,
      $$NiveauxTableFilterComposer,
      $$NiveauxTableOrderingComposer,
      $$NiveauxTableAnnotationComposer,
      $$NiveauxTableCreateCompanionBuilder,
      $$NiveauxTableUpdateCompanionBuilder,
      (Niveau, $$NiveauxTableReferences),
      Niveau,
      PrefetchHooks Function({
        bool ecoleId,
        bool appartenancesRefs,
        bool leconsRefs,
        bool curriculumsRefs,
        bool flashcardsRefs,
      })
    >;
typedef $$UtilisateursTableCreateCompanionBuilder =
    UtilisateursCompanion Function({
      required String id,
      required String nom,
      Value<String?> prenom,
      required String email,
      required String mdp,
      Value<String?> roleId,
      required int dateCrea,
      Value<int?> dateDel,
      Value<int> rowid,
    });
typedef $$UtilisateursTableUpdateCompanionBuilder =
    UtilisateursCompanion Function({
      Value<String> id,
      Value<String> nom,
      Value<String?> prenom,
      Value<String> email,
      Value<String> mdp,
      Value<String?> roleId,
      Value<int> dateCrea,
      Value<int?> dateDel,
      Value<int> rowid,
    });

final class $$UtilisateursTableReferences
    extends BaseReferences<_$AppDatabase, $UtilisateursTable, Utilisateur> {
  $$UtilisateursTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $RolesTable _roleIdTable(_$AppDatabase db) => db.roles.createAlias(
    $_aliasNameGenerator(db.utilisateurs.roleId, db.roles.id),
  );

  $$RolesTableProcessedTableManager? get roleId {
    final $_column = $_itemColumn<String>('role_id');
    if ($_column == null) return null;
    final manager = $$RolesTableTableManager(
      $_db,
      $_db.roles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_roleIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$AppartenancesTable, List<Appartenance>>
  _appartenancesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.appartenances,
    aliasName: $_aliasNameGenerator(
      db.utilisateurs.id,
      db.appartenances.userId,
    ),
  );

  $$AppartenancesTableProcessedTableManager get appartenancesRefs {
    final manager = $$AppartenancesTableTableManager(
      $_db,
      $_db.appartenances,
    ).filter((f) => f.userId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_appartenancesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$LeconsTable, List<Lecon>> _leconsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.lecons,
    aliasName: $_aliasNameGenerator(db.utilisateurs.id, db.lecons.auteurId),
  );

  $$LeconsTableProcessedTableManager get leconsRefs {
    final manager = $$LeconsTableTableManager(
      $_db,
      $_db.lecons,
    ).filter((f) => f.auteurId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_leconsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$FlashcardsTable, List<Flashcard>>
  _flashcardsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.flashcards,
    aliasName: $_aliasNameGenerator(db.utilisateurs.id, db.flashcards.userId),
  );

  $$FlashcardsTableProcessedTableManager get flashcardsRefs {
    final manager = $$FlashcardsTableTableManager(
      $_db,
      $_db.flashcards,
    ).filter((f) => f.userId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_flashcardsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$UtilisateursTableFilterComposer
    extends Composer<_$AppDatabase, $UtilisateursTable> {
  $$UtilisateursTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nom => $composableBuilder(
    column: $table.nom,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get prenom => $composableBuilder(
    column: $table.prenom,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mdp => $composableBuilder(
    column: $table.mdp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get dateCrea => $composableBuilder(
    column: $table.dateCrea,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get dateDel => $composableBuilder(
    column: $table.dateDel,
    builder: (column) => ColumnFilters(column),
  );

  $$RolesTableFilterComposer get roleId {
    final $$RolesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.roleId,
      referencedTable: $db.roles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RolesTableFilterComposer(
            $db: $db,
            $table: $db.roles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> appartenancesRefs(
    Expression<bool> Function($$AppartenancesTableFilterComposer f) f,
  ) {
    final $$AppartenancesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.appartenances,
      getReferencedColumn: (t) => t.userId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AppartenancesTableFilterComposer(
            $db: $db,
            $table: $db.appartenances,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> leconsRefs(
    Expression<bool> Function($$LeconsTableFilterComposer f) f,
  ) {
    final $$LeconsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.lecons,
      getReferencedColumn: (t) => t.auteurId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LeconsTableFilterComposer(
            $db: $db,
            $table: $db.lecons,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> flashcardsRefs(
    Expression<bool> Function($$FlashcardsTableFilterComposer f) f,
  ) {
    final $$FlashcardsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.flashcards,
      getReferencedColumn: (t) => t.userId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FlashcardsTableFilterComposer(
            $db: $db,
            $table: $db.flashcards,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$UtilisateursTableOrderingComposer
    extends Composer<_$AppDatabase, $UtilisateursTable> {
  $$UtilisateursTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nom => $composableBuilder(
    column: $table.nom,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get prenom => $composableBuilder(
    column: $table.prenom,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mdp => $composableBuilder(
    column: $table.mdp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get dateCrea => $composableBuilder(
    column: $table.dateCrea,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get dateDel => $composableBuilder(
    column: $table.dateDel,
    builder: (column) => ColumnOrderings(column),
  );

  $$RolesTableOrderingComposer get roleId {
    final $$RolesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.roleId,
      referencedTable: $db.roles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RolesTableOrderingComposer(
            $db: $db,
            $table: $db.roles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UtilisateursTableAnnotationComposer
    extends Composer<_$AppDatabase, $UtilisateursTable> {
  $$UtilisateursTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nom =>
      $composableBuilder(column: $table.nom, builder: (column) => column);

  GeneratedColumn<String> get prenom =>
      $composableBuilder(column: $table.prenom, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get mdp =>
      $composableBuilder(column: $table.mdp, builder: (column) => column);

  GeneratedColumn<int> get dateCrea =>
      $composableBuilder(column: $table.dateCrea, builder: (column) => column);

  GeneratedColumn<int> get dateDel =>
      $composableBuilder(column: $table.dateDel, builder: (column) => column);

  $$RolesTableAnnotationComposer get roleId {
    final $$RolesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.roleId,
      referencedTable: $db.roles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RolesTableAnnotationComposer(
            $db: $db,
            $table: $db.roles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> appartenancesRefs<T extends Object>(
    Expression<T> Function($$AppartenancesTableAnnotationComposer a) f,
  ) {
    final $$AppartenancesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.appartenances,
      getReferencedColumn: (t) => t.userId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AppartenancesTableAnnotationComposer(
            $db: $db,
            $table: $db.appartenances,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> leconsRefs<T extends Object>(
    Expression<T> Function($$LeconsTableAnnotationComposer a) f,
  ) {
    final $$LeconsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.lecons,
      getReferencedColumn: (t) => t.auteurId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LeconsTableAnnotationComposer(
            $db: $db,
            $table: $db.lecons,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> flashcardsRefs<T extends Object>(
    Expression<T> Function($$FlashcardsTableAnnotationComposer a) f,
  ) {
    final $$FlashcardsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.flashcards,
      getReferencedColumn: (t) => t.userId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FlashcardsTableAnnotationComposer(
            $db: $db,
            $table: $db.flashcards,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$UtilisateursTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UtilisateursTable,
          Utilisateur,
          $$UtilisateursTableFilterComposer,
          $$UtilisateursTableOrderingComposer,
          $$UtilisateursTableAnnotationComposer,
          $$UtilisateursTableCreateCompanionBuilder,
          $$UtilisateursTableUpdateCompanionBuilder,
          (Utilisateur, $$UtilisateursTableReferences),
          Utilisateur,
          PrefetchHooks Function({
            bool roleId,
            bool appartenancesRefs,
            bool leconsRefs,
            bool flashcardsRefs,
          })
        > {
  $$UtilisateursTableTableManager(_$AppDatabase db, $UtilisateursTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UtilisateursTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UtilisateursTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UtilisateursTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> nom = const Value.absent(),
                Value<String?> prenom = const Value.absent(),
                Value<String> email = const Value.absent(),
                Value<String> mdp = const Value.absent(),
                Value<String?> roleId = const Value.absent(),
                Value<int> dateCrea = const Value.absent(),
                Value<int?> dateDel = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UtilisateursCompanion(
                id: id,
                nom: nom,
                prenom: prenom,
                email: email,
                mdp: mdp,
                roleId: roleId,
                dateCrea: dateCrea,
                dateDel: dateDel,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String nom,
                Value<String?> prenom = const Value.absent(),
                required String email,
                required String mdp,
                Value<String?> roleId = const Value.absent(),
                required int dateCrea,
                Value<int?> dateDel = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UtilisateursCompanion.insert(
                id: id,
                nom: nom,
                prenom: prenom,
                email: email,
                mdp: mdp,
                roleId: roleId,
                dateCrea: dateCrea,
                dateDel: dateDel,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$UtilisateursTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                roleId = false,
                appartenancesRefs = false,
                leconsRefs = false,
                flashcardsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (appartenancesRefs) db.appartenances,
                    if (leconsRefs) db.lecons,
                    if (flashcardsRefs) db.flashcards,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (roleId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.roleId,
                                    referencedTable:
                                        $$UtilisateursTableReferences
                                            ._roleIdTable(db),
                                    referencedColumn:
                                        $$UtilisateursTableReferences
                                            ._roleIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (appartenancesRefs)
                        await $_getPrefetchedData<
                          Utilisateur,
                          $UtilisateursTable,
                          Appartenance
                        >(
                          currentTable: table,
                          referencedTable: $$UtilisateursTableReferences
                              ._appartenancesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$UtilisateursTableReferences(
                                db,
                                table,
                                p0,
                              ).appartenancesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.userId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (leconsRefs)
                        await $_getPrefetchedData<
                          Utilisateur,
                          $UtilisateursTable,
                          Lecon
                        >(
                          currentTable: table,
                          referencedTable: $$UtilisateursTableReferences
                              ._leconsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$UtilisateursTableReferences(
                                db,
                                table,
                                p0,
                              ).leconsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.auteurId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (flashcardsRefs)
                        await $_getPrefetchedData<
                          Utilisateur,
                          $UtilisateursTable,
                          Flashcard
                        >(
                          currentTable: table,
                          referencedTable: $$UtilisateursTableReferences
                              ._flashcardsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$UtilisateursTableReferences(
                                db,
                                table,
                                p0,
                              ).flashcardsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.userId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$UtilisateursTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UtilisateursTable,
      Utilisateur,
      $$UtilisateursTableFilterComposer,
      $$UtilisateursTableOrderingComposer,
      $$UtilisateursTableAnnotationComposer,
      $$UtilisateursTableCreateCompanionBuilder,
      $$UtilisateursTableUpdateCompanionBuilder,
      (Utilisateur, $$UtilisateursTableReferences),
      Utilisateur,
      PrefetchHooks Function({
        bool roleId,
        bool appartenancesRefs,
        bool leconsRefs,
        bool flashcardsRefs,
      })
    >;
typedef $$AppartenancesTableCreateCompanionBuilder =
    AppartenancesCompanion Function({
      required String id,
      required String userId,
      required String ecoleId,
      Value<String?> niveauId,
      required String anneeSco,
      Value<bool> estActif,
      required int dateMiseAJour,
      Value<int> rowid,
    });
typedef $$AppartenancesTableUpdateCompanionBuilder =
    AppartenancesCompanion Function({
      Value<String> id,
      Value<String> userId,
      Value<String> ecoleId,
      Value<String?> niveauId,
      Value<String> anneeSco,
      Value<bool> estActif,
      Value<int> dateMiseAJour,
      Value<int> rowid,
    });

final class $$AppartenancesTableReferences
    extends BaseReferences<_$AppDatabase, $AppartenancesTable, Appartenance> {
  $$AppartenancesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $UtilisateursTable _userIdTable(_$AppDatabase db) =>
      db.utilisateurs.createAlias(
        $_aliasNameGenerator(db.appartenances.userId, db.utilisateurs.id),
      );

  $$UtilisateursTableProcessedTableManager get userId {
    final $_column = $_itemColumn<String>('user_id')!;

    final manager = $$UtilisateursTableTableManager(
      $_db,
      $_db.utilisateurs,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_userIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $EcolesTable _ecoleIdTable(_$AppDatabase db) => db.ecoles.createAlias(
    $_aliasNameGenerator(db.appartenances.ecoleId, db.ecoles.id),
  );

  $$EcolesTableProcessedTableManager get ecoleId {
    final $_column = $_itemColumn<String>('ecole_id')!;

    final manager = $$EcolesTableTableManager(
      $_db,
      $_db.ecoles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_ecoleIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $NiveauxTable _niveauIdTable(_$AppDatabase db) =>
      db.niveaux.createAlias(
        $_aliasNameGenerator(db.appartenances.niveauId, db.niveaux.id),
      );

  $$NiveauxTableProcessedTableManager? get niveauId {
    final $_column = $_itemColumn<String>('niveau_id');
    if ($_column == null) return null;
    final manager = $$NiveauxTableTableManager(
      $_db,
      $_db.niveaux,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_niveauIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$AppartenancesTableFilterComposer
    extends Composer<_$AppDatabase, $AppartenancesTable> {
  $$AppartenancesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get anneeSco => $composableBuilder(
    column: $table.anneeSco,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get estActif => $composableBuilder(
    column: $table.estActif,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get dateMiseAJour => $composableBuilder(
    column: $table.dateMiseAJour,
    builder: (column) => ColumnFilters(column),
  );

  $$UtilisateursTableFilterComposer get userId {
    final $$UtilisateursTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.utilisateurs,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UtilisateursTableFilterComposer(
            $db: $db,
            $table: $db.utilisateurs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$EcolesTableFilterComposer get ecoleId {
    final $$EcolesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ecoleId,
      referencedTable: $db.ecoles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EcolesTableFilterComposer(
            $db: $db,
            $table: $db.ecoles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$NiveauxTableFilterComposer get niveauId {
    final $$NiveauxTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.niveauId,
      referencedTable: $db.niveaux,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$NiveauxTableFilterComposer(
            $db: $db,
            $table: $db.niveaux,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AppartenancesTableOrderingComposer
    extends Composer<_$AppDatabase, $AppartenancesTable> {
  $$AppartenancesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get anneeSco => $composableBuilder(
    column: $table.anneeSco,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get estActif => $composableBuilder(
    column: $table.estActif,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get dateMiseAJour => $composableBuilder(
    column: $table.dateMiseAJour,
    builder: (column) => ColumnOrderings(column),
  );

  $$UtilisateursTableOrderingComposer get userId {
    final $$UtilisateursTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.utilisateurs,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UtilisateursTableOrderingComposer(
            $db: $db,
            $table: $db.utilisateurs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$EcolesTableOrderingComposer get ecoleId {
    final $$EcolesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ecoleId,
      referencedTable: $db.ecoles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EcolesTableOrderingComposer(
            $db: $db,
            $table: $db.ecoles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$NiveauxTableOrderingComposer get niveauId {
    final $$NiveauxTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.niveauId,
      referencedTable: $db.niveaux,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$NiveauxTableOrderingComposer(
            $db: $db,
            $table: $db.niveaux,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AppartenancesTableAnnotationComposer
    extends Composer<_$AppDatabase, $AppartenancesTable> {
  $$AppartenancesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get anneeSco =>
      $composableBuilder(column: $table.anneeSco, builder: (column) => column);

  GeneratedColumn<bool> get estActif =>
      $composableBuilder(column: $table.estActif, builder: (column) => column);

  GeneratedColumn<int> get dateMiseAJour => $composableBuilder(
    column: $table.dateMiseAJour,
    builder: (column) => column,
  );

  $$UtilisateursTableAnnotationComposer get userId {
    final $$UtilisateursTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.utilisateurs,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UtilisateursTableAnnotationComposer(
            $db: $db,
            $table: $db.utilisateurs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$EcolesTableAnnotationComposer get ecoleId {
    final $$EcolesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ecoleId,
      referencedTable: $db.ecoles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EcolesTableAnnotationComposer(
            $db: $db,
            $table: $db.ecoles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$NiveauxTableAnnotationComposer get niveauId {
    final $$NiveauxTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.niveauId,
      referencedTable: $db.niveaux,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$NiveauxTableAnnotationComposer(
            $db: $db,
            $table: $db.niveaux,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AppartenancesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AppartenancesTable,
          Appartenance,
          $$AppartenancesTableFilterComposer,
          $$AppartenancesTableOrderingComposer,
          $$AppartenancesTableAnnotationComposer,
          $$AppartenancesTableCreateCompanionBuilder,
          $$AppartenancesTableUpdateCompanionBuilder,
          (Appartenance, $$AppartenancesTableReferences),
          Appartenance,
          PrefetchHooks Function({bool userId, bool ecoleId, bool niveauId})
        > {
  $$AppartenancesTableTableManager(_$AppDatabase db, $AppartenancesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppartenancesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppartenancesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppartenancesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<String> ecoleId = const Value.absent(),
                Value<String?> niveauId = const Value.absent(),
                Value<String> anneeSco = const Value.absent(),
                Value<bool> estActif = const Value.absent(),
                Value<int> dateMiseAJour = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AppartenancesCompanion(
                id: id,
                userId: userId,
                ecoleId: ecoleId,
                niveauId: niveauId,
                anneeSco: anneeSco,
                estActif: estActif,
                dateMiseAJour: dateMiseAJour,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String userId,
                required String ecoleId,
                Value<String?> niveauId = const Value.absent(),
                required String anneeSco,
                Value<bool> estActif = const Value.absent(),
                required int dateMiseAJour,
                Value<int> rowid = const Value.absent(),
              }) => AppartenancesCompanion.insert(
                id: id,
                userId: userId,
                ecoleId: ecoleId,
                niveauId: niveauId,
                anneeSco: anneeSco,
                estActif: estActif,
                dateMiseAJour: dateMiseAJour,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$AppartenancesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({userId = false, ecoleId = false, niveauId = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (userId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.userId,
                                    referencedTable:
                                        $$AppartenancesTableReferences
                                            ._userIdTable(db),
                                    referencedColumn:
                                        $$AppartenancesTableReferences
                                            ._userIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (ecoleId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.ecoleId,
                                    referencedTable:
                                        $$AppartenancesTableReferences
                                            ._ecoleIdTable(db),
                                    referencedColumn:
                                        $$AppartenancesTableReferences
                                            ._ecoleIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (niveauId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.niveauId,
                                    referencedTable:
                                        $$AppartenancesTableReferences
                                            ._niveauIdTable(db),
                                    referencedColumn:
                                        $$AppartenancesTableReferences
                                            ._niveauIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [];
                  },
                );
              },
        ),
      );
}

typedef $$AppartenancesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AppartenancesTable,
      Appartenance,
      $$AppartenancesTableFilterComposer,
      $$AppartenancesTableOrderingComposer,
      $$AppartenancesTableAnnotationComposer,
      $$AppartenancesTableCreateCompanionBuilder,
      $$AppartenancesTableUpdateCompanionBuilder,
      (Appartenance, $$AppartenancesTableReferences),
      Appartenance,
      PrefetchHooks Function({bool userId, bool ecoleId, bool niveauId})
    >;
typedef $$MatieresTableCreateCompanionBuilder =
    MatieresCompanion Function({
      required String id,
      required String nom,
      Value<String?> codeMatiere,
      Value<int> rowid,
    });
typedef $$MatieresTableUpdateCompanionBuilder =
    MatieresCompanion Function({
      Value<String> id,
      Value<String> nom,
      Value<String?> codeMatiere,
      Value<int> rowid,
    });

final class $$MatieresTableReferences
    extends BaseReferences<_$AppDatabase, $MatieresTable, Matiere> {
  $$MatieresTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$LeconsTable, List<Lecon>> _leconsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.lecons,
    aliasName: $_aliasNameGenerator(db.matieres.id, db.lecons.matiereId),
  );

  $$LeconsTableProcessedTableManager get leconsRefs {
    final manager = $$LeconsTableTableManager(
      $_db,
      $_db.lecons,
    ).filter((f) => f.matiereId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_leconsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$CurriculumsTable, List<Curriculum>>
  _curriculumsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.curriculums,
    aliasName: $_aliasNameGenerator(db.matieres.id, db.curriculums.matiereId),
  );

  $$CurriculumsTableProcessedTableManager get curriculumsRefs {
    final manager = $$CurriculumsTableTableManager(
      $_db,
      $_db.curriculums,
    ).filter((f) => f.matiereId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_curriculumsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$FlashcardsTable, List<Flashcard>>
  _flashcardsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.flashcards,
    aliasName: $_aliasNameGenerator(db.matieres.id, db.flashcards.matiereId),
  );

  $$FlashcardsTableProcessedTableManager get flashcardsRefs {
    final manager = $$FlashcardsTableTableManager(
      $_db,
      $_db.flashcards,
    ).filter((f) => f.matiereId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_flashcardsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$MatieresTableFilterComposer
    extends Composer<_$AppDatabase, $MatieresTable> {
  $$MatieresTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nom => $composableBuilder(
    column: $table.nom,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get codeMatiere => $composableBuilder(
    column: $table.codeMatiere,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> leconsRefs(
    Expression<bool> Function($$LeconsTableFilterComposer f) f,
  ) {
    final $$LeconsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.lecons,
      getReferencedColumn: (t) => t.matiereId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LeconsTableFilterComposer(
            $db: $db,
            $table: $db.lecons,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> curriculumsRefs(
    Expression<bool> Function($$CurriculumsTableFilterComposer f) f,
  ) {
    final $$CurriculumsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.curriculums,
      getReferencedColumn: (t) => t.matiereId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CurriculumsTableFilterComposer(
            $db: $db,
            $table: $db.curriculums,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> flashcardsRefs(
    Expression<bool> Function($$FlashcardsTableFilterComposer f) f,
  ) {
    final $$FlashcardsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.flashcards,
      getReferencedColumn: (t) => t.matiereId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FlashcardsTableFilterComposer(
            $db: $db,
            $table: $db.flashcards,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$MatieresTableOrderingComposer
    extends Composer<_$AppDatabase, $MatieresTable> {
  $$MatieresTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nom => $composableBuilder(
    column: $table.nom,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get codeMatiere => $composableBuilder(
    column: $table.codeMatiere,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MatieresTableAnnotationComposer
    extends Composer<_$AppDatabase, $MatieresTable> {
  $$MatieresTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nom =>
      $composableBuilder(column: $table.nom, builder: (column) => column);

  GeneratedColumn<String> get codeMatiere => $composableBuilder(
    column: $table.codeMatiere,
    builder: (column) => column,
  );

  Expression<T> leconsRefs<T extends Object>(
    Expression<T> Function($$LeconsTableAnnotationComposer a) f,
  ) {
    final $$LeconsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.lecons,
      getReferencedColumn: (t) => t.matiereId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LeconsTableAnnotationComposer(
            $db: $db,
            $table: $db.lecons,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> curriculumsRefs<T extends Object>(
    Expression<T> Function($$CurriculumsTableAnnotationComposer a) f,
  ) {
    final $$CurriculumsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.curriculums,
      getReferencedColumn: (t) => t.matiereId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CurriculumsTableAnnotationComposer(
            $db: $db,
            $table: $db.curriculums,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> flashcardsRefs<T extends Object>(
    Expression<T> Function($$FlashcardsTableAnnotationComposer a) f,
  ) {
    final $$FlashcardsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.flashcards,
      getReferencedColumn: (t) => t.matiereId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FlashcardsTableAnnotationComposer(
            $db: $db,
            $table: $db.flashcards,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$MatieresTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MatieresTable,
          Matiere,
          $$MatieresTableFilterComposer,
          $$MatieresTableOrderingComposer,
          $$MatieresTableAnnotationComposer,
          $$MatieresTableCreateCompanionBuilder,
          $$MatieresTableUpdateCompanionBuilder,
          (Matiere, $$MatieresTableReferences),
          Matiere,
          PrefetchHooks Function({
            bool leconsRefs,
            bool curriculumsRefs,
            bool flashcardsRefs,
          })
        > {
  $$MatieresTableTableManager(_$AppDatabase db, $MatieresTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MatieresTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MatieresTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MatieresTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> nom = const Value.absent(),
                Value<String?> codeMatiere = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MatieresCompanion(
                id: id,
                nom: nom,
                codeMatiere: codeMatiere,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String nom,
                Value<String?> codeMatiere = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MatieresCompanion.insert(
                id: id,
                nom: nom,
                codeMatiere: codeMatiere,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$MatieresTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                leconsRefs = false,
                curriculumsRefs = false,
                flashcardsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (leconsRefs) db.lecons,
                    if (curriculumsRefs) db.curriculums,
                    if (flashcardsRefs) db.flashcards,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (leconsRefs)
                        await $_getPrefetchedData<
                          Matiere,
                          $MatieresTable,
                          Lecon
                        >(
                          currentTable: table,
                          referencedTable: $$MatieresTableReferences
                              ._leconsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MatieresTableReferences(
                                db,
                                table,
                                p0,
                              ).leconsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.matiereId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (curriculumsRefs)
                        await $_getPrefetchedData<
                          Matiere,
                          $MatieresTable,
                          Curriculum
                        >(
                          currentTable: table,
                          referencedTable: $$MatieresTableReferences
                              ._curriculumsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MatieresTableReferences(
                                db,
                                table,
                                p0,
                              ).curriculumsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.matiereId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (flashcardsRefs)
                        await $_getPrefetchedData<
                          Matiere,
                          $MatieresTable,
                          Flashcard
                        >(
                          currentTable: table,
                          referencedTable: $$MatieresTableReferences
                              ._flashcardsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MatieresTableReferences(
                                db,
                                table,
                                p0,
                              ).flashcardsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.matiereId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$MatieresTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MatieresTable,
      Matiere,
      $$MatieresTableFilterComposer,
      $$MatieresTableOrderingComposer,
      $$MatieresTableAnnotationComposer,
      $$MatieresTableCreateCompanionBuilder,
      $$MatieresTableUpdateCompanionBuilder,
      (Matiere, $$MatieresTableReferences),
      Matiere,
      PrefetchHooks Function({
        bool leconsRefs,
        bool curriculumsRefs,
        bool flashcardsRefs,
      })
    >;
typedef $$LeconsTableCreateCompanionBuilder =
    LeconsCompanion Function({
      required String id,
      required String titre,
      Value<String?> contenuBrut,
      Value<String?> contenuStyl,
      Value<String> visibilite,
      Value<String?> auteurId,
      Value<String?> matiereId,
      Value<String?> niveauId,
      Value<String?> ecoleId,
      required int dateUpd,
      Value<int?> dateDel,
      Value<String> sourceType,
      Value<int> rowid,
    });
typedef $$LeconsTableUpdateCompanionBuilder =
    LeconsCompanion Function({
      Value<String> id,
      Value<String> titre,
      Value<String?> contenuBrut,
      Value<String?> contenuStyl,
      Value<String> visibilite,
      Value<String?> auteurId,
      Value<String?> matiereId,
      Value<String?> niveauId,
      Value<String?> ecoleId,
      Value<int> dateUpd,
      Value<int?> dateDel,
      Value<String> sourceType,
      Value<int> rowid,
    });

final class $$LeconsTableReferences
    extends BaseReferences<_$AppDatabase, $LeconsTable, Lecon> {
  $$LeconsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $UtilisateursTable _auteurIdTable(_$AppDatabase db) =>
      db.utilisateurs.createAlias(
        $_aliasNameGenerator(db.lecons.auteurId, db.utilisateurs.id),
      );

  $$UtilisateursTableProcessedTableManager? get auteurId {
    final $_column = $_itemColumn<String>('auteur_id');
    if ($_column == null) return null;
    final manager = $$UtilisateursTableTableManager(
      $_db,
      $_db.utilisateurs,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_auteurIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $MatieresTable _matiereIdTable(_$AppDatabase db) => db.matieres
      .createAlias($_aliasNameGenerator(db.lecons.matiereId, db.matieres.id));

  $$MatieresTableProcessedTableManager? get matiereId {
    final $_column = $_itemColumn<String>('matiere_id');
    if ($_column == null) return null;
    final manager = $$MatieresTableTableManager(
      $_db,
      $_db.matieres,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_matiereIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $NiveauxTable _niveauIdTable(_$AppDatabase db) => db.niveaux
      .createAlias($_aliasNameGenerator(db.lecons.niveauId, db.niveaux.id));

  $$NiveauxTableProcessedTableManager? get niveauId {
    final $_column = $_itemColumn<String>('niveau_id');
    if ($_column == null) return null;
    final manager = $$NiveauxTableTableManager(
      $_db,
      $_db.niveaux,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_niveauIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $EcolesTable _ecoleIdTable(_$AppDatabase db) => db.ecoles.createAlias(
    $_aliasNameGenerator(db.lecons.ecoleId, db.ecoles.id),
  );

  $$EcolesTableProcessedTableManager? get ecoleId {
    final $_column = $_itemColumn<String>('ecole_id');
    if ($_column == null) return null;
    final manager = $$EcolesTableTableManager(
      $_db,
      $_db.ecoles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_ecoleIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$PagesTable, List<Page>> _pagesRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.pages,
    aliasName: $_aliasNameGenerator(db.lecons.id, db.pages.leconId),
  );

  $$PagesTableProcessedTableManager get pagesRefs {
    final manager = $$PagesTableTableManager(
      $_db,
      $_db.pages,
    ).filter((f) => f.leconId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_pagesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$FlashcardsTable, List<Flashcard>>
  _flashcardsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.flashcards,
    aliasName: $_aliasNameGenerator(db.lecons.id, db.flashcards.leconId),
  );

  $$FlashcardsTableProcessedTableManager get flashcardsRefs {
    final manager = $$FlashcardsTableTableManager(
      $_db,
      $_db.flashcards,
    ).filter((f) => f.leconId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_flashcardsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$LeconsTableFilterComposer
    extends Composer<_$AppDatabase, $LeconsTable> {
  $$LeconsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get titre => $composableBuilder(
    column: $table.titre,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contenuBrut => $composableBuilder(
    column: $table.contenuBrut,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contenuStyl => $composableBuilder(
    column: $table.contenuStyl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get visibilite => $composableBuilder(
    column: $table.visibilite,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get dateUpd => $composableBuilder(
    column: $table.dateUpd,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get dateDel => $composableBuilder(
    column: $table.dateDel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sourceType => $composableBuilder(
    column: $table.sourceType,
    builder: (column) => ColumnFilters(column),
  );

  $$UtilisateursTableFilterComposer get auteurId {
    final $$UtilisateursTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.auteurId,
      referencedTable: $db.utilisateurs,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UtilisateursTableFilterComposer(
            $db: $db,
            $table: $db.utilisateurs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MatieresTableFilterComposer get matiereId {
    final $$MatieresTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.matiereId,
      referencedTable: $db.matieres,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MatieresTableFilterComposer(
            $db: $db,
            $table: $db.matieres,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$NiveauxTableFilterComposer get niveauId {
    final $$NiveauxTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.niveauId,
      referencedTable: $db.niveaux,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$NiveauxTableFilterComposer(
            $db: $db,
            $table: $db.niveaux,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$EcolesTableFilterComposer get ecoleId {
    final $$EcolesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ecoleId,
      referencedTable: $db.ecoles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EcolesTableFilterComposer(
            $db: $db,
            $table: $db.ecoles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> pagesRefs(
    Expression<bool> Function($$PagesTableFilterComposer f) f,
  ) {
    final $$PagesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.pages,
      getReferencedColumn: (t) => t.leconId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PagesTableFilterComposer(
            $db: $db,
            $table: $db.pages,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> flashcardsRefs(
    Expression<bool> Function($$FlashcardsTableFilterComposer f) f,
  ) {
    final $$FlashcardsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.flashcards,
      getReferencedColumn: (t) => t.leconId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FlashcardsTableFilterComposer(
            $db: $db,
            $table: $db.flashcards,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$LeconsTableOrderingComposer
    extends Composer<_$AppDatabase, $LeconsTable> {
  $$LeconsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get titre => $composableBuilder(
    column: $table.titre,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contenuBrut => $composableBuilder(
    column: $table.contenuBrut,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contenuStyl => $composableBuilder(
    column: $table.contenuStyl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get visibilite => $composableBuilder(
    column: $table.visibilite,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get dateUpd => $composableBuilder(
    column: $table.dateUpd,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get dateDel => $composableBuilder(
    column: $table.dateDel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sourceType => $composableBuilder(
    column: $table.sourceType,
    builder: (column) => ColumnOrderings(column),
  );

  $$UtilisateursTableOrderingComposer get auteurId {
    final $$UtilisateursTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.auteurId,
      referencedTable: $db.utilisateurs,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UtilisateursTableOrderingComposer(
            $db: $db,
            $table: $db.utilisateurs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MatieresTableOrderingComposer get matiereId {
    final $$MatieresTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.matiereId,
      referencedTable: $db.matieres,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MatieresTableOrderingComposer(
            $db: $db,
            $table: $db.matieres,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$NiveauxTableOrderingComposer get niveauId {
    final $$NiveauxTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.niveauId,
      referencedTable: $db.niveaux,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$NiveauxTableOrderingComposer(
            $db: $db,
            $table: $db.niveaux,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$EcolesTableOrderingComposer get ecoleId {
    final $$EcolesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ecoleId,
      referencedTable: $db.ecoles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EcolesTableOrderingComposer(
            $db: $db,
            $table: $db.ecoles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LeconsTableAnnotationComposer
    extends Composer<_$AppDatabase, $LeconsTable> {
  $$LeconsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get titre =>
      $composableBuilder(column: $table.titre, builder: (column) => column);

  GeneratedColumn<String> get contenuBrut => $composableBuilder(
    column: $table.contenuBrut,
    builder: (column) => column,
  );

  GeneratedColumn<String> get contenuStyl => $composableBuilder(
    column: $table.contenuStyl,
    builder: (column) => column,
  );

  GeneratedColumn<String> get visibilite => $composableBuilder(
    column: $table.visibilite,
    builder: (column) => column,
  );

  GeneratedColumn<int> get dateUpd =>
      $composableBuilder(column: $table.dateUpd, builder: (column) => column);

  GeneratedColumn<int> get dateDel =>
      $composableBuilder(column: $table.dateDel, builder: (column) => column);

  GeneratedColumn<String> get sourceType => $composableBuilder(
    column: $table.sourceType,
    builder: (column) => column,
  );

  $$UtilisateursTableAnnotationComposer get auteurId {
    final $$UtilisateursTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.auteurId,
      referencedTable: $db.utilisateurs,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UtilisateursTableAnnotationComposer(
            $db: $db,
            $table: $db.utilisateurs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MatieresTableAnnotationComposer get matiereId {
    final $$MatieresTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.matiereId,
      referencedTable: $db.matieres,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MatieresTableAnnotationComposer(
            $db: $db,
            $table: $db.matieres,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$NiveauxTableAnnotationComposer get niveauId {
    final $$NiveauxTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.niveauId,
      referencedTable: $db.niveaux,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$NiveauxTableAnnotationComposer(
            $db: $db,
            $table: $db.niveaux,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$EcolesTableAnnotationComposer get ecoleId {
    final $$EcolesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ecoleId,
      referencedTable: $db.ecoles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EcolesTableAnnotationComposer(
            $db: $db,
            $table: $db.ecoles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> pagesRefs<T extends Object>(
    Expression<T> Function($$PagesTableAnnotationComposer a) f,
  ) {
    final $$PagesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.pages,
      getReferencedColumn: (t) => t.leconId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PagesTableAnnotationComposer(
            $db: $db,
            $table: $db.pages,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> flashcardsRefs<T extends Object>(
    Expression<T> Function($$FlashcardsTableAnnotationComposer a) f,
  ) {
    final $$FlashcardsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.flashcards,
      getReferencedColumn: (t) => t.leconId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FlashcardsTableAnnotationComposer(
            $db: $db,
            $table: $db.flashcards,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$LeconsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LeconsTable,
          Lecon,
          $$LeconsTableFilterComposer,
          $$LeconsTableOrderingComposer,
          $$LeconsTableAnnotationComposer,
          $$LeconsTableCreateCompanionBuilder,
          $$LeconsTableUpdateCompanionBuilder,
          (Lecon, $$LeconsTableReferences),
          Lecon,
          PrefetchHooks Function({
            bool auteurId,
            bool matiereId,
            bool niveauId,
            bool ecoleId,
            bool pagesRefs,
            bool flashcardsRefs,
          })
        > {
  $$LeconsTableTableManager(_$AppDatabase db, $LeconsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LeconsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LeconsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LeconsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> titre = const Value.absent(),
                Value<String?> contenuBrut = const Value.absent(),
                Value<String?> contenuStyl = const Value.absent(),
                Value<String> visibilite = const Value.absent(),
                Value<String?> auteurId = const Value.absent(),
                Value<String?> matiereId = const Value.absent(),
                Value<String?> niveauId = const Value.absent(),
                Value<String?> ecoleId = const Value.absent(),
                Value<int> dateUpd = const Value.absent(),
                Value<int?> dateDel = const Value.absent(),
                Value<String> sourceType = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LeconsCompanion(
                id: id,
                titre: titre,
                contenuBrut: contenuBrut,
                contenuStyl: contenuStyl,
                visibilite: visibilite,
                auteurId: auteurId,
                matiereId: matiereId,
                niveauId: niveauId,
                ecoleId: ecoleId,
                dateUpd: dateUpd,
                dateDel: dateDel,
                sourceType: sourceType,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String titre,
                Value<String?> contenuBrut = const Value.absent(),
                Value<String?> contenuStyl = const Value.absent(),
                Value<String> visibilite = const Value.absent(),
                Value<String?> auteurId = const Value.absent(),
                Value<String?> matiereId = const Value.absent(),
                Value<String?> niveauId = const Value.absent(),
                Value<String?> ecoleId = const Value.absent(),
                required int dateUpd,
                Value<int?> dateDel = const Value.absent(),
                Value<String> sourceType = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LeconsCompanion.insert(
                id: id,
                titre: titre,
                contenuBrut: contenuBrut,
                contenuStyl: contenuStyl,
                visibilite: visibilite,
                auteurId: auteurId,
                matiereId: matiereId,
                niveauId: niveauId,
                ecoleId: ecoleId,
                dateUpd: dateUpd,
                dateDel: dateDel,
                sourceType: sourceType,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$LeconsTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                auteurId = false,
                matiereId = false,
                niveauId = false,
                ecoleId = false,
                pagesRefs = false,
                flashcardsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (pagesRefs) db.pages,
                    if (flashcardsRefs) db.flashcards,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (auteurId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.auteurId,
                                    referencedTable: $$LeconsTableReferences
                                        ._auteurIdTable(db),
                                    referencedColumn: $$LeconsTableReferences
                                        ._auteurIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }
                        if (matiereId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.matiereId,
                                    referencedTable: $$LeconsTableReferences
                                        ._matiereIdTable(db),
                                    referencedColumn: $$LeconsTableReferences
                                        ._matiereIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }
                        if (niveauId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.niveauId,
                                    referencedTable: $$LeconsTableReferences
                                        ._niveauIdTable(db),
                                    referencedColumn: $$LeconsTableReferences
                                        ._niveauIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }
                        if (ecoleId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.ecoleId,
                                    referencedTable: $$LeconsTableReferences
                                        ._ecoleIdTable(db),
                                    referencedColumn: $$LeconsTableReferences
                                        ._ecoleIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (pagesRefs)
                        await $_getPrefetchedData<Lecon, $LeconsTable, Page>(
                          currentTable: table,
                          referencedTable: $$LeconsTableReferences
                              ._pagesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$LeconsTableReferences(db, table, p0).pagesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.leconId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (flashcardsRefs)
                        await $_getPrefetchedData<
                          Lecon,
                          $LeconsTable,
                          Flashcard
                        >(
                          currentTable: table,
                          referencedTable: $$LeconsTableReferences
                              ._flashcardsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$LeconsTableReferences(
                                db,
                                table,
                                p0,
                              ).flashcardsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.leconId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$LeconsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LeconsTable,
      Lecon,
      $$LeconsTableFilterComposer,
      $$LeconsTableOrderingComposer,
      $$LeconsTableAnnotationComposer,
      $$LeconsTableCreateCompanionBuilder,
      $$LeconsTableUpdateCompanionBuilder,
      (Lecon, $$LeconsTableReferences),
      Lecon,
      PrefetchHooks Function({
        bool auteurId,
        bool matiereId,
        bool niveauId,
        bool ecoleId,
        bool pagesRefs,
        bool flashcardsRefs,
      })
    >;
typedef $$CurriculumsTableCreateCompanionBuilder =
    CurriculumsCompanion Function({
      required String id,
      required String ecoleId,
      required String niveauId,
      required String matiereId,
      Value<int> rowid,
    });
typedef $$CurriculumsTableUpdateCompanionBuilder =
    CurriculumsCompanion Function({
      Value<String> id,
      Value<String> ecoleId,
      Value<String> niveauId,
      Value<String> matiereId,
      Value<int> rowid,
    });

final class $$CurriculumsTableReferences
    extends BaseReferences<_$AppDatabase, $CurriculumsTable, Curriculum> {
  $$CurriculumsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $EcolesTable _ecoleIdTable(_$AppDatabase db) => db.ecoles.createAlias(
    $_aliasNameGenerator(db.curriculums.ecoleId, db.ecoles.id),
  );

  $$EcolesTableProcessedTableManager get ecoleId {
    final $_column = $_itemColumn<String>('ecole_id')!;

    final manager = $$EcolesTableTableManager(
      $_db,
      $_db.ecoles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_ecoleIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $NiveauxTable _niveauIdTable(_$AppDatabase db) =>
      db.niveaux.createAlias(
        $_aliasNameGenerator(db.curriculums.niveauId, db.niveaux.id),
      );

  $$NiveauxTableProcessedTableManager get niveauId {
    final $_column = $_itemColumn<String>('niveau_id')!;

    final manager = $$NiveauxTableTableManager(
      $_db,
      $_db.niveaux,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_niveauIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $MatieresTable _matiereIdTable(_$AppDatabase db) =>
      db.matieres.createAlias(
        $_aliasNameGenerator(db.curriculums.matiereId, db.matieres.id),
      );

  $$MatieresTableProcessedTableManager get matiereId {
    final $_column = $_itemColumn<String>('matiere_id')!;

    final manager = $$MatieresTableTableManager(
      $_db,
      $_db.matieres,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_matiereIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$CurriculumsTableFilterComposer
    extends Composer<_$AppDatabase, $CurriculumsTable> {
  $$CurriculumsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  $$EcolesTableFilterComposer get ecoleId {
    final $$EcolesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ecoleId,
      referencedTable: $db.ecoles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EcolesTableFilterComposer(
            $db: $db,
            $table: $db.ecoles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$NiveauxTableFilterComposer get niveauId {
    final $$NiveauxTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.niveauId,
      referencedTable: $db.niveaux,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$NiveauxTableFilterComposer(
            $db: $db,
            $table: $db.niveaux,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MatieresTableFilterComposer get matiereId {
    final $$MatieresTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.matiereId,
      referencedTable: $db.matieres,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MatieresTableFilterComposer(
            $db: $db,
            $table: $db.matieres,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CurriculumsTableOrderingComposer
    extends Composer<_$AppDatabase, $CurriculumsTable> {
  $$CurriculumsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  $$EcolesTableOrderingComposer get ecoleId {
    final $$EcolesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ecoleId,
      referencedTable: $db.ecoles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EcolesTableOrderingComposer(
            $db: $db,
            $table: $db.ecoles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$NiveauxTableOrderingComposer get niveauId {
    final $$NiveauxTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.niveauId,
      referencedTable: $db.niveaux,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$NiveauxTableOrderingComposer(
            $db: $db,
            $table: $db.niveaux,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MatieresTableOrderingComposer get matiereId {
    final $$MatieresTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.matiereId,
      referencedTable: $db.matieres,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MatieresTableOrderingComposer(
            $db: $db,
            $table: $db.matieres,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CurriculumsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CurriculumsTable> {
  $$CurriculumsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  $$EcolesTableAnnotationComposer get ecoleId {
    final $$EcolesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ecoleId,
      referencedTable: $db.ecoles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EcolesTableAnnotationComposer(
            $db: $db,
            $table: $db.ecoles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$NiveauxTableAnnotationComposer get niveauId {
    final $$NiveauxTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.niveauId,
      referencedTable: $db.niveaux,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$NiveauxTableAnnotationComposer(
            $db: $db,
            $table: $db.niveaux,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MatieresTableAnnotationComposer get matiereId {
    final $$MatieresTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.matiereId,
      referencedTable: $db.matieres,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MatieresTableAnnotationComposer(
            $db: $db,
            $table: $db.matieres,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CurriculumsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CurriculumsTable,
          Curriculum,
          $$CurriculumsTableFilterComposer,
          $$CurriculumsTableOrderingComposer,
          $$CurriculumsTableAnnotationComposer,
          $$CurriculumsTableCreateCompanionBuilder,
          $$CurriculumsTableUpdateCompanionBuilder,
          (Curriculum, $$CurriculumsTableReferences),
          Curriculum,
          PrefetchHooks Function({bool ecoleId, bool niveauId, bool matiereId})
        > {
  $$CurriculumsTableTableManager(_$AppDatabase db, $CurriculumsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CurriculumsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CurriculumsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CurriculumsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> ecoleId = const Value.absent(),
                Value<String> niveauId = const Value.absent(),
                Value<String> matiereId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CurriculumsCompanion(
                id: id,
                ecoleId: ecoleId,
                niveauId: niveauId,
                matiereId: matiereId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String ecoleId,
                required String niveauId,
                required String matiereId,
                Value<int> rowid = const Value.absent(),
              }) => CurriculumsCompanion.insert(
                id: id,
                ecoleId: ecoleId,
                niveauId: niveauId,
                matiereId: matiereId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CurriculumsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({ecoleId = false, niveauId = false, matiereId = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (ecoleId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.ecoleId,
                                    referencedTable:
                                        $$CurriculumsTableReferences
                                            ._ecoleIdTable(db),
                                    referencedColumn:
                                        $$CurriculumsTableReferences
                                            ._ecoleIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (niveauId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.niveauId,
                                    referencedTable:
                                        $$CurriculumsTableReferences
                                            ._niveauIdTable(db),
                                    referencedColumn:
                                        $$CurriculumsTableReferences
                                            ._niveauIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (matiereId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.matiereId,
                                    referencedTable:
                                        $$CurriculumsTableReferences
                                            ._matiereIdTable(db),
                                    referencedColumn:
                                        $$CurriculumsTableReferences
                                            ._matiereIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [];
                  },
                );
              },
        ),
      );
}

typedef $$CurriculumsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CurriculumsTable,
      Curriculum,
      $$CurriculumsTableFilterComposer,
      $$CurriculumsTableOrderingComposer,
      $$CurriculumsTableAnnotationComposer,
      $$CurriculumsTableCreateCompanionBuilder,
      $$CurriculumsTableUpdateCompanionBuilder,
      (Curriculum, $$CurriculumsTableReferences),
      Curriculum,
      PrefetchHooks Function({bool ecoleId, bool niveauId, bool matiereId})
    >;
typedef $$PagesTableCreateCompanionBuilder =
    PagesCompanion Function({
      required String id,
      required String leconId,
      required int numeroPage,
      Value<String?> cheminImage,
      Value<String?> ocrTexte,
      Value<String?> contenuStyl,
      required int ordre,
      Value<int> rowid,
    });
typedef $$PagesTableUpdateCompanionBuilder =
    PagesCompanion Function({
      Value<String> id,
      Value<String> leconId,
      Value<int> numeroPage,
      Value<String?> cheminImage,
      Value<String?> ocrTexte,
      Value<String?> contenuStyl,
      Value<int> ordre,
      Value<int> rowid,
    });

final class $$PagesTableReferences
    extends BaseReferences<_$AppDatabase, $PagesTable, Page> {
  $$PagesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $LeconsTable _leconIdTable(_$AppDatabase db) => db.lecons.createAlias(
    $_aliasNameGenerator(db.pages.leconId, db.lecons.id),
  );

  $$LeconsTableProcessedTableManager get leconId {
    final $_column = $_itemColumn<String>('lecon_id')!;

    final manager = $$LeconsTableTableManager(
      $_db,
      $_db.lecons,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_leconIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PagesTableFilterComposer extends Composer<_$AppDatabase, $PagesTable> {
  $$PagesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get numeroPage => $composableBuilder(
    column: $table.numeroPage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get cheminImage => $composableBuilder(
    column: $table.cheminImage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ocrTexte => $composableBuilder(
    column: $table.ocrTexte,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contenuStyl => $composableBuilder(
    column: $table.contenuStyl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get ordre => $composableBuilder(
    column: $table.ordre,
    builder: (column) => ColumnFilters(column),
  );

  $$LeconsTableFilterComposer get leconId {
    final $$LeconsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.leconId,
      referencedTable: $db.lecons,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LeconsTableFilterComposer(
            $db: $db,
            $table: $db.lecons,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PagesTableOrderingComposer
    extends Composer<_$AppDatabase, $PagesTable> {
  $$PagesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get numeroPage => $composableBuilder(
    column: $table.numeroPage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get cheminImage => $composableBuilder(
    column: $table.cheminImage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ocrTexte => $composableBuilder(
    column: $table.ocrTexte,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contenuStyl => $composableBuilder(
    column: $table.contenuStyl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get ordre => $composableBuilder(
    column: $table.ordre,
    builder: (column) => ColumnOrderings(column),
  );

  $$LeconsTableOrderingComposer get leconId {
    final $$LeconsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.leconId,
      referencedTable: $db.lecons,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LeconsTableOrderingComposer(
            $db: $db,
            $table: $db.lecons,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PagesTableAnnotationComposer
    extends Composer<_$AppDatabase, $PagesTable> {
  $$PagesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get numeroPage => $composableBuilder(
    column: $table.numeroPage,
    builder: (column) => column,
  );

  GeneratedColumn<String> get cheminImage => $composableBuilder(
    column: $table.cheminImage,
    builder: (column) => column,
  );

  GeneratedColumn<String> get ocrTexte =>
      $composableBuilder(column: $table.ocrTexte, builder: (column) => column);

  GeneratedColumn<String> get contenuStyl => $composableBuilder(
    column: $table.contenuStyl,
    builder: (column) => column,
  );

  GeneratedColumn<int> get ordre =>
      $composableBuilder(column: $table.ordre, builder: (column) => column);

  $$LeconsTableAnnotationComposer get leconId {
    final $$LeconsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.leconId,
      referencedTable: $db.lecons,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LeconsTableAnnotationComposer(
            $db: $db,
            $table: $db.lecons,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PagesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PagesTable,
          Page,
          $$PagesTableFilterComposer,
          $$PagesTableOrderingComposer,
          $$PagesTableAnnotationComposer,
          $$PagesTableCreateCompanionBuilder,
          $$PagesTableUpdateCompanionBuilder,
          (Page, $$PagesTableReferences),
          Page,
          PrefetchHooks Function({bool leconId})
        > {
  $$PagesTableTableManager(_$AppDatabase db, $PagesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PagesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PagesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PagesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> leconId = const Value.absent(),
                Value<int> numeroPage = const Value.absent(),
                Value<String?> cheminImage = const Value.absent(),
                Value<String?> ocrTexte = const Value.absent(),
                Value<String?> contenuStyl = const Value.absent(),
                Value<int> ordre = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PagesCompanion(
                id: id,
                leconId: leconId,
                numeroPage: numeroPage,
                cheminImage: cheminImage,
                ocrTexte: ocrTexte,
                contenuStyl: contenuStyl,
                ordre: ordre,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String leconId,
                required int numeroPage,
                Value<String?> cheminImage = const Value.absent(),
                Value<String?> ocrTexte = const Value.absent(),
                Value<String?> contenuStyl = const Value.absent(),
                required int ordre,
                Value<int> rowid = const Value.absent(),
              }) => PagesCompanion.insert(
                id: id,
                leconId: leconId,
                numeroPage: numeroPage,
                cheminImage: cheminImage,
                ocrTexte: ocrTexte,
                contenuStyl: contenuStyl,
                ordre: ordre,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$PagesTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({leconId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (leconId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.leconId,
                                referencedTable: $$PagesTableReferences
                                    ._leconIdTable(db),
                                referencedColumn: $$PagesTableReferences
                                    ._leconIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$PagesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PagesTable,
      Page,
      $$PagesTableFilterComposer,
      $$PagesTableOrderingComposer,
      $$PagesTableAnnotationComposer,
      $$PagesTableCreateCompanionBuilder,
      $$PagesTableUpdateCompanionBuilder,
      (Page, $$PagesTableReferences),
      Page,
      PrefetchHooks Function({bool leconId})
    >;
typedef $$FlashcardsTableCreateCompanionBuilder =
    FlashcardsCompanion Function({
      required String id,
      Value<String?> ecoleId,
      Value<String?> niveauId,
      Value<String?> leconId,
      required String matiereId,
      required String userId,
      required String question,
      required String reponse,
      Value<String?> explication,
      Value<int> intervalDays,
      Value<int> repetitions,
      Value<double> easinessFactor,
      required int nextReviewDate,
      Value<bool> isActive,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });
typedef $$FlashcardsTableUpdateCompanionBuilder =
    FlashcardsCompanion Function({
      Value<String> id,
      Value<String?> ecoleId,
      Value<String?> niveauId,
      Value<String?> leconId,
      Value<String> matiereId,
      Value<String> userId,
      Value<String> question,
      Value<String> reponse,
      Value<String?> explication,
      Value<int> intervalDays,
      Value<int> repetitions,
      Value<double> easinessFactor,
      Value<int> nextReviewDate,
      Value<bool> isActive,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$FlashcardsTableReferences
    extends BaseReferences<_$AppDatabase, $FlashcardsTable, Flashcard> {
  $$FlashcardsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $EcolesTable _ecoleIdTable(_$AppDatabase db) => db.ecoles.createAlias(
    $_aliasNameGenerator(db.flashcards.ecoleId, db.ecoles.id),
  );

  $$EcolesTableProcessedTableManager? get ecoleId {
    final $_column = $_itemColumn<String>('ecole_id');
    if ($_column == null) return null;
    final manager = $$EcolesTableTableManager(
      $_db,
      $_db.ecoles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_ecoleIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $NiveauxTable _niveauIdTable(_$AppDatabase db) => db.niveaux
      .createAlias($_aliasNameGenerator(db.flashcards.niveauId, db.niveaux.id));

  $$NiveauxTableProcessedTableManager? get niveauId {
    final $_column = $_itemColumn<String>('niveau_id');
    if ($_column == null) return null;
    final manager = $$NiveauxTableTableManager(
      $_db,
      $_db.niveaux,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_niveauIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $LeconsTable _leconIdTable(_$AppDatabase db) => db.lecons.createAlias(
    $_aliasNameGenerator(db.flashcards.leconId, db.lecons.id),
  );

  $$LeconsTableProcessedTableManager? get leconId {
    final $_column = $_itemColumn<String>('lecon_id');
    if ($_column == null) return null;
    final manager = $$LeconsTableTableManager(
      $_db,
      $_db.lecons,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_leconIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $MatieresTable _matiereIdTable(_$AppDatabase db) =>
      db.matieres.createAlias(
        $_aliasNameGenerator(db.flashcards.matiereId, db.matieres.id),
      );

  $$MatieresTableProcessedTableManager get matiereId {
    final $_column = $_itemColumn<String>('matiere_id')!;

    final manager = $$MatieresTableTableManager(
      $_db,
      $_db.matieres,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_matiereIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $UtilisateursTable _userIdTable(_$AppDatabase db) =>
      db.utilisateurs.createAlias(
        $_aliasNameGenerator(db.flashcards.userId, db.utilisateurs.id),
      );

  $$UtilisateursTableProcessedTableManager get userId {
    final $_column = $_itemColumn<String>('user_id')!;

    final manager = $$UtilisateursTableTableManager(
      $_db,
      $_db.utilisateurs,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_userIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$FlashcardsTableFilterComposer
    extends Composer<_$AppDatabase, $FlashcardsTable> {
  $$FlashcardsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get question => $composableBuilder(
    column: $table.question,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reponse => $composableBuilder(
    column: $table.reponse,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get explication => $composableBuilder(
    column: $table.explication,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get intervalDays => $composableBuilder(
    column: $table.intervalDays,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get repetitions => $composableBuilder(
    column: $table.repetitions,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get easinessFactor => $composableBuilder(
    column: $table.easinessFactor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get nextReviewDate => $composableBuilder(
    column: $table.nextReviewDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$EcolesTableFilterComposer get ecoleId {
    final $$EcolesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ecoleId,
      referencedTable: $db.ecoles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EcolesTableFilterComposer(
            $db: $db,
            $table: $db.ecoles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$NiveauxTableFilterComposer get niveauId {
    final $$NiveauxTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.niveauId,
      referencedTable: $db.niveaux,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$NiveauxTableFilterComposer(
            $db: $db,
            $table: $db.niveaux,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$LeconsTableFilterComposer get leconId {
    final $$LeconsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.leconId,
      referencedTable: $db.lecons,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LeconsTableFilterComposer(
            $db: $db,
            $table: $db.lecons,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MatieresTableFilterComposer get matiereId {
    final $$MatieresTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.matiereId,
      referencedTable: $db.matieres,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MatieresTableFilterComposer(
            $db: $db,
            $table: $db.matieres,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UtilisateursTableFilterComposer get userId {
    final $$UtilisateursTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.utilisateurs,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UtilisateursTableFilterComposer(
            $db: $db,
            $table: $db.utilisateurs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FlashcardsTableOrderingComposer
    extends Composer<_$AppDatabase, $FlashcardsTable> {
  $$FlashcardsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get question => $composableBuilder(
    column: $table.question,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reponse => $composableBuilder(
    column: $table.reponse,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get explication => $composableBuilder(
    column: $table.explication,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get intervalDays => $composableBuilder(
    column: $table.intervalDays,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get repetitions => $composableBuilder(
    column: $table.repetitions,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get easinessFactor => $composableBuilder(
    column: $table.easinessFactor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get nextReviewDate => $composableBuilder(
    column: $table.nextReviewDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$EcolesTableOrderingComposer get ecoleId {
    final $$EcolesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ecoleId,
      referencedTable: $db.ecoles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EcolesTableOrderingComposer(
            $db: $db,
            $table: $db.ecoles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$NiveauxTableOrderingComposer get niveauId {
    final $$NiveauxTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.niveauId,
      referencedTable: $db.niveaux,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$NiveauxTableOrderingComposer(
            $db: $db,
            $table: $db.niveaux,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$LeconsTableOrderingComposer get leconId {
    final $$LeconsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.leconId,
      referencedTable: $db.lecons,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LeconsTableOrderingComposer(
            $db: $db,
            $table: $db.lecons,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MatieresTableOrderingComposer get matiereId {
    final $$MatieresTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.matiereId,
      referencedTable: $db.matieres,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MatieresTableOrderingComposer(
            $db: $db,
            $table: $db.matieres,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UtilisateursTableOrderingComposer get userId {
    final $$UtilisateursTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.utilisateurs,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UtilisateursTableOrderingComposer(
            $db: $db,
            $table: $db.utilisateurs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FlashcardsTableAnnotationComposer
    extends Composer<_$AppDatabase, $FlashcardsTable> {
  $$FlashcardsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get question =>
      $composableBuilder(column: $table.question, builder: (column) => column);

  GeneratedColumn<String> get reponse =>
      $composableBuilder(column: $table.reponse, builder: (column) => column);

  GeneratedColumn<String> get explication => $composableBuilder(
    column: $table.explication,
    builder: (column) => column,
  );

  GeneratedColumn<int> get intervalDays => $composableBuilder(
    column: $table.intervalDays,
    builder: (column) => column,
  );

  GeneratedColumn<int> get repetitions => $composableBuilder(
    column: $table.repetitions,
    builder: (column) => column,
  );

  GeneratedColumn<double> get easinessFactor => $composableBuilder(
    column: $table.easinessFactor,
    builder: (column) => column,
  );

  GeneratedColumn<int> get nextReviewDate => $composableBuilder(
    column: $table.nextReviewDate,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$EcolesTableAnnotationComposer get ecoleId {
    final $$EcolesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ecoleId,
      referencedTable: $db.ecoles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EcolesTableAnnotationComposer(
            $db: $db,
            $table: $db.ecoles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$NiveauxTableAnnotationComposer get niveauId {
    final $$NiveauxTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.niveauId,
      referencedTable: $db.niveaux,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$NiveauxTableAnnotationComposer(
            $db: $db,
            $table: $db.niveaux,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$LeconsTableAnnotationComposer get leconId {
    final $$LeconsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.leconId,
      referencedTable: $db.lecons,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LeconsTableAnnotationComposer(
            $db: $db,
            $table: $db.lecons,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MatieresTableAnnotationComposer get matiereId {
    final $$MatieresTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.matiereId,
      referencedTable: $db.matieres,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MatieresTableAnnotationComposer(
            $db: $db,
            $table: $db.matieres,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UtilisateursTableAnnotationComposer get userId {
    final $$UtilisateursTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.utilisateurs,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UtilisateursTableAnnotationComposer(
            $db: $db,
            $table: $db.utilisateurs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FlashcardsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FlashcardsTable,
          Flashcard,
          $$FlashcardsTableFilterComposer,
          $$FlashcardsTableOrderingComposer,
          $$FlashcardsTableAnnotationComposer,
          $$FlashcardsTableCreateCompanionBuilder,
          $$FlashcardsTableUpdateCompanionBuilder,
          (Flashcard, $$FlashcardsTableReferences),
          Flashcard,
          PrefetchHooks Function({
            bool ecoleId,
            bool niveauId,
            bool leconId,
            bool matiereId,
            bool userId,
          })
        > {
  $$FlashcardsTableTableManager(_$AppDatabase db, $FlashcardsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FlashcardsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FlashcardsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FlashcardsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> ecoleId = const Value.absent(),
                Value<String?> niveauId = const Value.absent(),
                Value<String?> leconId = const Value.absent(),
                Value<String> matiereId = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<String> question = const Value.absent(),
                Value<String> reponse = const Value.absent(),
                Value<String?> explication = const Value.absent(),
                Value<int> intervalDays = const Value.absent(),
                Value<int> repetitions = const Value.absent(),
                Value<double> easinessFactor = const Value.absent(),
                Value<int> nextReviewDate = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FlashcardsCompanion(
                id: id,
                ecoleId: ecoleId,
                niveauId: niveauId,
                leconId: leconId,
                matiereId: matiereId,
                userId: userId,
                question: question,
                reponse: reponse,
                explication: explication,
                intervalDays: intervalDays,
                repetitions: repetitions,
                easinessFactor: easinessFactor,
                nextReviewDate: nextReviewDate,
                isActive: isActive,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String?> ecoleId = const Value.absent(),
                Value<String?> niveauId = const Value.absent(),
                Value<String?> leconId = const Value.absent(),
                required String matiereId,
                required String userId,
                required String question,
                required String reponse,
                Value<String?> explication = const Value.absent(),
                Value<int> intervalDays = const Value.absent(),
                Value<int> repetitions = const Value.absent(),
                Value<double> easinessFactor = const Value.absent(),
                required int nextReviewDate,
                Value<bool> isActive = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FlashcardsCompanion.insert(
                id: id,
                ecoleId: ecoleId,
                niveauId: niveauId,
                leconId: leconId,
                matiereId: matiereId,
                userId: userId,
                question: question,
                reponse: reponse,
                explication: explication,
                intervalDays: intervalDays,
                repetitions: repetitions,
                easinessFactor: easinessFactor,
                nextReviewDate: nextReviewDate,
                isActive: isActive,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$FlashcardsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                ecoleId = false,
                niveauId = false,
                leconId = false,
                matiereId = false,
                userId = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (ecoleId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.ecoleId,
                                    referencedTable: $$FlashcardsTableReferences
                                        ._ecoleIdTable(db),
                                    referencedColumn:
                                        $$FlashcardsTableReferences
                                            ._ecoleIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (niveauId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.niveauId,
                                    referencedTable: $$FlashcardsTableReferences
                                        ._niveauIdTable(db),
                                    referencedColumn:
                                        $$FlashcardsTableReferences
                                            ._niveauIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (leconId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.leconId,
                                    referencedTable: $$FlashcardsTableReferences
                                        ._leconIdTable(db),
                                    referencedColumn:
                                        $$FlashcardsTableReferences
                                            ._leconIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (matiereId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.matiereId,
                                    referencedTable: $$FlashcardsTableReferences
                                        ._matiereIdTable(db),
                                    referencedColumn:
                                        $$FlashcardsTableReferences
                                            ._matiereIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (userId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.userId,
                                    referencedTable: $$FlashcardsTableReferences
                                        ._userIdTable(db),
                                    referencedColumn:
                                        $$FlashcardsTableReferences
                                            ._userIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [];
                  },
                );
              },
        ),
      );
}

typedef $$FlashcardsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FlashcardsTable,
      Flashcard,
      $$FlashcardsTableFilterComposer,
      $$FlashcardsTableOrderingComposer,
      $$FlashcardsTableAnnotationComposer,
      $$FlashcardsTableCreateCompanionBuilder,
      $$FlashcardsTableUpdateCompanionBuilder,
      (Flashcard, $$FlashcardsTableReferences),
      Flashcard,
      PrefetchHooks Function({
        bool ecoleId,
        bool niveauId,
        bool leconId,
        bool matiereId,
        bool userId,
      })
    >;
typedef $$AssignationsEcoleTableCreateCompanionBuilder =
    AssignationsEcoleCompanion Function({
      required String id,
      required String userId,
      required String ecoleId,
      required String roleId,
      required DateTime dateDebut,
      Value<DateTime?> dateFin,
      Value<String> statut,
      Value<bool> estActif,
      Value<int> rowid,
    });
typedef $$AssignationsEcoleTableUpdateCompanionBuilder =
    AssignationsEcoleCompanion Function({
      Value<String> id,
      Value<String> userId,
      Value<String> ecoleId,
      Value<String> roleId,
      Value<DateTime> dateDebut,
      Value<DateTime?> dateFin,
      Value<String> statut,
      Value<bool> estActif,
      Value<int> rowid,
    });

class $$AssignationsEcoleTableFilterComposer
    extends Composer<_$AppDatabase, $AssignationsEcoleTable> {
  $$AssignationsEcoleTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ecoleId => $composableBuilder(
    column: $table.ecoleId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get roleId => $composableBuilder(
    column: $table.roleId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dateDebut => $composableBuilder(
    column: $table.dateDebut,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dateFin => $composableBuilder(
    column: $table.dateFin,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get statut => $composableBuilder(
    column: $table.statut,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get estActif => $composableBuilder(
    column: $table.estActif,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AssignationsEcoleTableOrderingComposer
    extends Composer<_$AppDatabase, $AssignationsEcoleTable> {
  $$AssignationsEcoleTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ecoleId => $composableBuilder(
    column: $table.ecoleId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get roleId => $composableBuilder(
    column: $table.roleId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dateDebut => $composableBuilder(
    column: $table.dateDebut,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dateFin => $composableBuilder(
    column: $table.dateFin,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get statut => $composableBuilder(
    column: $table.statut,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get estActif => $composableBuilder(
    column: $table.estActif,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AssignationsEcoleTableAnnotationComposer
    extends Composer<_$AppDatabase, $AssignationsEcoleTable> {
  $$AssignationsEcoleTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get ecoleId =>
      $composableBuilder(column: $table.ecoleId, builder: (column) => column);

  GeneratedColumn<String> get roleId =>
      $composableBuilder(column: $table.roleId, builder: (column) => column);

  GeneratedColumn<DateTime> get dateDebut =>
      $composableBuilder(column: $table.dateDebut, builder: (column) => column);

  GeneratedColumn<DateTime> get dateFin =>
      $composableBuilder(column: $table.dateFin, builder: (column) => column);

  GeneratedColumn<String> get statut =>
      $composableBuilder(column: $table.statut, builder: (column) => column);

  GeneratedColumn<bool> get estActif =>
      $composableBuilder(column: $table.estActif, builder: (column) => column);
}

class $$AssignationsEcoleTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AssignationsEcoleTable,
          AssignationEcole,
          $$AssignationsEcoleTableFilterComposer,
          $$AssignationsEcoleTableOrderingComposer,
          $$AssignationsEcoleTableAnnotationComposer,
          $$AssignationsEcoleTableCreateCompanionBuilder,
          $$AssignationsEcoleTableUpdateCompanionBuilder,
          (
            AssignationEcole,
            BaseReferences<
              _$AppDatabase,
              $AssignationsEcoleTable,
              AssignationEcole
            >,
          ),
          AssignationEcole,
          PrefetchHooks Function()
        > {
  $$AssignationsEcoleTableTableManager(
    _$AppDatabase db,
    $AssignationsEcoleTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AssignationsEcoleTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AssignationsEcoleTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AssignationsEcoleTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<String> ecoleId = const Value.absent(),
                Value<String> roleId = const Value.absent(),
                Value<DateTime> dateDebut = const Value.absent(),
                Value<DateTime?> dateFin = const Value.absent(),
                Value<String> statut = const Value.absent(),
                Value<bool> estActif = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AssignationsEcoleCompanion(
                id: id,
                userId: userId,
                ecoleId: ecoleId,
                roleId: roleId,
                dateDebut: dateDebut,
                dateFin: dateFin,
                statut: statut,
                estActif: estActif,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String userId,
                required String ecoleId,
                required String roleId,
                required DateTime dateDebut,
                Value<DateTime?> dateFin = const Value.absent(),
                Value<String> statut = const Value.absent(),
                Value<bool> estActif = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AssignationsEcoleCompanion.insert(
                id: id,
                userId: userId,
                ecoleId: ecoleId,
                roleId: roleId,
                dateDebut: dateDebut,
                dateFin: dateFin,
                statut: statut,
                estActif: estActif,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AssignationsEcoleTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AssignationsEcoleTable,
      AssignationEcole,
      $$AssignationsEcoleTableFilterComposer,
      $$AssignationsEcoleTableOrderingComposer,
      $$AssignationsEcoleTableAnnotationComposer,
      $$AssignationsEcoleTableCreateCompanionBuilder,
      $$AssignationsEcoleTableUpdateCompanionBuilder,
      (
        AssignationEcole,
        BaseReferences<
          _$AppDatabase,
          $AssignationsEcoleTable,
          AssignationEcole
        >,
      ),
      AssignationEcole,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$RolesTableTableManager get roles =>
      $$RolesTableTableManager(_db, _db.roles);
  $$PermissionsTableTableManager get permissions =>
      $$PermissionsTableTableManager(_db, _db.permissions);
  $$RolePermissionsTableTableManager get rolePermissions =>
      $$RolePermissionsTableTableManager(_db, _db.rolePermissions);
  $$EcolesTableTableManager get ecoles =>
      $$EcolesTableTableManager(_db, _db.ecoles);
  $$NiveauxTableTableManager get niveaux =>
      $$NiveauxTableTableManager(_db, _db.niveaux);
  $$UtilisateursTableTableManager get utilisateurs =>
      $$UtilisateursTableTableManager(_db, _db.utilisateurs);
  $$AppartenancesTableTableManager get appartenances =>
      $$AppartenancesTableTableManager(_db, _db.appartenances);
  $$MatieresTableTableManager get matieres =>
      $$MatieresTableTableManager(_db, _db.matieres);
  $$LeconsTableTableManager get lecons =>
      $$LeconsTableTableManager(_db, _db.lecons);
  $$CurriculumsTableTableManager get curriculums =>
      $$CurriculumsTableTableManager(_db, _db.curriculums);
  $$PagesTableTableManager get pages =>
      $$PagesTableTableManager(_db, _db.pages);
  $$FlashcardsTableTableManager get flashcards =>
      $$FlashcardsTableTableManager(_db, _db.flashcards);
  $$AssignationsEcoleTableTableManager get assignationsEcole =>
      $$AssignationsEcoleTableTableManager(_db, _db.assignationsEcole);
}
