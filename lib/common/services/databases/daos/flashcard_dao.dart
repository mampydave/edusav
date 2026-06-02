import 'package:drift/drift.dart';
import 'package:edusav/common/models/flash_card_with_matiere.dart';
import 'package:edusav/common/services/databases/database.dart';
import 'package:edusav/common/services/databases/tables.dart';
part 'flashcard_dao.g.dart';

@DriftAccessor(tables: [Flashcards])
class FlashcardDao extends DatabaseAccessor<AppDatabase>
    with _$FlashcardDaoMixin {
  FlashcardDao(super.db);

  // Insert
  Future<int> insertFlashcard(FlashcardsCompanion card) {
    return into(flashcards).insert(card);
  }

  // Get all active
  Future<List<Flashcard>> getAllActive() =>
      (select(flashcards)..where((f) => f.isActive.equals(true))).get();

  // Get by user
  Future<List<Flashcard>> getByUser(String userId) => (select(
    flashcards,
  )..where((f) => f.userId.equals(userId) & f.isActive.equals(true))).get();

  // Dans FlashcardDao
  Future<List<FlashcardWithMatiere>> getDueForReviewWithMatiere(
    String userId,
  ) async {
    final now = DateTime.now().millisecondsSinceEpoch;

    final query =
        select(flashcards).join([
          innerJoin(matieres, matieres.id.equalsExp(flashcards.matiereId)),
        ])..where(
          flashcards.userId.equals(userId) &
              flashcards.isActive.equals(true) &
              flashcards.nextReviewDate.isSmallerOrEqualValue(now),
        );

    final rows = await query.get();

    return rows.map((row) {
      return FlashcardWithMatiere(
        flashcard: row.readTable(flashcards),
        matiere: row.readTable(matieres),
      );
    }).toList();
  }

  // Update after review
  Future<void> updateAfterReview(String id, int quality) async {
    final card = await (select(
      flashcards,
    )..where((f) => f.id.equals(id))).getSingle();

    // Simple SM-2 logic
    double newEF =
        card.easinessFactor +
        (0.1 - (5 - quality) * (0.08 + (5 - quality) * 0.02));
    newEF = newEF.clamp(1.3, 2.5);

    int newInterval = card.intervalDays;
    if (quality >= 3) {
      newInterval = (card.intervalDays * newEF).round().clamp(1, 365);
    } else {
      newInterval = 1;
    }

    final nextReview = DateTime.now()
        .add(Duration(days: newInterval))
        .millisecondsSinceEpoch;

    await (update(flashcards)..where((f) => f.id.equals(id))).write(
      FlashcardsCompanion(
        intervalDays: Value(newInterval),
        repetitions: Value(card.repetitions + 1),
        easinessFactor: Value(newEF),
        nextReviewDate: Value(nextReview),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  // Hide card
  Future<void> hideCard(String id) =>
      (update(flashcards)..where((f) => f.id.equals(id))).write(
        const FlashcardsCompanion(isActive: Value(false)),
      );

  // Delete
  Future<void> deleteCard(String id) =>
      (delete(flashcards)..where((f) => f.id.equals(id))).go();
}
