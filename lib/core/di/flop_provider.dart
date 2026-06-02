import 'package:edusav/common/models/flash_card_with_matiere.dart';
import 'package:edusav/common/services/database_services.dart';
import 'package:edusav/common/services/databases/daos/flashcard_dao.dart';
import 'package:edusav/core/di/current_user_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:edusav/common/services/databases/database.dart';

final flashcardDaoProvider = Provider<FlashcardDao>((ref) {
  final db = ref.watch(databaseServiceProvider);
  return db.flashcards;
});

// Flashcards de l'utilisateur connecté (toutes actives)
final userFlashcardsProvider = FutureProvider<List<Flashcard>>((ref) async {
  final user = ref.watch(currentUserProvider);
  if (user == null) return [];

  final dao = ref.watch(flashcardDaoProvider);
  return dao.getByUser(user.id);
});

// Flashcards dues pour révision aujourd'hui (recommandé pour l'écran Flop)
// Dans flop_providers.dart

final dueFlashcardsProvider = FutureProvider<List<FlashcardWithMatiere>>((
  ref,
) async {
  final user = ref.watch(currentUserProvider);
  if (user == null) return [];

  final dao = ref.watch(flashcardDaoProvider);
  return dao.getDueForReviewWithMatiere(user.id);
});

// Flashcards groupées par matière (utile pour organiser)
final flashcardsByMatiereProvider =
    FutureProvider.family<List<Flashcard>, String>((ref, matiereId) async {
      final user = ref.watch(currentUserProvider);
      if (user == null) return [];

      final all = await ref.watch(userFlashcardsProvider.future);
      return all.where((f) => f.matiereId == matiereId).toList();
    });
