// lib/features/cahier/screens/lesson_cahier_screen.dart
import 'dart:io';
import 'package:edusav/features/flop/create_flashcard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reorderable_grid_view/reorderable_grid_view.dart';
import 'package:edusav/core/di/lecon_provider.dart';
import 'package:edusav/core/constants/app_colors.dart';

class LessonCahierScreen extends ConsumerStatefulWidget {
  final String matiereId, matiereName, ecoleName, niveauName, ecoleId, niveauId;

  const LessonCahierScreen({
    super.key,
    required this.matiereId,
    required this.matiereName,
    required this.ecoleName,
    required this.niveauName,
    required this.ecoleId,
    required this.niveauId,
  });

  @override
  ConsumerState<LessonCahierScreen> createState() => _LessonCahierScreenState();
}

class _LessonCahierScreenState extends ConsumerState<LessonCahierScreen> {
  late PageController _pageController;
  int _currentPage = 0;

  // Context menu (long press) — animé via AnimatedOpacity + AnimatedScale
  bool _showContextMenu = false;
  bool _contextMenuVisible = false;
  int _contextPageIndex = -1;

  // Indique qu'une opération DB est en cours (reorder/delete)
  bool _isMutating = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  // ── Helpers provider ─────────────────────────────────────────────────────

  LessonFilter get _filter => LessonFilter(
    matiereId: widget.matiereId,
    ecoleId: widget.ecoleId,
    niveauId: widget.niveauId,
  );

  SubjectPagesNotifier get _notifier =>
      ref.read(allSubjectPagesProvider(_filter).notifier);

  // ── Long press ────────────────────────────────────────────────────────────

  void _onLongPress(int pageViewIndex) {
    if (pageViewIndex == 0) return;
    HapticFeedback.mediumImpact();
    setState(() {
      _showContextMenu = true;
      _contextMenuVisible = false;
      _contextPageIndex = pageViewIndex - 1;
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) setState(() => _contextMenuVisible = true);
    });
  }

  void _dismissContextMenu() {
    setState(() => _contextMenuVisible = false);
    Future.delayed(const Duration(milliseconds: 250), () {
      if (mounted) setState(() => _showContextMenu = false);
    });
  }

  // ── Delete ────────────────────────────────────────────────────────────────

  void _confirmDelete(String pageId, int pageNumber) {
    _dismissContextMenu();
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.grey[900],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          "Supprimer la page ?",
          style: TextStyle(color: Colors.white),
        ),
        content: Text(
          "La page $pageNumber sera définitivement retirée du cahier.",
          style: const TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Annuler"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () async {
              Navigator.pop(context);
              if (_currentPage > 0) {
                _pageController.previousPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOut,
                );
              }
              setState(() => _isMutating = true);
              try {
                await _notifier.deletePage(pageId);
              } finally {
                if (mounted) setState(() => _isMutating = false);
              }
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Page $pageNumber supprimée"),
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.black87,
                  ),
                );
              }
            },
            child: const Text("Supprimer"),
          ),
        ],
      ),
    );
  }

  // ── Reorder ───────────────────────────────────────────────────────────────

  Future<void> _onReorder(int oldIndex, int newIndex) async {
    setState(() => _isMutating = true);
    try {
      await _notifier.reorderPages(oldIndex, newIndex);
    } finally {
      if (mounted) setState(() => _isMutating = false);
    }
  }

  // ── Modals ────────────────────────────────────────────────────────────────

  void _openReorderModal(List<dynamic> pages) {
    _dismissContextMenu();
    _openPagesGrid(pages, reorderMode: true);
  }

  void _openNavGrid(List<dynamic> pages) {
    _openPagesGrid(pages, reorderMode: false);
  }

  void _openPagesGrid(List<dynamic> pages, {required bool reorderMode}) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.grey[900],
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => _PagesGridModal(
        pages: pages,
        currentPage: _currentPage,
        reorderMode: reorderMode,
        isMutating: _isMutating,
        onNavigate: (index) {
          _pageController.jumpToPage(index);
          Navigator.pop(context);
        },
        onReorder: reorderMode
            ? (oldIndex, newIndex) async {
                await _onReorder(oldIndex, newIndex);
                // Fermer et rouvrir pour refléter le nouvel ordre
                if (context.mounted) Navigator.pop(context);
              }
            : null,
        onDeleteInModal: reorderMode
            ? (pageId, pageNumber) async {
                final confirm = await showDialog<bool>(
                  context: context,
                  builder: (_) => AlertDialog(
                    backgroundColor: Colors.grey[900],
                    title: const Text(
                      "Supprimer ?",
                      style: TextStyle(color: Colors.white),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: const Text("Annuler"),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () => Navigator.pop(context, true),
                        child: const Text("Supprimer"),
                      ),
                    ],
                  ),
                );
                if (confirm == true) {
                  await _notifier.deletePage(pageId);
                  if (context.mounted) Navigator.pop(context);
                }
              }
            : null,
      ),
    );
  }

  // ── Build ─────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final pagesAsync = ref.watch(allSubjectPagesProvider(_filter));

    return Scaffold(
      backgroundColor: Colors.black,
      body: pagesAsync.when(
        data: (pages) {
          if (pages.isEmpty) return _buildEmptyState();

          return Stack(
            children: [
              // PageView
              PageView.builder(
                controller: _pageController,
                onPageChanged: (i) => setState(() => _currentPage = i),
                itemCount: pages.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return _buildCover();
                  }
                  return GestureDetector(
                    onLongPress: () => _onLongPress(index),
                    child: _buildPageImage(pages[index - 1].cheminImage ?? ''),
                  );
                },
              ),

              // Header
              _buildHeader(pages),

              // Overlay long press
              if (_showContextMenu) _buildContextOverlay(pages),

              // Indicateur de chargement discret pendant mutation DB
              if (_isMutating)
                const Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: LinearProgressIndicator(
                    minHeight: 2,
                    backgroundColor: Colors.transparent,
                  ),
                ),

              // FAB
              _buildFloatingActions(),
            ],
          );
        },
        loading: () =>
            const Center(child: CircularProgressIndicator(color: Colors.white)),
        error: (e, _) => Center(
          child: Text(
            "Erreur: $e",
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  // ── Header ────────────────────────────────────────────────────────────────

  Widget _buildHeader(List<dynamic> pages) {
    final totalPages = pages.length;
    final isOnCover = _currentPage == 0;

    return Positioned(
      top: MediaQuery.of(context).padding.top + 8,
      left: 12,
      right: 12,
      child: Row(
        children: [
          _NavButton(
            icon: Icons.arrow_back_ios_new_rounded,
            onTap: () => Navigator.pop(context),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () => _openNavGrid(pages),
            child: _PageIndicator(
              label: isOnCover ? 'Garde' : '$_currentPage / $totalPages',
            ),
          ),
          const Spacer(),
          _NavButton(
            icon: Icons.chevron_left_rounded,
            onTap: _currentPage > 0
                ? () => _pageController.previousPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOut,
                  )
                : null,
          ),
          const SizedBox(width: 4),
          _NavButton(
            icon: Icons.chevron_right_rounded,
            onTap: _currentPage < totalPages
                ? () => _pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOut,
                  )
                : null,
          ),
          const SizedBox(width: 4),
          _NavButton(
            icon: Icons.grid_view_rounded,
            onTap: () => _openNavGrid(pages),
          ),
        ],
      ),
    );
  }

  // ── Context overlay ───────────────────────────────────────────────────────

  Widget _buildContextOverlay(List<dynamic> pages) {
    final pageId = _contextPageIndex >= 0 && _contextPageIndex < pages.length
        ? pages[_contextPageIndex].id as String
        : null;

    return AnimatedOpacity(
      opacity: _contextMenuVisible ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOutCubic,
      child: GestureDetector(
        onTap: _dismissContextMenu,
        child: Container(
          color: Colors.black.withOpacity(0.65),
          child: Center(
            child: AnimatedScale(
              scale: _contextMenuVisible ? 1.0 : 0.85,
              duration: const Duration(milliseconds: 220),
              curve: Curves.easeOutCubic,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 48),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E1E2C),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.4),
                      blurRadius: 24,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        'Page ${_contextPageIndex + 1}',
                        style: const TextStyle(
                          color: Colors.white54,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const Divider(color: Colors.white10, height: 1),
                    _ContextMenuAction(
                      icon: Icons.swap_vert_rounded,
                      label: 'Réorganiser les pages',
                      color: Colors.white,
                      onTap: () => _openReorderModal(pages),
                    ),
                    const Divider(color: Colors.white10, height: 1),
                    _ContextMenuAction(
                      icon: Icons.delete_outline_rounded,
                      label: 'Supprimer cette page',
                      color: Colors.redAccent,
                      onTap: () {
                        if (pageId != null) {
                          _confirmDelete(pageId, _contextPageIndex + 1);
                        }
                      },
                    ),
                    const SizedBox(height: 8),
                    GestureDetector(
                      onTap: _dismissContextMenu,
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(16, 0, 16, 14),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.07),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Center(
                          child: Text(
                            'Annuler',
                            style: TextStyle(
                              color: Colors.white70,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ── Widgets de rendu ──────────────────────────────────────────────────────

  Widget _buildCover() {
    return Container(
      color: AppColors.primary,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.menu_book, size: 90, color: Colors.white),
          const SizedBox(height: 20),
          Text(
            widget.matiereName.toUpperCase(),
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 30,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '${widget.ecoleName} • ${widget.niveauName}',
            style: const TextStyle(color: Colors.white70, fontSize: 14),
          ),
          const SizedBox(height: 48),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.swipe_right_alt, color: Colors.white54, size: 20),
              SizedBox(width: 8),
              Text(
                'Glissez pour lire',
                style: TextStyle(color: Colors.white54, fontSize: 13),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPageImage(String path) {
    if (path.isEmpty || !File(path).existsSync()) {
      return _buildImageError("Image introuvable");
    }
    return InteractiveViewer(
      child: Center(
        child: Image.file(
          File(path),
          fit: BoxFit.contain,
          errorBuilder: (_, __, ___) => _buildImageError("Erreur de rendu"),
        ),
      ),
    );
  }

  Widget _buildImageError(String msg) {
    return Container(
      color: Colors.grey[900],
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.broken_image_outlined,
              color: Colors.white24,
              size: 48,
            ),
            const SizedBox(height: 12),
            Text(
              msg,
              style: const TextStyle(color: Colors.white38, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.menu_book_outlined, color: Colors.white24, size: 64),
          const SizedBox(height: 16),
          const Text(
            "Cahier vide",
            style: TextStyle(color: Colors.white70, fontSize: 18),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Retour"),
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingActions() {
    return Positioned(
      bottom: 10 + MediaQuery.of(context).padding.bottom,
      right: 20,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Bouton Scan (plus gros, en haut)
          FloatingActionButton(
            heroTag: "scan",
            backgroundColor: AppColors.primary,
            onPressed: () => Navigator.pushNamed(
              context,
              '/scan-options',
              arguments: {
                'niveauId': widget.niveauId,
                'ecoleId': widget.ecoleId,
                'matiereId': widget.matiereId,
                'matiereName': widget.matiereName,
                'niveauName': widget.niveauName,
                'ecoleName': widget.ecoleName,
              },
            ),
            child: const Icon(Icons.add_a_photo, color: Colors.white),
          ),

          const SizedBox(height: 10),

          // Bouton Flop (plus petit, en bas)
          FloatingActionButton(
            heroTag: "flop",
            backgroundColor: Colors.orange,
            mini: true, // ← Rend le bouton plus petit
            onPressed: () => _openCreateFlashcard(),
            child: const Icon(
              Icons.help_outline,
              color: Colors.white,
              size: 24,
            ),
          ),
        ],
      ),
    );
  }

  // Méthode pour ouvrir l'écran de création
  void _openCreateFlashcard() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CreateFlashcardScreen(
          leconId: "", // On peut le passer si on est dans une leçon précise
          matiereId: widget.matiereId,
          matiereName: widget.matiereName,
          niveauId: widget.niveauId,
          ecoleId: widget.ecoleId,
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Modal grille (navigation + réorganisation) — widget séparé pour éviter
// les rebuilds de setState dans le parent
// ─────────────────────────────────────────────────────────────────────────────

class _PagesGridModal extends StatelessWidget {
  final List<dynamic> pages;
  final int currentPage;
  final bool reorderMode;
  final bool isMutating;
  final void Function(int index) onNavigate;
  final Future<void> Function(int oldIndex, int newIndex)? onReorder;
  final Future<void> Function(String pageId, int pageNumber)? onDeleteInModal;

  const _PagesGridModal({
    required this.pages,
    required this.currentPage,
    required this.reorderMode,
    required this.isMutating,
    required this.onNavigate,
    this.onReorder,
    this.onDeleteInModal,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.80,
      child: Column(
        children: [
          // Handle
          Center(
            child: Container(
              margin: const EdgeInsets.only(top: 12, bottom: 8),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(
              reorderMode ? "ORGANISER" : "NAVIGUER",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
          ),
          Text(
            reorderMode
                ? "Maintenez pour déplacer"
                : "Touchez une page pour y accéder",
            style: const TextStyle(color: Colors.white38, fontSize: 12),
          ),
          const Divider(color: Colors.white10, height: 20),

          // Grille
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: reorderMode
                  ? _buildReorderGrid(context)
                  : _buildNavGrid(context),
            ),
          ),

          // Bouton valider (réorganisation)
          if (reorderMode)
            Padding(
              padding: EdgeInsets.fromLTRB(
                16,
                12,
                16,
                12 + MediaQuery.of(context).padding.bottom,
              ),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: isMutating ? null : () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: isMutating
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : const Text(
                          "Valider l'ordre",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                ),
              ),
            )
          else
            SizedBox(height: MediaQuery.of(context).padding.bottom + 12),
        ],
      ),
    );
  }

  Widget _buildReorderGrid(BuildContext context) {
    return ReorderableGridView.builder(
      itemCount: pages.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.72,
      ),
      onReorder: (oldIndex, newIndex) {
        onReorder?.call(oldIndex, newIndex);
      },
      itemBuilder: (context, index) {
        final page = pages[index];
        return _GridTile(
          key: ValueKey(page.id),
          imagePath: page.cheminImage ?? '',
          label: '${index + 1}',
          isActive: currentPage == index + 1,
          showDelete: true,
          onTap: () => onNavigate(index + 1),
          onDelete: () => onDeleteInModal?.call(page.id as String, index + 1),
        );
      },
    );
  }

  Widget _buildNavGrid(BuildContext context) {
    return GridView.builder(
      itemCount: pages.length + 1, // +1 pour la garde
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.72,
      ),
      itemBuilder: (context, index) {
        final isGarde = index == 0;
        return _GridTile(
          key: ValueKey(index),
          imagePath: isGarde ? null : (pages[index - 1].cheminImage ?? ''),
          label: isGarde ? 'G' : '$index',
          isActive: currentPage == index,
          isGarde: isGarde,
          showDelete: false,
          onTap: () => onNavigate(index),
        );
      },
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Widgets utilitaires
// ─────────────────────────────────────────────────────────────────────────────

class _GridTile extends StatelessWidget {
  final String? imagePath;
  final String label;
  final bool isActive;
  final bool isGarde;
  final bool showDelete;
  final VoidCallback onTap;
  final VoidCallback? onDelete;

  const _GridTile({
    super.key,
    required this.imagePath,
    required this.label,
    required this.isActive,
    this.isGarde = false,
    required this.showDelete,
    required this.onTap,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isActive ? AppColors.primary : Colors.transparent,
            width: 2.5,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Stack(
            fit: StackFit.expand,
            children: [
              if (isGarde)
                Container(
                  color: AppColors.primary,
                  child: const Center(
                    child: Icon(Icons.menu_book, color: Colors.white, size: 32),
                  ),
                )
              else if (imagePath != null)
                Image.file(
                  File(imagePath!),
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    color: Colors.grey[800],
                    child: const Icon(
                      Icons.broken_image,
                      color: Colors.white24,
                    ),
                  ),
                )
              else
                Container(color: Colors.grey[800]),

              // Badge numéro
              Positioned(
                bottom: 4,
                left: 4,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: isActive ? AppColors.primary : Colors.black54,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    label,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              // Bouton supprimer
              if (showDelete && onDelete != null)
                Positioned(
                  top: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: onDelete,
                    child: Container(
                      margin: const EdgeInsets.all(4),
                      padding: const EdgeInsets.all(3),
                      decoration: const BoxDecoration(
                        color: Colors.black54,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.close,
                        color: Colors.redAccent,
                        size: 16,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;

  const _NavButton({required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedOpacity(
        opacity: onTap != null ? 1.0 : 0.25,
        duration: const Duration(milliseconds: 150),
        child: Container(
          width: 40,
          height: 40,
          decoration: const BoxDecoration(
            color: Colors.black54,
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Colors.white, size: 20),
        ),
      ),
    );
  }
}

class _PageIndicator extends StatelessWidget {
  final String label;

  const _PageIndicator({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(width: 4),
          const Icon(
            Icons.keyboard_arrow_down_rounded,
            color: Colors.white54,
            size: 14,
          ),
        ],
      ),
    );
  }
}

class _ContextMenuAction extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _ContextMenuAction({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          children: [
            Icon(icon, color: color, size: 22),
            const SizedBox(width: 14),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
