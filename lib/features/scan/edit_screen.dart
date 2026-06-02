// lib/features/scan/screens/edit_text_screen.dart
import 'package:edusav/core/di/scan_save_provider.dart';
import 'package:edusav/core/utils/text_extractor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:edusav/core/constants/app_colors.dart';

class EditTextScreen extends ConsumerStatefulWidget {
  final List<dynamic> pages;
  final String matiereId;
  final String matiereName;
  final String niveauId;
  final String ecoleId;
  final String niveauName;
  final String ecoleName;

  const EditTextScreen({
    super.key,
    required this.pages,
    required this.matiereId,
    required this.matiereName,
    required this.niveauId,
    required this.ecoleId,
    required this.niveauName,
    required this.ecoleName,
  });

  @override
  ConsumerState<EditTextScreen> createState() => _EditTextScreenState();
}

class _EditTextScreenState extends ConsumerState<EditTextScreen> {
  late quill.QuillController _controller;
  bool _isSaving = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _controller = quill.QuillController.basic();
    _loadDocumentContent();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _loadDocumentContent() async {
    setState(() => _isLoading = true);

    try {
      final List<Map<String, dynamic>> deltaOps = [];

      for (var file in widget.pages) {
        final pageText = await extractTextFromFile(file);
        final pageNumber = widget.pages.indexOf(file) + 1;

        // ── En-tête de page ──────────────────────────────────────────────
        deltaOps.add({
          'insert': '=== Page $pageNumber ===',
          'attributes': {'bold': true},
        });
        deltaOps.add({'insert': '\n'});
        deltaOps.add({'insert': '\n'});

        // ── Contenu : police MONOSPACE pour que les espaces multiples
        //    générés par _reconstructSpatialLayout s'alignent correctement ──
        final trimmedText = pageText.trimRight();

        if (trimmedText.isNotEmpty) {
          final lines = trimmedText.split('\n');

          for (int i = 0; i < lines.length; i++) {
            final line = lines[i];

            if (line.isNotEmpty) {
              deltaOps.add({
                'insert': line,
                'attributes': {'font': 'Courier'},
              });
            }

            deltaOps.add({'insert': '\n'});
          }
        }

        if (pageNumber < widget.pages.length) {
          deltaOps.add({'insert': '\n'});
        }
      }

      if (deltaOps.isEmpty || deltaOps.last['insert'] != '\n') {
        deltaOps.add({'insert': '\n'});
      }

      final document = quill.Document.fromJson(deltaOps);

      if (mounted) {
        setState(() {
          _controller = quill.QuillController(
            document: document,
            selection: const TextSelection.collapsed(offset: 0),
          );
          _isLoading = false;
        });
      }
    } catch (e) {
      print("Erreur d'extraction du texte : $e");
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _saveLesson() async {
    setState(() => _isSaving = true);

    try {
      final saveService = ref.read(scanSaveProvider);

      await saveService.saveLesson(
        matiereId: widget.matiereId,
        titre:
            "${widget.matiereName} - ${DateTime.now().toString().substring(0, 10)}",
        pages: widget.pages,
        niveauId: widget.niveauId,
        ecoleId: widget.ecoleId,
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Leçon enregistrée avec succès !'),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.popUntil(context, (route) => route.isFirst);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur : $e'), backgroundColor: Colors.red),
      );
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  int get _wordCount {
    final text = _controller.document.toPlainText().trim();
    if (text.isEmpty) return 0;
    return text.split(RegExp(r'\s+')).length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Text"),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: _isSaving
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(color: Colors.white),
                  )
                : const Icon(Icons.check),
            onPressed: _isSaving ? null : _saveLesson,
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            color: Colors.grey[100],
            child: Row(
              children: [
                Chip(label: Text(widget.niveauName)),
                const SizedBox(width: 8),
                Chip(label: Text(widget.matiereName)),
              ],
            ),
          ),
          quill.QuillSimpleToolbar(controller: _controller),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(16),
                    // SingleChildScrollView horizontal pour ne pas casser
                    // les lignes contenant des colonnes d'équations
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: SizedBox(
                        // largeur min pour accommoder les lignes larges
                        width: MediaQuery.of(context).size.width * 1.5,
                        child: quill.QuillEditor.basic(controller: _controller),
                      ),
                    ),
                  ),
          ),
          Container(
            padding: const EdgeInsets.all(12),
            color: Colors.grey[100],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "$_wordCount mots",
                  style: TextStyle(color: Colors.grey[600]),
                ),
                Text(
                  "${_controller.document.toPlainText().length} caractères",
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
