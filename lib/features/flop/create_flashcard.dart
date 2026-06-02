import 'package:drift/drift.dart' hide Column;
import 'package:edusav/common/services/databases/database.dart';
import 'package:edusav/core/di/current_user_provider.dart';
import 'package:edusav/core/di/flop_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:edusav/core/constants/app_colors.dart';
import 'package:uuid/uuid.dart';

class CreateFlashcardScreen extends ConsumerStatefulWidget {
  final String leconId;
  final String matiereId;
  final String? matiereName;
  final String niveauId;
  final String ecoleId;

  const CreateFlashcardScreen({
    super.key,
    required this.leconId,
    required this.matiereId,
    this.matiereName,
    required this.niveauId,
    required this.ecoleId,
  });

  @override
  ConsumerState<CreateFlashcardScreen> createState() =>
      _CreateFlashcardScreenState();
}

class _CreateFlashcardScreenState extends ConsumerState<CreateFlashcardScreen> {
  final _questionController = TextEditingController();
  final _reponseController = TextEditingController();
  final _explicationController = TextEditingController();

  // ─── Paramètres de révision ───────────────────────────────────────────────
  // 0 = heures (1–23), 1 = jours (1–6), 2 = semaines (1–52)
  int _unit = 0;
  int _unitValue = 1;

  static const List<int> _unitMaxValues = [23, 6, 52];
  static const List<String> _unitLabels = ['heure', 'jour', 'semaine'];
  static const List<int> _unitToHours = [1, 24, 168];

  double _easinessFactor = 2.5;
  bool _isSaving = false;

  // ─── Computed helpers ────────────────────────────────────────────────────

  int get _intervalHours => _unitValue * _unitToHours[_unit];

  String get _intervalLabel {
    final label = _unitLabels[_unit];
    return '$_unitValue $label${_unitValue > 1 ? 's' : ''}';
  }

  String get _intervalHint {
    switch (_unit) {
      case 0:
        return 'Revue dans $_unitValue h (soit $_intervalHours heure${_intervalHours > 1 ? 's' : ''})';
      case 1:
        return 'Revue dans $_unitValue jour${_unitValue > 1 ? 's' : ''} (${_intervalHours}h)';
      case 2:
        return 'Revue dans $_unitValue semaine${_unitValue > 1 ? 's' : ''} (${_unitValue * 7} jours, ${_intervalHours}h)';
      default:
        return '';
    }
  }

  String get _unitTransitionHint {
    if (_unit < 2 && _unitValue == _unitMaxValues[_unit]) {
      return '→ Encore + pour passer en ${_unitLabels[_unit + 1]}s';
    }
    if (_unit > 0 && _unitValue == 1) {
      return '→ Encore − pour revenir aux ${_unitLabels[_unit - 1]}s';
    }
    return '';
  }

  // ─── Contrôle de l'unité via SegmentedButton ─────────────────────────────

  void _changeUnit(int newUnit) {
    setState(() {
      _unit = newUnit;
      _unitValue = 1;
    });
  }

  // ─── Contrôle de l'intervalle ────────────────────────────────────────────

  void _increment() {
    setState(() {
      if (_unitValue < _unitMaxValues[_unit]) {
        _unitValue++;
      } else if (_unit < 2) {
        _unit++;
        _unitValue = 1;
      }
    });
  }

  void _decrement() {
    setState(() {
      if (_unitValue > 1) {
        _unitValue--;
      } else if (_unit > 0) {
        _unit--;
        _unitValue = _unitMaxValues[_unit];
      }
    });
  }

  bool get _canDecrement => !(_unit == 0 && _unitValue == 1);
  bool get _canIncrement => !(_unit == 2 && _unitValue == _unitMaxValues[2]);

  // ─── Enregistrement ──────────────────────────────────────────────────────

  Future<void> _saveFlashcard() async {
    final question = _questionController.text.trim();
    final reponse = _reponseController.text.trim();

    if (question.isEmpty || reponse.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Question et réponse sont obligatoires")),
      );
      return;
    }

    final currentUser = ref.read(currentUserProvider);
    if (currentUser == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Utilisateur non connecté")));
      return;
    }

    setState(() => _isSaving = true);

    try {
      final flashcardDao = ref.read(flashcardDaoProvider);
      final nextReview = DateTime.now().add(Duration(hours: _intervalHours));

      await flashcardDao.insertFlashcard(
        FlashcardsCompanion.insert(
          id: const Uuid().v4(),
          leconId: Value(widget.leconId.isEmpty ? null : widget.leconId),
          matiereId: widget.matiereId,
          niveauId: Value(widget.niveauId),
          ecoleId: Value(widget.ecoleId),
          userId: currentUser.id,
          question: question,
          reponse: reponse,
          explication: Value(
            _explicationController.text.trim().isEmpty
                ? null
                : _explicationController.text.trim(),
          ),
          intervalDays: Value((_intervalHours / 24).ceil()),
          repetitions: const Value(0),
          easinessFactor: Value(_easinessFactor),
          nextReviewDate: nextReview.millisecondsSinceEpoch,
        ),
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Flashcard créée avec succès !'),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur : $e'), backgroundColor: Colors.red),
      );
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  void dispose() {
    _questionController.dispose();
    _reponseController.dispose();
    _explicationController.dispose();
    super.dispose();
  }

  // ─── Build ───────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nouvelle Flashcard"),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),

      // ── Bouton toujours visible, jamais caché par le scroll ──
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
          child: SizedBox(
            height: 56,
            child: ElevatedButton(
              onPressed: _isSaving ? null : _saveFlashcard,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                disabledBackgroundColor: AppColors.primary.withOpacity(0.6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: _isSaving
                  ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2.5,
                      ),
                    )
                  : const Text(
                      "Enregistrer la Flashcard",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
            ),
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Matière ──────────────────────────────────────────────────
            if (widget.matiereName != null) ...[
              Text(
                "Matière : ${widget.matiereName}",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 24),
            ],

            // ── Question ─────────────────────────────────────────────────
            const Text(
              "Question",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _questionController,
              maxLines: 3,
              decoration: const InputDecoration(
                hintText: "Écrivez votre question ici...",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            // ── Réponse ──────────────────────────────────────────────────
            const Text(
              "Réponse",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _reponseController,
              maxLines: 4,
              decoration: const InputDecoration(
                hintText: "Écrivez la réponse ici...",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            // ── Explication ──────────────────────────────────────────────
            const Text(
              "Explication (optionnel)",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _explicationController,
              maxLines: 3,
              decoration: const InputDecoration(
                hintText: "Ajoutez une explication...",
                border: OutlineInputBorder(),
              ),
            ),

            const Divider(height: 40),

            // ── Paramètres de révision ───────────────────────────────────
            const Text(
              "Paramètres de révision",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // ── Intervalle intelligent ───────────────────────────────────
            _IntervalTile(
              unit: _unit,
              label: _intervalLabel,
              hint: _intervalHint,
              transitionHint: _unitTransitionHint,
              value: _unitValue,
              canDecrement: _canDecrement,
              canIncrement: _canIncrement,
              onUnitChanged: _changeUnit,
              onDecrement: _decrement,
              onIncrement: _increment,
            ),

            // ── Facilité ─────────────────────────────────────────────────
            ListTile(
              title: const Text("Niveau de facilité initial"),
              subtitle: Text(_easinessFactor.toStringAsFixed(1)),
              trailing: SizedBox(
                width: 160,
                child: Slider(
                  value: _easinessFactor,
                  min: 1.3,
                  max: 2.5,
                  divisions: 12,
                  label: _easinessFactor.toStringAsFixed(1),
                  onChanged: (value) => setState(() => _easinessFactor = value),
                ),
              ),
            ),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Widget sélecteur d'intervalle avec SegmentedButton
// ─────────────────────────────────────────────────────────────────────────────

class _IntervalTile extends StatelessWidget {
  final int unit;
  final String label;
  final String hint;
  final String transitionHint;
  final int value;
  final bool canDecrement;
  final bool canIncrement;
  final ValueChanged<int> onUnitChanged;
  final VoidCallback onDecrement;
  final VoidCallback onIncrement;

  const _IntervalTile({
    required this.unit,
    required this.label,
    required this.hint,
    required this.transitionHint,
    required this.value,
    required this.canDecrement,
    required this.canIncrement,
    required this.onUnitChanged,
    required this.onDecrement,
    required this.onIncrement,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Titre ────────────────────────────────────────────────────
          Text("Première apparition dans", style: theme.textTheme.bodyLarge),
          const SizedBox(height: 12),

          // ── Sélecteur d'unité : H / J / S ────────────────────────────
          SegmentedButton<int>(
            segments: const [
              ButtonSegment<int>(
                value: 0,
                label: Text('Heures'),
                icon: Icon(Icons.schedule, size: 16),
              ),
              ButtonSegment<int>(
                value: 1,
                label: Text('Jours'),
                icon: Icon(Icons.today, size: 16),
              ),
              ButtonSegment<int>(
                value: 2,
                label: Text('Semaines'),
                icon: Icon(Icons.date_range, size: 16),
              ),
            ],
            selected: {unit},
            onSelectionChanged: (selected) => onUnitChanged(selected.first),
            style: ButtonStyle(
              visualDensity: VisualDensity.compact,
              textStyle: WidgetStateProperty.all(const TextStyle(fontSize: 13)),
            ),
          ),

          const SizedBox(height: 16),

          // ── Compteur + libellé ────────────────────────────────────────
          Row(
            children: [
              // Bouton −
              _CounterButton(
                icon: Icons.remove,
                enabled: canDecrement,
                onTap: onDecrement,
              ),
              const SizedBox(width: 12),

              // Valeur + unité
              Expanded(
                child: Text(
                  label,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              // Bouton +
              _CounterButton(
                icon: Icons.add,
                enabled: canIncrement,
                onTap: onIncrement,
              ),
            ],
          ),

          const SizedBox(height: 6),

          // ── Hint principal ────────────────────────────────────────────
          Text(
            hint,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.55),
            ),
          ),

          // ── Hint de transition d'unité ────────────────────────────────
          if (transitionHint.isNotEmpty) ...[
            const SizedBox(height: 2),
            Text(
              transitionHint,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.primary.withOpacity(0.75),
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Bouton compteur −/+
// ─────────────────────────────────────────────────────────────────────────────

class _CounterButton extends StatelessWidget {
  final IconData icon;
  final bool enabled;
  final VoidCallback onTap;

  const _CounterButton({
    required this.icon,
    required this.enabled,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: enabled ? onTap : null,
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            border: Border.all(
              color: enabled
                  ? Theme.of(context).colorScheme.outline
                  : Theme.of(context).colorScheme.outline.withOpacity(0.3),
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            size: 20,
            color: enabled
                ? Theme.of(context).colorScheme.onSurface
                : Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
          ),
        ),
      ),
    );
  }
}
