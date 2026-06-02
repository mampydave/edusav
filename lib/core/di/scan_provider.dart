import 'package:edusav/common/models/subject_filter.dart';
import 'package:edusav/common/services/database_services.dart';
import 'package:edusav/common/services/databases/database.dart';
import 'package:edusav/core/di/current_user_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Provider : Niveaux accessibles à l'utilisateur connecté (via appartenance)
final userLevelsProvider = FutureProvider<List<(Niveau, Ecole)>>((ref) async {
  final user = ref.watch(currentUserProvider);
  if (user == null) return [];

  final db = ref.watch(databaseServiceProvider);

  // Récupérer toutes les appartenances actives de l'utilisateur
  final appartenances = await db.appartenances.getByUser(user.id);

  List<(Niveau, Ecole)> result = [];

  for (var app in appartenances) {
    if (app.niveauId == null) continue;

    final niveau = await db.niveaux.getById(app.niveauId!);
    final ecole = await db.ecoles.getById(app.ecoleId);

    if (niveau != null && ecole != null) {
      result.add((niveau, ecole));
    }
  }

  return result;
});

final subjectsByLevelProvider =
    FutureProvider.family<List<Matiere>, SubjectFilter>((ref, filter) async {
      final db = ref.watch(databaseServiceProvider);

      final curriculumList = await db.curriculums.getByEcoleAndNiveau(
        filter.ecoleId,
        filter.niveauId,
      );

      if (curriculumList.isEmpty) {
        // Fallback : toutes les matières
        return await db.matieres.getAll();
      }

      final matiereIds = curriculumList.map((c) => c.matiereId).toList();
      return await db.matieres.getMatieresByIds(matiereIds);
    });
