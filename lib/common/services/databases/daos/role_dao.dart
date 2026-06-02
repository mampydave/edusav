import 'package:drift/drift.dart';
import 'package:edusav/common/services/databases/database.dart';
import 'package:edusav/common/services/databases/tables.dart';
part 'role_dao.g.dart';

@DriftAccessor(tables: [Roles])
class RoleDao extends DatabaseAccessor<AppDatabase> with _$RoleDaoMixin {
  RoleDao(super.db);

  Future<List<Role>> getAll() => select(roles).get();
}
