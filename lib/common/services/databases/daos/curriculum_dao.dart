import 'package:drift/drift.dart';
import 'package:edusav/common/services/databases/database.dart';
import 'package:edusav/common/services/databases/tables.dart';
part 'curriculum_dao.g.dart';

@DriftAccessor(tables: [Curriculums, Ecoles, Niveaux, Matieres])
class CurriculumDao extends DatabaseAccessor<AppDatabase>
    with _$CurriculumDaoMixin {
  CurriculumDao(super.db);

  Future<int> insert(CurriculumsCompanion data) =>
      into(curriculums).insert(data);

  Future<List<Curriculum>> getAll() => select(curriculums).get();

  Future<Curriculum?> find(String ecoleId, String niveauId, String matiereId) =>
      (select(curriculums)..where(
            (c) =>
                c.ecoleId.equals(ecoleId) &
                c.niveauId.equals(niveauId) &
                c.matiereId.equals(matiereId),
          ))
          .getSingleOrNull();

  // 🔥 JOIN
  Future<List<(Curriculum, Ecole, Niveau, Matiere)>> getFull() async {
    final query = select(curriculums).join([
      innerJoin(ecoles, ecoles.id.equalsExp(curriculums.ecoleId)),
      innerJoin(niveaux, niveaux.id.equalsExp(curriculums.niveauId)),
      innerJoin(matieres, matieres.id.equalsExp(curriculums.matiereId)),
    ]);

    final rows = await query.get();

    return rows.map((row) {
      return (
        row.readTable(curriculums),
        row.readTable(ecoles),
        row.readTable(niveaux),
        row.readTable(matieres),
      );
    }).toList();
  }

  Future<List<Curriculum>> getByEcoleAndNiveau(
    String ecoleId,
    String niveauId,
  ) {
    return (select(curriculums)..where(
          (c) => c.ecoleId.equals(ecoleId) & c.niveauId.equals(niveauId),
        ))
        .get();
  }
}
