import 'package:edusav/common/models/flash_card_with_matiere.dart';
import 'package:edusav/core/di/flop_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:edusav/core/constants/app_colors.dart';

class FlopRevisionScreen extends ConsumerStatefulWidget {
  const FlopRevisionScreen({super.key});

  @override
  ConsumerState<FlopRevisionScreen> createState() => _FlopRevisionScreenState();
}

class _FlopRevisionScreenState extends ConsumerState<FlopRevisionScreen> {
  int _currentIndex = 0;
  bool _showAnswer = false;

  @override
  Widget build(BuildContext context) {
    final dueCardsAsync = ref.watch(dueFlashcardsProvider);

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("Flop Revision"),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.refresh(dueFlashcardsProvider),
          ),
        ],
      ),
      body: dueCardsAsync.when(
        data: (cards) {
          if (cards.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.celebration_outlined,
                    size: 90,
                    color: Colors.green,
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Aucune carte à réviser pour le moment",
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Revenez plus tard",
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            );
          }

          final current = cards[_currentIndex % cards.length];
          final card = current.flashcard;
          final matiere = current.matiere;

          return Column(
            children: [
              // Progress
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Progress", style: TextStyle(fontSize: 16)),
                    Text(
                      "${_currentIndex + 1} / ${cards.length}",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),

              LinearProgressIndicator(
                value: (_currentIndex + 1) / cards.length,
                minHeight: 6,
                backgroundColor: Colors.grey[300],
                valueColor: const AlwaysStoppedAnimation(AppColors.primary),
              ),

              const SizedBox(height: 12),

              // Matière
              Chip(
                label: Text(matiere.nom),
                backgroundColor: AppColors.primary,
                labelStyle: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 20),

              // Carte Interactive
              Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => _showAnswer = !_showAnswer),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (!_showAnswer) ...[
                          // Côté Question
                          CircleAvatar(
                            radius: 45,
                            backgroundColor: Colors.grey[200],
                            child: const Text(
                              "?",
                              style: TextStyle(
                                fontSize: 60,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          const SizedBox(height: 50),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: Text(
                              card.question,
                              style: const TextStyle(fontSize: 21, height: 1.4),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const Spacer(),
                          const Text(
                            "Tap to reveal answer",
                            style: TextStyle(color: Colors.grey, fontSize: 15),
                          ),
                          const SizedBox(height: 40),
                        ] else ...[
                          // Côté Réponse
                          const Icon(
                            Icons.lightbulb,
                            size: 70,
                            color: Colors.amber,
                          ),
                          const SizedBox(height: 40),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: Text(
                              card.reponse,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          if (card.explication != null &&
                              card.explication!.isNotEmpty) ...[
                            const SizedBox(height: 24),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 30,
                              ),
                              child: Text(
                                card.explication!,
                                style: const TextStyle(
                                  fontSize: 16,
                                  height: 1.5,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                          const Spacer(),
                          const Text(
                            "Tap to see question",
                            style: TextStyle(color: Colors.grey, fontSize: 15),
                          ),
                          const SizedBox(height: 40),
                        ],
                      ],
                    ),
                  ),
                ),
              ),

              // Boutons du bas
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => _reviewCard(current, 2), // Difficile
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: const Text(
                          "Review again\nNeed more practice",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => _reviewCard(current, 5), // Facile
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: const Text(
                          "Got it!\nI know this",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, __) =>
            const Center(child: Text("Erreur lors du chargement des cartes")),
      ),
    );
  }

  Future<void> _reviewCard(FlashcardWithMatiere item, int quality) async {
    final dao = ref.read(flashcardDaoProvider);
    await dao.updateAfterReview(item.flashcard.id, quality);

    setState(() {
      _showAnswer = false;
      _currentIndex++;
    });
  }
}
