import 'package:edusav/common/services/databases/database.dart';
import 'package:edusav/core/di/auth_provider.dart';
import 'package:edusav/core/di/school_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _anneeScolaireController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirm = true;
  bool _agreeTerms = false;
  bool _isLoading = false;

  // Champs scolaires
  Ecole? _selectedEcole;
  Niveau? _selectedNiveau;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _anneeScolaireController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final authState = ref.watch(authNotifierProvider);

    final ecolesAsync = ref.watch(ecolesProvider);
    final niveauxAsync = ref.watch(niveauxProvider);

    ref.listen(authNotifierProvider, (prev, next) {
      next.whenData((state) {
        if (state is AuthAuthenticated) {
          Navigator.pushReplacementNamed(context, '/home');
        }
      });
    });

    return Scaffold(
      appBar: AppBar(title: const Text('Créer un compte')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),

              // Header
              Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: colorScheme.primary.withOpacity(0.1),
                      child: Icon(
                        Icons.person_add,
                        size: 48,
                        color: colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      "Create Account",
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: colorScheme.primary,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Sign up to get started",
                      style: Theme.of(
                        context,
                      ).textTheme.bodyLarge?.copyWith(color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              // Nom complet
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Nom complet',
                  prefixIcon: const Icon(Icons.person_outline),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.grey[100],
                ),
              ),
              const SizedBox(height: 20),

              // Email
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: const Icon(Icons.email_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.grey[100],
                ),
              ),
              const SizedBox(height: 20),

              // Mot de passe + Confirmation (inchangé)
              TextField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  labelText: 'Mot de passe',
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () =>
                        setState(() => _obscurePassword = !_obscurePassword),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.grey[100],
                ),
              ),
              const SizedBox(height: 20),

              TextField(
                controller: _confirmPasswordController,
                obscureText: _obscureConfirm,
                decoration: InputDecoration(
                  labelText: 'Confirmer le mot de passe',
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureConfirm ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () =>
                        setState(() => _obscureConfirm = !_obscureConfirm),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.grey[100],
                ),
              ),

              const SizedBox(height: 32),

              // === SECTION SCOLAIRE ===
              Text(
                "Informations scolaires (facultatif)",
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 16),

              // === Recherche d'école avec Autocomplete (version mobile-friendly) ===
              ecolesAsync.when(
                data: (ecoles) => Autocomplete<Ecole>(
                  optionsBuilder: (TextEditingValue textEditingValue) {
                    if (textEditingValue.text.isEmpty) {
                      return const Iterable<Ecole>.empty();
                    }
                    return ecoles.where(
                      (ecole) => ecole.nom.toLowerCase().contains(
                        textEditingValue.text.toLowerCase(),
                      ),
                    );
                  },
                  displayStringForOption: (ecole) => ecole.nom,
                  onSelected: (Ecole ecole) {
                    setState(() {
                      _selectedEcole = ecole;
                      _selectedNiveau = null; // reset niveau quand école change
                    });
                  },
                  fieldViewBuilder:
                      (
                        BuildContext context,
                        TextEditingController fieldTextEditingController,
                        FocusNode fieldFocusNode,
                        VoidCallback onFieldSubmitted,
                      ) {
                        return TextField(
                          controller: fieldTextEditingController,
                          focusNode: fieldFocusNode,
                          decoration: InputDecoration(
                            labelText: 'École',
                            hintText: 'Rechercher une école...',
                            prefixIcon: const Icon(Icons.school_outlined),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            filled: true,
                            fillColor: Colors.grey[100],
                          ),
                          onSubmitted: (value) => onFieldSubmitted(),
                        );
                      },
                ),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (_, __) => const Text('Erreur de chargement des écoles'),
              ),

              const SizedBox(height: 16),

              // Niveau (filtré par école sélectionnée)
              DropdownButtonFormField<Niveau>(
                value: _selectedNiveau,
                decoration: InputDecoration(
                  labelText: 'Niveau',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                hint: const Text('Choisissez votre niveau'),
                items: _selectedEcole == null
                    ? null
                    : niveauxAsync.when(
                        data: (allNiveaux) {
                          final filtered = allNiveaux
                              .where((n) => n.ecoleId == _selectedEcole!.id)
                              .toList();
                          return filtered
                              .map(
                                (n) => DropdownMenuItem(
                                  value: n,
                                  child: Text(n.nomNiveau),
                                ),
                              )
                              .toList();
                        },
                        loading: () => [],
                        error: (_, __) => [],
                      ),
                onChanged: (value) => setState(() => _selectedNiveau = value),
              ),

              const SizedBox(height: 16),

              // Année scolaire
              TextField(
                controller: _anneeScolaireController,
                decoration: InputDecoration(
                  labelText: 'Année scolaire (ex: 2025-2026)',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  hintText: '2025-2026',
                ),
              ),

              const SizedBox(height: 24),

              // Conditions
              CheckboxListTile(
                value: _agreeTerms,
                onChanged: (v) => setState(() => _agreeTerms = v ?? false),
                title: const Text.rich(
                  TextSpan(
                    text: "J'accepte les ",
                    children: [
                      TextSpan(
                        text: "Conditions d'utilisation",
                        style: TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      TextSpan(text: " et la "),
                      TextSpan(
                        text: "Politique de confidentialité",
                        style: TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                ),
                controlAffinity: ListTileControlAffinity.leading,
                contentPadding: EdgeInsets.zero,
              ),

              const SizedBox(height: 32),

              // Bouton
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _handleRegister,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          'Créer mon compte',
                          style: TextStyle(fontSize: 16),
                        ),
                ),
              ),

              if (authState.hasError)
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text(
                    authState.error.toString(),
                    style: const TextStyle(color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _handleRegister() async {
    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Les mots de passe ne correspondent pas')),
      );
      return;
    }
    if (!_agreeTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Vous devez accepter les conditions")),
      );
      return;
    }

    setState(() => _isLoading = true);

    await ref
        .read(authNotifierProvider.notifier)
        .register(
          nom: _nameController.text.trim(),
          email: _emailController.text.trim(),
          password: _passwordController.text,
          ecoleId: _selectedEcole?.id,
          niveauId: _selectedNiveau?.id,
          anneeSco: _anneeScolaireController.text.trim().isNotEmpty
              ? _anneeScolaireController.text.trim()
              : null,
        );

    setState(() => _isLoading = false);
  }
}
