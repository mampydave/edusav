// lib/common/providers/current_user_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:edusav/common/services/database_services.dart';
import 'package:edusav/common/services/databases/database.dart';
import 'package:edusav/features/auth/presentation/auth_controller.dart';
import 'package:edusav/features/auth/domain/auth_user.dart';

final currentUserProvider = Provider<AuthUser?>((ref) {
  final authAsync = ref.watch(authControllerProvider);

  return authAsync.when(
    data: (authState) {
      if (authState is AuthAuthenticated) {
        print(
          "✅ currentUserProvider → Utilisateur connecté : ${authState.user.name}",
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

final isCurrentUserAdminProvider = FutureProvider<bool>((ref) async {
  final user = ref.watch(currentUserProvider);
  if (user == null || user.roleId == null) return false;

  final db = ref.watch(databaseServiceProvider);
  final adminRoleId = await db.roles.getRoleIdByName('ADMIN');
  return user.roleId == adminRoleId;
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
        ? "✅ Appartenance active trouvée pour ${user.name}"
        : "⚠️ Aucune appartenance active",
  );

  return active;
});

final currentUserWithContextProvider =
    FutureProvider<(AuthUser?, Appartenance?, Ecole?, Niveau?)>((ref) async {
      final user = ref.watch(currentUserProvider);
      if (user == null) {
        print("⚠️ currentUserWithContextProvider → Aucun utilisateur");
        return (null, null, null, null);
      }

      final db = ref.watch(databaseServiceProvider);
      final appartenance = await ref.watch(currentAppartenanceProvider.future);

      if (appartenance == null) {
        print("⚠️ Pas d'appartenance active pour ${user.name}");
        return (user, null, null, null);
      }

      final ecole = await db.ecoles.getById(appartenance.ecoleId);
      final niveau = appartenance.niveauId != null
          ? await db.niveaux.getById(appartenance.niveauId!)
          : null;

      print("✅ Contexte complet chargé pour ${user.name}");
      return (user, appartenance, ecole, niveau);
    });
