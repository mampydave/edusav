import 'package:drift/drift.dart';
import 'package:edusav/common/services/databases/database.dart';
import 'package:edusav/common/services/databases/tables.dart';
part 'matiere_dao.g.dart';

@DriftAccessor(tables: [Matieres])
class MatiereDao extends DatabaseAccessor<AppDatabase> with _$MatiereDaoMixin {
  MatiereDao(super.db);

  Future<int> insert(MatieresCompanion data) => into(matieres).insert(data);

  Future<List<Matiere>> getAll() => select(matieres).get();

  Future<Matiere?> getById(String id) =>
      (select(matieres)..where((m) => m.id.equals(id))).getSingleOrNull();

  Future<void> updateData(MatieresCompanion data) =>
      update(matieres).replace(data);

  Future<List<Matiere>> getMatieresByIds(List<String> ids) {
    if (ids.isEmpty) return Future.value([]);

    return (select(matieres)..where((m) => m.id.isIn(ids))).get();
  }
}
