import 'package:drift/drift.dart';
import 'package:edusav/common/services/databases/database.dart';
import 'package:edusav/common/services/databases/tables.dart';
part 'role_dao.g.dart';

@DriftAccessor(tables: [Roles])
class RoleDao extends DatabaseAccessor<AppDatabase> with _$RoleDaoMixin {
  RoleDao(super.db);

  Future<int> insert(RolesCompanion companion) => into(roles).insert(companion);

  Future<List<Role>> getAll() => select(roles).get();

  // liste role sans admin
  Future<List<Role>> getAllWithoutAdmin() =>
      (select(roles)..where((r) => r.nomRole.isNotIn(['ADMIN']))).get();
  // get role id by name
  Future<String?> getRoleIdByName(String name) async {
    final role = await getByName(name);
    return role?.id;
  }

  Future<Role?> getByName(String name) =>
      (select(roles)..where((r) => r.nomRole.equals(name))).getSingleOrNull();
}
