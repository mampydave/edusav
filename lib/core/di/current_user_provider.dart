// lib/common/providers/current_user_provider.dart
import 'package:edusav/core/di/auth_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:edusav/common/services/database_services.dart';
import 'package:edusav/common/services/databases/database.dart';

final currentUserProvider = Provider<Utilisateur?>((ref) {
  final authAsync = ref.watch(authNotifierProvider);

  return authAsync.when(
    data: (authState) {
      if (authState is AuthAuthenticated) {
        print(
          "✅ currentUserProvider → Utilisateur connecté : ${authState.user.nom}",
        );
        return authState.user;
      } else {
        print("⚠️ currentUserProvider → Utilisateur non authentifié");
        return null;
      }
    },
    loading: () {
      print("⏳ currentUserProvider → Chargement de l'auth...");
      return null;
    },
    error: (error, stackTrace) {
      print("❌ currentUserProvider → Erreur auth : $error");
      return null;
    },
  );
});

final currentAppartenanceProvider = FutureProvider<Appartenance?>((ref) async {
  final user = ref.watch(currentUserProvider);
  if (user == null) {
    print("⚠️ currentAppartenanceProvider → Aucun utilisateur");
    return null;
  }

  final db = ref.watch(databaseServiceProvider);
  final appartenances = await db.appartenances.getByUser(user.id);

  final active = appartenances.isNotEmpty ? appartenances.first : null;
  print(
    active != null
        ? "✅ Appartenance active trouvée pour ${user.nom}"
        : "⚠️ Aucune appartenance active",
  );

  return active;
});

final currentUserWithContextProvider =
    FutureProvider<(Utilisateur?, Appartenance?, Ecole?, Niveau?)>((ref) async {
      final user = ref.watch(currentUserProvider);
      if (user == null) {
        print("⚠️ currentUserWithContextProvider → Aucun utilisateur");
        return (null, null, null, null);
      }

      final db = ref.watch(databaseServiceProvider);
      final appartenance = await ref.watch(currentAppartenanceProvider.future);

      if (appartenance == null) {
        print("⚠️ Pas d'appartenance active pour ${user.nom}");
        return (user, null, null, null);
      }

      final ecole = await db.ecoles.getById(appartenance.ecoleId);
      final niveau = appartenance.niveauId != null
          ? await db.niveaux.getById(appartenance.niveauId!)
          : null;

      print("✅ Contexte complet chargé pour ${user.nom}");
      return (user, appartenance, ecole, niveau);
    });
