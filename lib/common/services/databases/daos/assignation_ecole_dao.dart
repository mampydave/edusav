import 'package:drift/drift.dart';
import 'package:edusav/common/services/databases/database.dart';
import 'package:edusav/common/services/databases/tables.dart';

part 'assignation_ecole_dao.g.dart';

@DriftAccessor(tables: [AssignationsEcole, Roles, Ecoles])
class AssignationEcoleDao extends DatabaseAccessor<AppDatabase>
    with _$AssignationEcoleDaoMixin {
  AssignationEcoleDao(super.db);

  static const validStatuts = {'PENDING', 'APPROVED', 'REJECTED'};

  Future<void> insertAssignation(AssignationsEcoleCompanion companion) async {
    final statut = companion.statut.value ?? 'PENDING';

    if (!validStatuts.contains(statut)) {
      throw Exception(
        'Statut invalide : $statut. Valeurs autorisées : $validStatuts',
      );
    }

    await into(assignationsEcole).insert(companion);
  }

  Future<List<AssignationEcole>> getByUser(String userId) => (select(
    assignationsEcole,
  )..where((a) => a.userId.equals(userId) & a.estActif.equals(true))).get();

  Future<List<AssignationEcole>> getByEcole(String ecoleId) => (select(
    assignationsEcole,
  )..where((a) => a.ecoleId.equals(ecoleId) & a.estActif.equals(true))).get();

  Future<List<AssignationWithDetails>> getWithDetailsByUser(
    String userId,
  ) async {
    final query =
        select(assignationsEcole).join([
          innerJoin(roles, roles.id.equalsExp(assignationsEcole.roleId)),
          innerJoin(ecoles, ecoles.id.equalsExp(assignationsEcole.ecoleId)),
        ])..where(
          assignationsEcole.userId.equals(userId) &
              assignationsEcole.estActif.equals(true),
        );

    final rows = await query.get();

    return rows.map((row) {
      return AssignationWithDetails(
        assignation: row.readTable(assignationsEcole),
        role: row.readTable(roles),
        ecole: row.readTable(ecoles),
      );
    }).toList();
  }

  Future<void> updateAssignation(AssignationsEcoleCompanion companion) =>
      update(assignationsEcole).replace(companion);

  Future<void> deactivate(String id) =>
      (update(assignationsEcole)..where((a) => a.id.equals(id))).write(
        const AssignationsEcoleCompanion(estActif: Value(false)),
      );

  Future<void> deleteAssignation(String id) =>
      (delete(assignationsEcole)..where((a) => a.id.equals(id))).go();

  // Méthodes de validation
  Future<void> approve(String id) async {
    await (update(assignationsEcole)..where((a) => a.id.equals(id))).write(
      const AssignationsEcoleCompanion(
        statut: Value('APPROVED'),
        estActif: Value(true),
      ),
    );
  }

  Future<void> reject(String id) async {
    await (update(assignationsEcole)..where((a) => a.id.equals(id))).write(
      const AssignationsEcoleCompanion(
        statut: Value('REJECTED'),
        estActif: Value(false),
      ),
    );
  }

  // // Récupérer les demandes en attente
  // Future<List<AssignationWithDetails>> getPendingRequests() async {
  //   final query = select(assignationsEcole).join([
  //     innerJoin(roles, roles.id.equalsExp(assignationsEcole.roleId)),
  //     innerJoin(ecoles, ecoles.id.equalsExp(assignationsEcole.ecoleId)),
  //     innerJoin(
  //       utilisateurs,
  //       utilisateurs.id.equalsExp(assignationsEcole.userId),
  //     ),
  //   ])..where(assignationsEcole.statut.equals('PENDING'));
  // }
}

class AssignationWithDetails {
  final AssignationEcole assignation;
  final Role role;
  final Ecole ecole;

  AssignationWithDetails({
    required this.assignation,
    required this.role,
    required this.ecole,
  });
}
