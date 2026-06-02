// lib/core/di/lecon_provider.dart
import 'package:edusav/common/services/database_services.dart';
import 'package:edusav/common/services/databases/database.dart';
import 'package:edusav/core/di/current_user_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Providers existants (inchangés)
// ─────────────────────────────────────────────────────────────────────────────

final userLeconsProvider = FutureProvider<List<Lecon>>((ref) async {
  final user = ref.watch(currentUserProvider);
  if (user == null) return [];
  final db = ref.watch(databaseServiceProvider);
  return await db.lecons.getLeconsByAuteur(user.id);
});

final userLeconsStreamProvider = StreamProvider<List<Lecon>>((ref) {
  final user = ref.watch(currentUserProvider);
  if (user == null) return Stream.value([]);
  final db = ref.watch(databaseServiceProvider);
  return db.lecons.watchLeconsByAuteur(user.id);
});

final userMatieresWithCountProvider = FutureProvider<Map<String, int>>((
  ref,
) async {
  final lecons = await ref.watch(userLeconsProvider.future);
  final map = <String, int>{};
  for (var lecon in lecons) {
    final key = lecon.matiereId ?? 'autre';
    map[key] = (map[key] ?? 0) + 1;
  }
  return map;
});

// ─────────────────────────────────────────────────────────────────────────────
// LessonFilter
// ─────────────────────────────────────────────────────────────────────────────

class LessonFilter {
  final String matiereId;
  final String ecoleId;
  final String niveauId;

  const LessonFilter({
    required this.matiereId,
    required this.ecoleId,
    required this.niveauId,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LessonFilter &&
          matiereId == other.matiereId &&
          ecoleId == other.ecoleId &&
          niveauId == other.niveauId;

  @override
  int get hashCode => matiereId.hashCode ^ ecoleId.hashCode ^ niveauId.hashCode;
}

// ─────────────────────────────────────────────────────────────────────────────
// Notifier — gère la liste de pages avec reorder + delete persistés en base
// ─────────────────────────────────────────────────────────────────────────────

class SubjectPagesNotifier
    extends FamilyAsyncNotifier<List<Page>, LessonFilter> {
  @override
  Future<List<Page>> build(LessonFilter arg) async {
    final user = ref.watch(currentUserProvider);
    final db = ref.watch(databaseServiceProvider);
    if (user == null) return [];

    return await db.pages.getAllPagesForSubjectContext(
      userId: user.id,
      matiereId: arg.matiereId,
      ecoleId: arg.ecoleId,
      niveauId: arg.niveauId,
    );
  }

  /// Réorganise les pages localement ET persiste les nouveaux ordres en base.
  /// [oldIndex] et [newIndex] viennent directement de ReorderableGridView/List.
  Future<void> reorderPages(int oldIndex, int newIndex) async {
    // Lire la liste courante (ne rien faire si pas encore chargée)
    final current = state.valueOrNull;
    if (current == null || current.isEmpty) return;

    // Appliquer le même décalage que ReorderableListView
    final adjusted = newIndex > oldIndex ? newIndex - 1 : newIndex;

    // Construire la nouvelle liste en mémoire
    final reordered = List<Page>.from(current);
    final item = reordered.removeAt(oldIndex);
    reordered.insert(adjusted, item);

    // Mise à jour optimiste de l'UI
    state = AsyncData(reordered);

    // Persister chaque page avec son nouvel index comme ordre
    final db = ref.read(databaseServiceProvider);
    for (int i = 0; i < reordered.length; i++) {
      await db.pages.updateOrdre(reordered[i].id, i);
    }
  }

  /// Supprime une page de la liste et de la base de données.
  Future<void> deletePage(String pageId) async {
    final current = state.valueOrNull;
    if (current == null) return;

    // Mise à jour optimiste
    final updated = current.where((p) => p.id != pageId).toList();
    state = AsyncData(updated);

    // Suppression en base
    final db = ref.read(databaseServiceProvider);
    await db.pages.deletePage(pageId);

    // Recalculer les ordres des pages restantes pour garder une séquence propre
    for (int i = 0; i < updated.length; i++) {
      await db.pages.updateOrdre(updated[i].id, i);
    }
  }
}

// Provider principal — remplace l'ancien FutureProvider.family
final allSubjectPagesProvider =
    AsyncNotifierProvider.family<
      SubjectPagesNotifier,
      List<Page>,
      LessonFilter
    >(SubjectPagesNotifier.new);
