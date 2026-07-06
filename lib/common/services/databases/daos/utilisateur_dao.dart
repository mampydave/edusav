import 'package:drift/drift.dart';
import 'package:edusav/common/services/databases/database.dart';
import 'package:edusav/common/services/databases/tables.dart';

part 'utilisateur_dao.g.dart';

@DriftAccessor(tables: [Utilisateurs, Roles])
class UtilisateurDao extends DatabaseAccessor<AppDatabase>
    with _$UtilisateurDaoMixin {
  UtilisateurDao(super.db);

  Future<int> insert(UtilisateursCompanion user) =>
      into(utilisateurs).insert(user);

  Future<Utilisateur?> getById(String id) =>
      (select(utilisateurs)..where((u) => u.id.equals(id))).getSingleOrNull();

  Future<Utilisateur?> getByEmail(String email) => (select(
    utilisateurs,
  )..where((u) => u.email.equals(email))).getSingleOrNull();

  Future<List<Utilisateur>> getAll() =>
      (select(utilisateurs)..where((u) => u.dateDel.isNull())).get();

  Stream<List<Utilisateur>> watchAll() =>
      (select(utilisateurs)..where((u) => u.dateDel.isNull())).watch();

  Future<void> updateUser(UtilisateursCompanion user) =>
      update(utilisateurs).replace(user);

  Future<int> softDelete(String id) =>
      (update(utilisateurs)..where((u) => u.id.equals(id))).write(
        UtilisateursCompanion(
          dateDel: Value(DateTime.now().millisecondsSinceEpoch),
        ),
      );

  // get by role name
  Future<List<Utilisateur>> getByRoleName(String roleName) async {
    final role = await (select(
      roles,
    )..where((r) => r.nomRole.equals(roleName))).getSingleOrNull();
    if (role == null) {
      return [];
    }
    return (select(utilisateurs)..where((u) => u.roleId.equals(role.id))).get();
  }

  // 🔥 JOIN Role
  Future<List<(Utilisateur, Role?)>> getWithRole() async {
    final query = select(
      utilisateurs,
    ).join([leftOuterJoin(roles, roles.id.equalsExp(utilisateurs.roleId))]);

    final rows = await query.get();

    return rows.map((row) {
      return (row.readTable(utilisateurs), row.readTableOrNull(roles));
    }).toList();
  }
}
