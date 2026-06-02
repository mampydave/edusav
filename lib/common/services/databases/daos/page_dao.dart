import 'package:drift/drift.dart';
import 'package:edusav/common/services/databases/database.dart';
import 'package:edusav/common/services/databases/tables.dart';

part 'page_dao.g.dart';

@DriftAccessor(tables: [Pages, Lecons])
class PageDao extends DatabaseAccessor<AppDatabase> with _$PageDaoMixin {
  PageDao(super.db);

  // =========================
  // INSERT
  // =========================

  Future<int> insertPage(PagesCompanion page) {
    return into(pages).insert(page);
  }

  Future<void> insertPages(List<PagesCompanion> pagesList) async {
    await batch((batch) {
      batch.insertAll(pages, pagesList);
    });
  }

  // =========================
  // READ
  // =========================

  /// Toutes les pages d'une leçon (triées)
  Future<List<Page>> getPagesByLecon(String leconId) {
    return (select(pages)
          ..where((p) => p.leconId.equals(leconId))
          ..orderBy([(p) => OrderingTerm(expression: p.ordre)]))
        .get();
  }

  /// Stream (live update)
  Stream<List<Page>> watchPagesByLecon(String leconId) {
    return (select(pages)
          ..where((p) => p.leconId.equals(leconId))
          ..orderBy([(p) => OrderingTerm(expression: p.ordre)]))
        .watch();
  }

  /// Récupérer une page spécifique
  Future<Page?> getPageById(String id) {
    return (select(pages)..where((p) => p.id.equals(id))).getSingleOrNull();
  }

  // =========================
  // UPDATE
  // =========================

  /// Update OCR
  Future<int> updateOcrText(String id, String? ocr) {
    return (update(pages)..where((p) => p.id.equals(id))).write(
      PagesCompanion(ocrTexte: Value(ocr)),
    );
  }

  /// Update contenu stylé
  Future<int> updateContenuStyl(String id, String? contenuStyl) {
    return (update(pages)..where((p) => p.id.equals(id))).write(
      PagesCompanion(contenuStyl: Value(contenuStyl)),
    );
  }

  /// Update ordre (important pour réorganisation)
  Future<int> updateOrdre(String id, int ordre) {
    return (update(pages)..where((p) => p.id.equals(id))).write(
      PagesCompanion(ordre: Value(ordre)),
    );
  }

  // =========================
  // DELETE
  // =========================

  Future<int> deletePage(String id) {
    return (delete(pages)..where((p) => p.id.equals(id))).go();
  }

  Future<int> deletePagesByLecon(String leconId) {
    return (delete(pages)..where((p) => p.leconId.equals(leconId))).go();
  }

  /// Reconstituer tout le texte OCR d'une leçon
  Future<String> getFullOcrByLecon(String leconId) async {
    final pagesList = await getPagesByLecon(leconId);

    return pagesList.map((p) => p.ocrTexte ?? '').join('\n\n');
  }

  /// Nombre de pages d'une leçon
  Future<int> countPages(String leconId) async {
    final query = selectOnly(pages)
      ..addColumns([pages.id.count()])
      ..where(pages.leconId.equals(leconId));

    final result = await query.getSingle();
    return result.read(pages.id.count()) ?? 0;
  }

  // Get all pages for a given subject context (user + matiere + ecole + niveau)
  Future<List<Page>> getAllPagesForSubjectContext({
    required String userId,
    required String matiereId,
    required String ecoleId,
    required String niveauId,
  }) {
    final query = select(
      pages,
    ).join([innerJoin(lecons, lecons.id.equalsExp(pages.leconId))]);

    query.where(
      lecons.auteurId.equals(userId) &
          lecons.matiereId.equals(matiereId) &
          lecons.ecoleId.equals(ecoleId) &
          lecons.niveauId.equals(niveauId) &
          lecons.dateDel.isNull(),
    );

    // Tri par date de leçon puis par numéro de page
    query.orderBy([
      OrderingTerm(expression: lecons.dateUpd, mode: OrderingMode.asc),
      OrderingTerm(expression: pages.ordre, mode: OrderingMode.asc),
    ]);

    return query.map((row) => row.readTable(pages)).get();
  }
}
