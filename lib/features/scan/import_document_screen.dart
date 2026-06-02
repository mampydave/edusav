// lib/features/scan/screens/import_document_screen.dart
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:edusav/core/constants/app_colors.dart';

class ImportDocumentScreen extends StatefulWidget {
  final String matiereId;
  final String matiereName;
  final String niveauId;
  final String ecoleId;
  final String niveauName;
  final String ecoleName;

  const ImportDocumentScreen({
    super.key,
    required this.matiereId,
    required this.matiereName,
    required this.niveauId,
    required this.ecoleId,
    required this.niveauName,
    required this.ecoleName,
  });

  @override
  State<ImportDocumentScreen> createState() => _ImportDocumentScreenState();
}

class _ImportDocumentScreenState extends State<ImportDocumentScreen> {
  List<PlatformFile> selectedFiles = [];
  bool _isLoading = false;

  Future<void> _pickFiles() async {
    setState(() => _isLoading = true);

    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
        allowMultiple: true,
      );

      if (result != null && result.files.isNotEmpty) {
        setState(() {
          selectedFiles = result.files;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${result.files.length} fichier(s) sélectionné(s)'),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erreur lors de la sélection')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _goToConfirmScreen() {
    if (selectedFiles.isEmpty) return;

    Navigator.pushNamed(
      context,
      '/confirm-pages',
      arguments: {
        'files': selectedFiles,
        'matiereId': widget.matiereId,
        'matiereName': widget.matiereName,
        'niveauId': widget.niveauId,
        'ecoleId': widget.ecoleId,
        'niveauName': widget.niveauName,
        'ecoleName': widget.ecoleName,
        'source': 'import',
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.matiereName),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Info niveau + école
            Row(
              children: [
                const Icon(Icons.school, color: Colors.grey),
                const SizedBox(width: 8),
                Text(
                  "${widget.niveauName} • ${widget.ecoleName}", // ← Maintenant ça marche
                  style: const TextStyle(fontSize: 15, color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(height: 8),

            const Text(
              "Importer un document",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              "Formats supportés : PDF, JPG, JPEG, PNG",
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 40),

            // Zone principale
            Expanded(
              child: selectedFiles.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.cloud_upload_outlined,
                            size: 100,
                            color: Colors.grey[400],
                          ),
                          const SizedBox(height: 24),
                          const Text(
                            "Aucun fichier sélectionné",
                            style: TextStyle(fontSize: 18, color: Colors.grey),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: selectedFiles.length,
                      itemBuilder: (context, index) {
                        final file = selectedFiles[index];
                        return Card(
                          child: ListTile(
                            leading: const Icon(Icons.insert_drive_file),
                            title: Text(file.name),
                            subtitle: Text(
                              "${(file.size / 1024).toStringAsFixed(1)} KB",
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                setState(() => selectedFiles.removeAt(index));
                              },
                            ),
                          ),
                        );
                      },
                    ),
            ),

            // Boutons
            Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton.icon(
                    onPressed: _isLoading ? null : _pickFiles,
                    icon: const Icon(Icons.upload_file),
                    label: Text(
                      _isLoading ? "Chargement..." : "Choisir des fichiers",
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                if (selectedFiles.isNotEmpty)
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton.icon(
                      onPressed: _goToConfirmScreen,
                      icon: const Icon(Icons.edit),
                      label: const Text("Continuer vers l'édition"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
