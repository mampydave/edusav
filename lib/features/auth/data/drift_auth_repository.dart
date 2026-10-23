import 'package:drift/drift.dart';
import 'package:edusav/common/services/databases/database.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:uuid/uuid.dart';

import '../domain/auth_repository.dart';
import '../domain/auth_user.dart';

const _currentUserKey = 'edusav_current_user_id';
const _authTokenKey = 'edusav_auth_token';

class DriftAuthRepository implements AuthRepository {
  final AppDatabase _database;
  final FlutterSecureStorage _storage;

  const DriftAuthRepository(this._database, this._storage);

  @override
  Future<AuthAccount?> findAccountByEmail(String email) async {
    final user = await _database.utilisateurDao.getByEmail(email);
    if (user == null) return null;
    return AuthAccount(user: await _toAuthUser(user), passwordHash: user.mdp);
  }

  @override
  Future<AuthUser?> findActiveUserById(String userId) async {
    final user = await _database.utilisateurDao.getById(userId);
    if (user == null || user.dateDel != null) return null;
    return _toAuthUser(user);
  }

  @override
  Future<String?> findRoleIdByName(String roleName) =>
      _database.roleDao.getRoleIdByName(roleName);

  @override
  Future<bool> hasActiveAssignment(String userId) =>
      _database.assignationEcoleDao.isActiveByUserId(userId);

  @override
  Future<String?> readSessionUserId() => _storage.read(key: _currentUserKey);

  @override
  Future<void> saveSession(String userId) async {
    await _storage.write(key: _currentUserKey, value: userId);
    await _storage.write(key: _authTokenKey, value: 'offline_session_$userId');
  }

  @override
  Future<AuthUser> createStudent({
    required String name,
    required String email,
    required String passwordHash,
    required String roleId,
    String? schoolId,
    String? levelId,
    String? schoolYear,
  }) async {
    final userId = const Uuid().v4();
    final now = DateTime.now().millisecondsSinceEpoch;
    await _database.transaction(() async {
      await _database.utilisateurDao.insert(
        UtilisateursCompanion.insert(
          id: userId,
          nom: name.trim(),
          email: email,
          mdp: passwordHash,
          roleId: Value(roleId),
          dateCrea: now,
        ),
      );

      if (schoolId != null && schoolYear != null && schoolYear.isNotEmpty) {
        await _database.appartenanceDao.insert(
          AppartenancesCompanion.insert(
            id: const Uuid().v4(),
            userId: userId,
            ecoleId: schoolId,
            niveauId: Value(levelId),
            anneeSco: schoolYear.trim(),
            estActif: const Value(true),
            dateMiseAJour: now,
          ),
        );
      }
    });

    final role = await _database.roleDao.getById(roleId);
    return AuthUser(
      id: userId,
      name: name,
      email: email,
      roleId: roleId,
      roleName: role?.nomRole,
    );
  }

  @override
  Future<void> createStaff({
    required String name,
    required String email,
    required String passwordHash,
    required String roleId,
    required List<String> schoolIds,
  }) async {
    final userId = const Uuid().v4();
    await _database.transaction(() async {
      await _database.utilisateurDao.insert(
        UtilisateursCompanion.insert(
          id: userId,
          nom: name.trim(),
          email: email,
          mdp: passwordHash,
          roleId: Value(roleId),
          dateCrea: DateTime.now().millisecondsSinceEpoch,
        ),
      );

      for (final schoolId in schoolIds) {
        await _database.assignationEcoleDao.insertAssignation(
          AssignationsEcoleCompanion.insert(
            id: const Uuid().v4(),
            userId: userId,
            ecoleId: schoolId,
            roleId: roleId,
            dateDebut: DateTime.now(),
            estActif: const Value(false),
            statut: const Value('PENDING'),
          ),
        );
      }
    });
  }

  @override
  Future<void> clearSession() async {
    await _storage.delete(key: _currentUserKey);
    await _storage.delete(key: _authTokenKey);
  }

  Future<AuthUser> _toAuthUser(Utilisateur user) async {
    final role = user.roleId == null
        ? null
        : await _database.roleDao.getById(user.roleId!);
    return AuthUser(
      id: user.id,
      name: user.nom,
      email: user.email,
      roleId: user.roleId,
      roleName: role?.nomRole,
    );
  }
}
