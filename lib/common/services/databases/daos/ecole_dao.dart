import 'package:drift/drift.dart';
import 'package:edusav/common/services/databases/database.dart';
import 'package:edusav/common/services/databases/tables.dart';

part 'ecole_dao.g.dart';

@DriftAccessor(tables: [Ecoles, Niveaux])
class EcoleDao extends DatabaseAccessor<AppDatabase> with _$EcoleDaoMixin {
  EcoleDao(super.db);

  /// 🔹 INSERT
  Future<int> insert(EcolesCompanion data) => into(ecoles).insert(data);

  /// 🔹 GET BY ID
  Future<Ecole?> getById(String id) =>
      (select(ecoles)..where((e) => e.id.equals(id))).getSingleOrNull();

  /// 🔹 GET ALL
  Future<List<Ecole>> getAll() => select(ecoles).get();

  /// 🔹 WATCH (UI temps réel)
  Stream<List<Ecole>> watchAll() => select(ecoles).watch();

  /// 🔹 UPDATE
  Future<bool> updateData(EcolesCompanion data) => update(ecoles).replace(data);

  /// 🔹 DELETE (hard delete ici)
  Future<int> deleteById(String id) =>
      (delete(ecoles)..where((e) => e.id.equals(id))).go();

  /// 🔥 GET école + niveaux
  Future<List<(Ecole, List<Niveau>)>> getEcolesWithNiveaux() async {
    final allEcoles = await select(ecoles).get();

    final result = <(Ecole, List<Niveau>)>[];

    for (final ecole in allEcoles) {
      final niveauxList = await (select(
        niveaux,
      )..where((n) => n.ecoleId.equals(ecole.id))).get();

      result.add((ecole, niveauxList));
    }

    return result;
  }
}
