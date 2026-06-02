// lib/features/scan/screens/scan_options_screen.dart
import 'package:flutter/material.dart';
import 'package:edusav/core/constants/app_colors.dart';

class ScanOptionsScreen extends StatelessWidget {
  final String niveauName;
  final String ecoleName;
  final String matiereName;
  final String matiereId;
  final String niveauId;
  final String ecoleId;

  const ScanOptionsScreen({
    super.key,
    required this.niveauName,
    required this.ecoleName,
    required this.matiereName,
    required this.matiereId,
    required this.niveauId,
    required this.ecoleId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(matiereName),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // En-tête
            Row(
              children: [
                const Icon(Icons.school, color: Colors.grey),
                const SizedBox(width: 8),
                Text(
                  "$niveauName • $ecoleName",
                  style: const TextStyle(fontSize: 15, color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              "Comment voulez-vous ajouter ce cours ?",
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),

            // Option 1 : Scanner avec caméra
            _buildOptionCard(
              context,
              icon: Icons.camera_alt_rounded,
              title: "Scanner avec la caméra",
              subtitle: "Prenez des photos de vos cours papier",
              color: AppColors.primary,
              onTap: () {
                // Navigation vers l'écran de scan caméra
                Navigator.pushNamed(
                  context,
                  '/camera-scan',
                  arguments: {
                    'matiereId': matiereId,
                    'matiereName': matiereName,
                    'niveauId': niveauId,
                    'ecoleId': ecoleId,
                  },
                );
              },
            ),

            const SizedBox(height: 16),

            // Option 2 : Importer un document
            _buildOptionCard(
              context,
              icon: Icons.upload_file_rounded,
              title: "Importer un document",
              subtitle: "PDF, images, ou fichiers existants",
              color: Colors.purple,
              onTap: () {
                // Navigation vers l'écran d'import
                Navigator.pushNamed(
                  context,
                  '/import-document',
                  arguments: {
                    'matiereId': matiereId,
                    'matiereName': matiereName,
                    'niveauId': niveauId,
                    'ecoleId': ecoleId,
                    'niveauName': niveauName,
                    'ecoleName': ecoleName,
                  },
                );
              },
            ),

            const Spacer(),

            // Information
            const Center(
              child: Text(
                "Vous pourrez éditer le texte après la capture ou l'import",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey, fontSize: 13),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 32, color: color),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      subtitle,
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios, size: 20),
            ],
          ),
        ),
      ),
    );
  }
}
