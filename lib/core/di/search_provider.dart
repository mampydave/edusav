// lib/core/di/search_providers.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:edusav/common/services/database_services.dart';
import 'package:edusav/core/di/current_user_provider.dart';
import 'package:edusav/common/services/databases/database.dart';

// ================================================================
// 1. Niveaux de l'utilisateur avec contexte École + Année scolaire
// ================================================================

final userNiveauxWithContextProvider = FutureProvider<List<UserNiveauContext>>((
  ref,
) async {
  final db = ref.watch(databaseServiceProvider);
  final user = ref.watch(currentUserProvider);

  if (user == null) return [];

  final appartenances = await db.appartenances.getByUser(user.id);
  final List<UserNiveauContext> result = [];

  for (var app in appartenances) {
    final ecole = await db.ecoles.getById(app.ecoleId);
    final niveau = app.niveauId != null
        ? await db.niveaux.getById(app.niveauId!)
        : null;

    if (niveau != null && ecole != null) {
      result.add(
        UserNiveauContext(
          niveauId: niveau.id,
          niveauName: niveau.nomNiveau,
          ecoleId: ecole.id,
          ecoleName: ecole.nom,
          anneeSco: app.anneeSco,
        ),
      );
    }
  }

  result.sort((a, b) => b.anneeSco.compareTo(a.anneeSco));
  return result;
});

class UserNiveauContext {
  final String niveauId;
  final String niveauName;
  final String ecoleId;
  final String ecoleName;
  final String anneeSco;

  UserNiveauContext({
    required this.niveauId,
    required this.niveauName,
    required this.ecoleId,
    required this.ecoleName,
    required this.anneeSco,
  });
}

// ================================================================
// 2. Paramètre typé pour matieresByNiveauAndEcoleProvider
//    ✅ == et hashCode sont OBLIGATOIRES pour que Riverpod family
//    détecte correctement les changements sans boucle infinie
// ================================================================

class NiveauEcoleParams {
  final String niveauId;
  final String ecoleId;

  const NiveauEcoleParams({required this.niveauId, required this.ecoleId});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NiveauEcoleParams &&
          runtimeType == other.runtimeType &&
          niveauId == other.niveauId &&
          ecoleId == other.ecoleId;

  @override
  int get hashCode => niveauId.hashCode ^ ecoleId.hashCode;
}

// ================================================================
// 3. Matières d'un Niveau + École spécifique (via curriculum)
// ================================================================

final matieresByNiveauAndEcoleProvider =
    FutureProvider.family<List<Matiere>, NiveauEcoleParams>((
      ref,
      params,
    ) async {
      final db = ref.watch(databaseServiceProvider);

      final curriculumList = await db.curriculums.getByEcoleAndNiveau(
        params.ecoleId,
        params.niveauId,
      );

      if (curriculumList.isEmpty) return [];

      final matiereIds = curriculumList.map((c) => c.matiereId).toList();
      return await db.matieres.getMatieresByIds(matiereIds);
    });

// ================================================================
// 4. Provider de recherche
// ================================================================

final searchLeconsProvider = FutureProvider.family<List<Lecon>, SearchParams>((
  ref,
  params,
) async {
  final db = ref.watch(databaseServiceProvider);

  return await db.lecons.searchLecons(
    query: params.query,
    niveauId: params.niveauId,
    ecoleId: params.ecoleId,
    matiereId: params.matiereId,
  );
});

class SearchParams {
  final String query;
  final String? niveauId;
  final String? ecoleId;
  final String? matiereId;

  const SearchParams({
    required this.query,
    this.niveauId,
    this.ecoleId,
    this.matiereId,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SearchParams &&
          runtimeType == other.runtimeType &&
          query == other.query &&
          niveauId == other.niveauId &&
          ecoleId == other.ecoleId &&
          matiereId == other.matiereId;

  @override
  int get hashCode =>
      query.hashCode ^
      niveauId.hashCode ^
      ecoleId.hashCode ^
      matiereId.hashCode;
}
