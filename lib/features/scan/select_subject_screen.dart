import 'package:edusav/common/models/subject_filter.dart';
import 'package:edusav/core/di/scan_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:edusav/core/constants/app_colors.dart';

class SelectSubjectScreen extends ConsumerWidget {
  final String niveauName;
  final String ecoleName;
  final String niveauId;
  final String ecoleId;

  const SelectSubjectScreen({
    super.key,
    required this.niveauName,
    required this.ecoleName,
    required this.niveauId,
    required this.ecoleId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print(
      "📚 SelectSubjectScreen → Chargement des matières pour NiveauID: $niveauId, EcoleID: $ecoleId",
    );
    final subjectsAsync = ref.watch(
      subjectsByLevelProvider(
        SubjectFilter(ecoleId: ecoleId, niveauId: niveauId),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(niveauName),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ecoleName,
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(height: 4),
                const Text(
                  "Choisissez une matière",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),

          Expanded(
            child: subjectsAsync.when(
              data: (matieres) {
                if (matieres.isEmpty) {
                  return const Center(
                    child: Text("Aucune matière disponible pour ce niveau"),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: matieres.length,
                  itemBuilder: (context, index) {
                    final matiere = matieres[index];

                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                        leading: CircleAvatar(
                          backgroundColor: AppColors.primary,
                          child: const Icon(Icons.book, color: Colors.white),
                        ),
                        title: Text(
                          matiere.nom,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        subtitle: Text(matiere.codeMatiere ?? ''),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 18),
                        onTap: () {
                          // Navigation vers l'écran de scan/import
                          Navigator.pushNamed(
                            context,
                            '/scan-options',
                            arguments: {
                              'niveauId': niveauId,
                              'ecoleId': ecoleId,
                              'matiereId': matiere.id,
                              'matiereName': matiere.nom,
                              'niveauName': niveauName,
                              'ecoleName': ecoleName,
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
                child: Text("Erreur lors du chargement des matières"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
