import 'package:edusav/common/services/database_services.dart';
import 'package:edusav/common/services/databases/database.dart';
import 'package:edusav/core/di/current_user_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userCurrentSubjectsProvider = FutureProvider<List<Matiere>>((ref) async {
  print("🚀 userCurrentSubjectsProvider START");

  final user = ref.watch(currentUserProvider);
  if (user == null) {
    print("❌ ERREUR: Aucun utilisateur connecté");
    return [];
  }

  print("👤 Utilisateur connecté: ${user.nom} (ID: ${user.id})");

  final db = ref.watch(databaseServiceProvider);

  // Force refresh de l'appartenance
  final appartenance = await ref.watch(currentAppartenanceProvider.future);

  if (appartenance == null) {
    print("❌ ERREUR: Aucune appartenance active trouvée");
    return [];
  }

  print(
    "✅ Appartenance trouvée → Ecole: ${appartenance.ecoleId} | Niveau: ${appartenance.niveauId ?? 'NULL'}",
  );

  // Test curriculum
  if (appartenance.niveauId != null) {
    print(
      "🔎 Appel à getByEcoleAndNiveau avec ecole=${appartenance.ecoleId}, niveau=${appartenance.niveauId}",
    );

    final curriculumList = await db.curriculums.getByEcoleAndNiveau(
      appartenance.ecoleId,
      appartenance.niveauId!,
    );

    print("📊 Nombre de curriculum retournés : ${curriculumList.length}");

    if (curriculumList.isNotEmpty) {
      print("✅ Curriculum trouvés, récupération des matières...");
      final matiereIds = curriculumList.map((c) => c.matiereId).toList();
      final matieres = await db.matieres.getMatieresByIds(matiereIds);

      print("🎉 SUCCÈS: ${matieres.length} matières trouvées");
      for (var m in matieres) {
        print("   - ${m.nom}");
      }
      return matieres;
    } else {
      print("❌ Aucun curriculum trouvé pour cette école + niveau");
    }
  } else {
    print("⚠️ Pas de niveauId dans l'appartenance");
  }

  // Fallback final très visible
  // print("🔄 Fallback : récupération de TOUTES les matières de la base");
  // final allMatieres = await db.matieres.getAll();
  // print("📦 ${allMatieres.length} matières totales dans la base");

  // if (allMatieres.isNotEmpty) {
  //   print("✅ Retour des matières en fallback");
  //   for (var m in allMatieres.take(5)) {
  //     print("   - ${m.nom}");
  //   }
  // }

  return [];
});
