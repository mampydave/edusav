import 'package:edusav/core/constants/app_colors.dart';
import 'package:edusav/features/auth/presentation/auth_controller.dart';
import 'package:edusav/core/di/current_user_provider.dart';
import 'package:edusav/core/di/matiere_provider.dart';
import 'package:edusav/features/debug/debug_db_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeContent extends ConsumerWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userContextAsync = ref.watch(currentUserWithContextProvider);
    final userSubjectsAsync = ref.watch(userCurrentSubjectsProvider);

    return RefreshIndicator(
      onRefresh: () async {
        ref.refresh(currentUserWithContextProvider);
        ref.refresh(userCurrentSubjectsProvider);
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(24, 50, 24, 40),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(32),
                  bottomRight: Radius.circular(32),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Welcome back!",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 6),
                          const Text(
                            "Let's continue learning",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () => _showLogoutMenu(context, ref),
                        child: CircleAvatar(
                          radius: 26,
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.person,
                            color: AppColors.primary,
                            size: 28,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 32),

                  // Stats Cards
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 16,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _StatCard(value: "24", label: "Cards Due"),
                        _StatCard(value: "89%", label: "Accuracy"),
                        _StatCard(value: "7", label: "Day Streak"),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // ==================== CONTENU PRINCIPAL ====================
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Your Subjects",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),

                  // Liste des matières
                  userSubjectsAsync.when(
                    data: (matieres) {
                      if (matieres.isEmpty) {
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 60),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.school_outlined,
                                  size: 60,
                                  color: Colors.grey,
                                ),
                                SizedBox(height: 16),
                                Text(
                                  "Aucune matière trouvée",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  "Commencez par scanner vos cours ou définissez votre niveau scolaire",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                        );
                      }

                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: matieres.length,
                        itemBuilder: (context, index) {
                          final matiere = matieres[index];
                          final progress =
                              0.45 +
                              (index % 4) * 0.12; // simulation temporaire

                          return _buildSubjectCard(
                            context,
                            ref,
                            matiere.nom,
                            progress,
                            matiere.id,
                          );
                        },
                      );
                    },
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    error: (err, _) => Center(child: Text('Erreur : $err')),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubjectCard(
    BuildContext context,
    WidgetRef ref,
    String name,
    double progress,
    String matiereId,
  ) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: () {
          // On récupère les données du provider (currentUserWithContextProvider)
          final contextData = ref.read(currentUserWithContextProvider).value;
          final ecole = contextData?.$3;
          final niveau = contextData?.$4;

          if (ecole != null && niveau != null) {
            Navigator.pushNamed(
              context,
              '/lesson-cahier',
              arguments: {
                'matiereId': matiereId,
                'matiereName': name,
                'ecoleId': ecole.id,
                'niveauId': niveau.id,
                'ecoleName': ecole.nom,
                'niveauName': niveau.nomNiveau ?? '',
              },
            );
          }
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: AppColors.primary,
                    radius: 24,
                    child: const Icon(Icons.book, color: Colors.white),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Progress"),
                  Text(
                    "${(progress * 100).toInt()}%",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: LinearProgressIndicator(
                  value: progress,
                  minHeight: 10,
                  backgroundColor: Colors.grey[300],
                  valueColor: const AlwaysStoppedAnimation(AppColors.primary),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showLogoutMenu(BuildContext context, WidgetRef ref) async {
    final isAdmin = await ref
        .read(isCurrentUserAdminProvider.future)
        .catchError((_) => false);
    if (!context.mounted) return;
    final navigator = Navigator.of(context);

    await showModalBottomSheet<void>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Mon profil'),
              onTap: () {
                Navigator.pop(context);
                navigator.pushNamed('/profile');
              },
            ),
            // rediriger vers debug screen pour l'instant
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Paramètres'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DebugDbScreen()),
                );
              },
            ),
            if (isAdmin)
              ListTile(
                leading: const Icon(
                  Icons.verified_user_outlined,
                  color: Colors.orange,
                ),
                title: const Text('Validation des comptes'),
                subtitle: const Text('Demandes en attente d\'approbation'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/pending-requests');
                },
              ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text(
                'Se déconnecter',
                style: TextStyle(color: Colors.red),
              ),
              onTap: () async {
                Navigator.pop(context); // Ferme le bottom sheet

                // Déconnexion
                await ref.read(authControllerProvider.notifier).logout();

                // Redirection sûre
                if (context.mounted) {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    '/login',
                    (route) => false, // Supprime toute la pile de navigation
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String value;
  final String label;

  const _StatCard({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1565C0),
          ),
        ),
        const SizedBox(height: 4),
        Text(label, style: TextStyle(fontSize: 12, color: Colors.grey[700])),
      ],
    );
  }
}
