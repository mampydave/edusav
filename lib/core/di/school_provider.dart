import 'package:edusav/common/services/database_services.dart';
import 'package:edusav/common/services/databases/database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Provider pour toutes les écoles
final ecolesProvider = FutureProvider<List<Ecole>>((ref) async {
  final dbService = ref.watch(databaseServiceProvider);
  return await dbService.ecoles.getAll();
});

// Provider pour tous les niveaux (utile si on veut tout charger d'un coup)
final niveauxProvider = FutureProvider<List<Niveau>>((ref) async {
  final dbService = ref.watch(databaseServiceProvider);
  return await dbService.niveaux.getAll();
});

// Provider pour les niveaux d'une école spécifique
final niveauxByEcoleProvider = FutureProvider.family<List<Niveau>, String?>((
  ref,
  ecoleId,
) async {
  if (ecoleId == null) return [];

  final dbService = ref.watch(databaseServiceProvider);
  return await dbService.niveaux.getByEcole(ecoleId);
});
