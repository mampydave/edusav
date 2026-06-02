import 'package:edusav/core/di/scan_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:edusav/core/constants/app_colors.dart';

class SelectLevelScreen extends ConsumerWidget {
  const SelectLevelScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userLevelsAsync = ref.watch(userLevelsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Smart Scanner'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Select your current level",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            const Text(
              "Based on your academic record",
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 32),

            // 🔥 IMPORTANT : Expanded
            Expanded(
              child: userLevelsAsync.when(
                data: (levels) {
                  if (levels.isEmpty) {
                    return const Center(
                      child: Text(
                        "Aucun niveau trouvé. Veuillez vérifier votre profil.",
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: levels.length,
                    itemBuilder: (context, index) {
                      final (niveau, ecole) = levels[index];

                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: AppColors.primary.withOpacity(0.1),
                            child: const Icon(
                              Icons.school,
                              color: AppColors.primary,
                            ),
                          ),
                          title: Text(niveau.nomNiveau),
                          subtitle: Text(ecole.nom),
                          trailing: const Icon(
                            Icons.arrow_forward_ios,
                            size: 18,
                          ),
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              '/select-subject',
                              arguments: {
                                'niveauId': niveau.id,
                                'niveauName': niveau.nomNiveau,
                                'ecoleId': ecole.id,
                                'ecoleName': ecole.nom,
                              },
                            );
                          },
                        ),
                      );
                    },
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (_, __) => const Center(
                  child: Text("Erreur de chargement des niveaux"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
