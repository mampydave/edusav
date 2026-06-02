// lib/features/scan/screens/confirm_pages_screen.dart
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:edusav/core/constants/app_colors.dart';

class ConfirmPagesScreen extends StatefulWidget {
  final List<dynamic> files;
  final String matiereId;
  final String matiereName;
  final String niveauId;
  final String ecoleId;
  final String niveauName;
  final String ecoleName;
  final String source;

  const ConfirmPagesScreen({
    super.key,
    required this.files,
    required this.matiereId,
    required this.matiereName,
    required this.niveauId,
    required this.ecoleId,
    required this.niveauName,
    required this.ecoleName,
    required this.source,
  });

  @override
  State<ConfirmPagesScreen> createState() => _ConfirmPagesScreenState();
}

class _ConfirmPagesScreenState extends State<ConfirmPagesScreen> {
  late List<dynamic> _pages;

  @override
  void initState() {
    super.initState();
    _pages = List.from(widget.files);
  }

  void _reorderPage(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) newIndex--;
      final item = _pages.removeAt(oldIndex);
      _pages.insert(newIndex, item);
    });
  }

  void _removePage(int index) {
    setState(() => _pages.removeAt(index));
  }

  void _goToEdit() {
    Navigator.pushNamed(
      context,
      '/edit-text',
      arguments: {
        'pages': _pages,
        'matiereId': widget.matiereId,
        'matiereName': widget.matiereName,
        'niveauId': widget.niveauId,
        'ecoleId': widget.ecoleId,
        'niveauName': widget.niveauName,
        'ecoleName': widget.ecoleName,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        title: const Text("Confirmer les pages"),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          // ── Header ──────────────────────────────────────────────────────
          Container(
            color: AppColors.primary,
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.layers, color: Colors.white, size: 16),
                      const SizedBox(width: 6),
                      Text(
                        '${_pages.length} page${_pages.length > 1 ? 's' : ''}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Text(
                    'Maintenez ☰ pour réordonner',
                    style: TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                ),
              ],
            ),
          ),

          // ── Liste réorderable ────────────────────────────────────────────
          Expanded(
            child: _pages.isEmpty
                ? _buildEmptyState()
                : ReorderableListView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                    itemCount: _pages.length,
                    onReorder: _reorderPage,
                    proxyDecorator: (child, index, animation) {
                      return Material(
                        elevation: 8,
                        borderRadius: BorderRadius.circular(12),
                        shadowColor: AppColors.primary.withOpacity(0.3),
                        child: child,
                      );
                    },
                    itemBuilder: (context, index) {
                      final file = _pages[index];
                      final name = file is PlatformFile
                          ? file.name
                          : 'Page ${index + 1}';
                      final isFile = file is PlatformFile;
                      final hasPath = isFile
                          ? (file.path != null)
                          : (file is String);
                      final path = isFile
                          ? file.path
                          : (file is String ? file : null);

                      return _PageConfirmTile(
                        key: ValueKey(file),
                        index: index,
                        name: name,
                        imagePath: (hasPath && path != null) ? path : null,
                        onDelete: () => _removePage(index),
                      );
                    },
                  ),
          ),

          // ── Barre d'action sticky ────────────────────────────────────────
          _BottomActionBar(
            pageCount: _pages.length,
            onContinue: _pages.isNotEmpty ? _goToEdit : null,
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.insert_drive_file_outlined,
            size: 64,
            color: Colors.grey[300],
          ),
          const SizedBox(height: 16),
          Text(
            'Aucune page à confirmer',
            style: TextStyle(color: Colors.grey[500], fontSize: 16),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Tuile d'une page
// ─────────────────────────────────────────────────────────────────────────────

class _PageConfirmTile extends StatelessWidget {
  final int index;
  final String name;
  final String? imagePath;
  final VoidCallback onDelete;

  const _PageConfirmTile({
    super.key,
    required this.index,
    required this.name,
    required this.imagePath,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // ── Thumbnail ──
          ClipRRect(
            borderRadius: const BorderRadius.horizontal(
              left: Radius.circular(12),
            ),
            child: _buildThumbnail(),
          ),

          const SizedBox(width: 14),

          // ── Nom + sous-titre ──
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Page ${index + 1}',
                  style: TextStyle(color: Colors.grey[500], fontSize: 12),
                ),
              ],
            ),
          ),

          // ── Supprimer ──
          IconButton(
            onPressed: onDelete,
            icon: const Icon(
              Icons.delete_outline,
              color: Colors.redAccent,
              size: 22,
            ),
            tooltip: 'Supprimer',
          ),

          // ── Handle drag ──
          ReorderableDragStartListener(
            index: index,
            child: Padding(
              padding: const EdgeInsets.only(right: 12, left: 4),
              child: Icon(Icons.drag_handle, color: Colors.grey[350], size: 24),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildThumbnail() {
    if (imagePath != null) {
      return Image.file(
        File(imagePath!),
        width: 70,
        height: 88,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => _placeholderThumbnail(),
      );
    }
    return _placeholderThumbnail();
  }

  Widget _placeholderThumbnail() {
    return Container(
      width: 70,
      height: 88,
      color: const Color(0xFFEEF0F5),
      child: const Icon(
        Icons.image_outlined,
        color: Color(0xFFBBC0CC),
        size: 32,
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Barre d'action en bas (sticky, bien accessible)
// ─────────────────────────────────────────────────────────────────────────────

class _BottomActionBar extends StatelessWidget {
  final int pageCount;
  final VoidCallback? onContinue;

  const _BottomActionBar({required this.pageCount, required this.onContinue});

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      padding: EdgeInsets.fromLTRB(16, 14, 16, 14 + bottomPadding),
      child: SizedBox(
        width: double.infinity,
        height: 56,
        child: ElevatedButton.icon(
          onPressed: onContinue,
          icon: const Icon(Icons.arrow_forward_rounded),
          label: Text(
            pageCount > 0
                ? 'Continuer ($pageCount page${pageCount > 1 ? 's' : ''})'
                : 'Continuer',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            disabledBackgroundColor: Colors.grey[200],
            disabledForegroundColor: Colors.grey[400],
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
        ),
      ),
    );
  }
}
