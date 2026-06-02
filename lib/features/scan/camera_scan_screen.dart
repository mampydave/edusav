// lib/features/scan/screens/camera_scan_screen.dart
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:edusav/features/scan/edit_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:edusav/core/constants/app_colors.dart';

class CameraScanScreen extends ConsumerStatefulWidget {
  final String matiereId;
  final String matiereName;
  final String niveauId;
  final String ecoleId;
  final String niveauName;
  final String ecoleName;

  const CameraScanScreen({
    super.key,
    required this.matiereId,
    required this.matiereName,
    required this.niveauId,
    required this.ecoleId,
    required this.niveauName,
    required this.ecoleName,
  });

  @override
  ConsumerState<CameraScanScreen> createState() => _CameraScanScreenState();
}

class _CameraScanScreenState extends ConsumerState<CameraScanScreen> {
  CameraController? _controller;
  bool _isInitialized = false;
  bool _isProcessing = false;
  bool _showPreview = false; // bascule vue caméra / vue pages capturées
  final List<String> _capturedImages = [];

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  // ── Caméra ────────────────────────────────────────────────────────────────

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    if (cameras.isEmpty) return;

    _controller = CameraController(
      cameras.first,
      ResolutionPreset.max,
      enableAudio: false,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );

    try {
      await _controller!.initialize();
      // Autofocus continu pour les documents
      await _controller!.setFocusMode(FocusMode.auto);
      await _controller!.setExposureMode(ExposureMode.auto);
      if (mounted) setState(() => _isInitialized = true);
    } catch (e) {
      debugPrint("Erreur caméra : $e");
    }
  }

  Future<void> _takePicture() async {
    if (_controller == null ||
        !_controller!.value.isInitialized ||
        _isProcessing)
      return;

    setState(() => _isProcessing = true);

    try {
      // Flash bref pour feedback visuel
      await _controller!.setFlashMode(FlashMode.off);
      final image = await _controller!.takePicture();

      setState(() {
        _capturedImages.add(image.path);
      });

      // Feedback haptique via snackbar léger
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Page ${_capturedImages.length} capturée'),
            duration: const Duration(milliseconds: 800),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.black87,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Erreur lors de la capture')),
        );
      }
    } finally {
      if (mounted) setState(() => _isProcessing = false);
    }
  }

  void _removeImage(int index) {
    setState(() => _capturedImages.removeAt(index));
    if (_capturedImages.isEmpty) setState(() => _showPreview = false);
  }

  void _reorderImage(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) newIndex--;
      final item = _capturedImages.removeAt(oldIndex);
      _capturedImages.insert(newIndex, item);
    });
  }

  void _goToEditor() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => EditTextScreen(
          pages: List<String>.from(_capturedImages),
          matiereId: widget.matiereId,
          matiereName: widget.matiereName,
          niveauId: widget.niveauId,
          ecoleId: widget.ecoleId,
          niveauName: widget.niveauName,
          ecoleName: widget.ecoleName,
        ),
      ),
    );
  }

  // ── Build ─────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: _buildAppBar(),
      body: _showPreview ? _buildPagesPreview() : _buildCameraView(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
      title: Text(widget.matiereName, style: const TextStyle(fontSize: 16)),
      actions: [
        // Basculer vers la vue pages si au moins 1 photo
        if (_capturedImages.isNotEmpty)
          TextButton.icon(
            onPressed: () => setState(() => _showPreview = !_showPreview),
            icon: Icon(
              _showPreview ? Icons.camera_alt : Icons.photo_library,
              size: 18,
            ),
            label: Text(
              _showPreview ? 'Caméra' : '${_capturedImages.length} page(s)',
            ),
            style: TextButton.styleFrom(foregroundColor: Colors.white),
          ),
        // Bouton Éditer — seulement en vue pages
        if (_showPreview && _capturedImages.isNotEmpty)
          TextButton.icon(
            onPressed: _goToEditor,
            icon: const Icon(Icons.edit_document, size: 18),
            label: const Text('Éditer'),
            style: TextButton.styleFrom(foregroundColor: AppColors.primary),
          ),
      ],
    );
  }

  // ── Vue caméra ────────────────────────────────────────────────────────────

  Widget _buildCameraView() {
    return Column(
      children: [
        // Preview caméra
        Expanded(
          child: _isInitialized && _controller != null
              ? Stack(
                  fit: StackFit.expand,
                  children: [
                    CameraPreview(_controller!),
                    // Cadre de visée document
                    _DocumentFrame(),
                    // Vignette des pages déjà capturées (bas gauche)
                    if (_capturedImages.isNotEmpty)
                      Positioned(
                        left: 12,
                        bottom: 12,
                        child: GestureDetector(
                          onTap: () => setState(() => _showPreview = true),
                          child: _PagesThumbnailStack(images: _capturedImages),
                        ),
                      ),
                  ],
                )
              : const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                ),
        ),

        // Contrôles
        Container(
          padding: const EdgeInsets.fromLTRB(24, 20, 24, 32),
          color: Colors.black,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Placeholder gauche pour centrer le bouton
              const SizedBox(width: 56),

              // Bouton capture
              GestureDetector(
                onTap: _isProcessing ? null : _takePicture,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  height: 72,
                  width: 72,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _isProcessing ? Colors.white24 : Colors.white,
                    border: Border.all(color: Colors.white54, width: 3),
                  ),
                  child: _isProcessing
                      ? const Padding(
                          padding: EdgeInsets.all(20),
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : const SizedBox.shrink(),
                ),
              ),

              // Bouton Éditer (droite)
              if (_capturedImages.isNotEmpty)
                GestureDetector(
                  onTap: _goToEditor,
                  child: Container(
                    height: 56,
                    width: 56,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                )
              else
                const SizedBox(width: 56),
            ],
          ),
        ),
      ],
    );
  }

  // ── Vue pages capturées ───────────────────────────────────────────────────

  Widget _buildPagesPreview() {
    return Column(
      children: [
        // Grille réorderable
        Expanded(
          child: ReorderableListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: _capturedImages.length,
            onReorder: _reorderImage,
            itemBuilder: (context, index) {
              return _PageTile(
                key: ValueKey(_capturedImages[index]),
                imagePath: _capturedImages[index],
                pageNumber: index + 1,
                onDelete: () => _removeImage(index),
              );
            },
          ),
        ),

        // Barre d'action bas
        Container(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 28),
          color: Colors.grey[900],
          child: Row(
            children: [
              // Reprendre la caméra
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => setState(() => _showPreview = false),
                  icon: const Icon(Icons.add_a_photo),
                  label: const Text('Ajouter une page'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    side: const BorderSide(color: Colors.white30),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              // Lancer l'édition
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: _goToEditor,
                  icon: const Icon(Icons.edit_document),
                  label: const Text('Éditer'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Widgets utilitaires
// ─────────────────────────────────────────────────────────────────────────────

/// Cadre de visée semi-transparent centré sur le preview caméra
class _DocumentFrame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: FractionallySizedBox(
        widthFactor: 0.85,
        heightFactor: 0.75,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white54, width: 1.5),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Stack(
            children: [
              // Coins colorés
              ..._buildCorners(),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildCorners() {
    const size = 20.0;
    const thickness = 3.0;
    const color = Colors.white;

    Widget corner({
      required AlignmentGeometry alignment,
      required BorderRadius radius,
    }) => Align(
      alignment: alignment,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          border: Border(
            top:
                alignment == Alignment.topLeft ||
                    alignment == Alignment.topRight
                ? const BorderSide(color: color, width: thickness)
                : BorderSide.none,
            bottom:
                alignment == Alignment.bottomLeft ||
                    alignment == Alignment.bottomRight
                ? const BorderSide(color: color, width: thickness)
                : BorderSide.none,
            left:
                alignment == Alignment.topLeft ||
                    alignment == Alignment.bottomLeft
                ? const BorderSide(color: color, width: thickness)
                : BorderSide.none,
            right:
                alignment == Alignment.topRight ||
                    alignment == Alignment.bottomRight
                ? const BorderSide(color: color, width: thickness)
                : BorderSide.none,
          ),
          borderRadius: radius,
        ),
      ),
    );

    return [
      corner(
        alignment: Alignment.topLeft,
        radius: const BorderRadius.only(topLeft: Radius.circular(4)),
      ),
      corner(
        alignment: Alignment.topRight,
        radius: const BorderRadius.only(topRight: Radius.circular(4)),
      ),
      corner(
        alignment: Alignment.bottomLeft,
        radius: const BorderRadius.only(bottomLeft: Radius.circular(4)),
      ),
      corner(
        alignment: Alignment.bottomRight,
        radius: const BorderRadius.only(bottomRight: Radius.circular(4)),
      ),
    ];
  }
}

/// Vignette empilée des pages déjà capturées (overlay bas-gauche)
class _PagesThumbnailStack extends StatelessWidget {
  final List<String> images;
  const _PagesThumbnailStack({required this.images});

  @override
  Widget build(BuildContext context) {
    final count = images.length.clamp(1, 3);
    return SizedBox(
      width: 52 + (count - 1) * 4.0,
      height: 68,
      child: Stack(
        children: [
          for (int i = 0; i < count; i++)
            Positioned(
              left: i * 4.0,
              child: Container(
                width: 48,
                height: 64,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: Colors.white30, width: 1),
                  image: DecorationImage(
                    image: FileImage(File(images[images.length - 1 - i])),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          // Badge compteur
          Positioned(
            right: 0,
            top: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                '${images.length}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Tuile d'une page dans la vue de révision (réorderable)
class _PageTile extends StatelessWidget {
  final String imagePath;
  final int pageNumber;
  final VoidCallback onDelete;

  const _PageTile({
    super.key,
    required this.imagePath,
    required this.pageNumber,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white12),
      ),
      child: Row(
        children: [
          // Aperçu de la page
          ClipRRect(
            borderRadius: const BorderRadius.horizontal(
              left: Radius.circular(8),
            ),
            child: Image.file(
              File(imagePath),
              width: 80,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          // Numéro de page
          Expanded(
            child: Text(
              'Page $pageNumber',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          // Handle de réordonnancement (fourni par ReorderableListView)
          ReorderableDragStartListener(
            index: pageNumber - 1,
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Icon(Icons.drag_handle, color: Colors.white38),
            ),
          ),
          // Supprimer
          IconButton(
            onPressed: onDelete,
            icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
          ),
        ],
      ),
    );
  }
}
