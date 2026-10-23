import 'package:edusav/common/services/databases/database.dart';
import 'package:edusav/features/auth/presentation/auth_controller.dart';
import 'package:edusav/core/di/role_provider.dart';
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

  Role? _selectedRole;
  Ecole? _selectedEcole;
  Niveau? _selectedNiveau;
  List<Ecole> _selectedEcoles = [];

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
    final authState = ref.watch(authControllerProvider);
    final rolesAsync = ref.watch(rolesProvider);
    final ecolesAsync = ref.watch(ecolesProvider);
    final niveauxAsync = ref.watch(niveauxProvider);

    ref.listen(authControllerProvider, (prev, next) {
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

              // Header (identique à avant)
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

              // === CHOIX DU RÔLE ===
              const Text(
                "Je suis un(e) :",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 12),

              rolesAsync.when(
                data: (roles) => Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: roles.map((role) => _buildRoleChip(role)).toList(),
                ),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (_, __) => const Text("Erreur de chargement des rôles"),
              ),

              const SizedBox(height: 32),

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

              // Mot de passe
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

              // Confirmation mot de passe
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
              if (_selectedRole != null)
                Text(
                  _selectedRole!.nomRole.toUpperCase() == 'ELEVE'
                      ? "Informations scolaires (facultatif)"
                      : "Assignation aux écoles",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),

              const SizedBox(height: 16),

              if (_selectedRole != null)
                _buildSchoolSection(ecolesAsync, niveauxAsync),

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

  Widget _buildRoleChip(Role role) {
    final isSelected = _selectedRole?.id == role.id;
    return ChoiceChip(
      label: Text(role.nomRole),
      selected: isSelected,
      onSelected: (selected) {
        setState(() {
          _selectedRole = selected ? role : null;
          _selectedEcole = null;
          _selectedNiveau = null;
          _selectedEcoles.clear();
        });
      },
    );
  }

  Widget _buildSchoolSection(
    AsyncValue<List<Ecole>> ecolesAsync,
    AsyncValue<List<Niveau>> niveauxAsync,
  ) {
    if (_selectedRole!.nomRole.toUpperCase() == 'ELEVE') {
      return _buildEleveSchoolSection(ecolesAsync, niveauxAsync);
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ecolesAsync.when(
            data: (ecoles) => Wrap(
              spacing: 8,
              children: ecoles.map((ecole) {
                final selected = _selectedEcoles.any((e) => e.id == ecole.id);
                return FilterChip(
                  label: Text(ecole.nom),
                  selected: selected,
                  onSelected: (sel) {
                    setState(() {
                      if (sel) {
                        _selectedEcoles.add(ecole);
                      } else {
                        _selectedEcoles.removeWhere((e) => e.id == ecole.id);
                      }
                    });
                  },
                );
              }).toList(),
            ),
            loading: () => const CircularProgressIndicator(),
            error: (_, __) => const Text('Erreur de chargement'),
          ),
        ],
      );
    }
  }

  Widget _buildEleveSchoolSection(
    AsyncValue<List<Ecole>> ecolesAsync,
    AsyncValue<List<Niveau>> niveauxAsync,
  ) {
    return Column(
      children: [
        ecolesAsync.when(
          data: (ecoles) => Autocomplete<Ecole>(
            optionsBuilder: (TextEditingValue textEditingValue) {
              if (textEditingValue.text.isEmpty)
                return const Iterable<Ecole>.empty();
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
                _selectedNiveau = null;
              });
            },
            fieldViewBuilder:
                (
                  context,
                  fieldTextEditingController,
                  fieldFocusNode,
                  onFieldSubmitted,
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
        DropdownButtonFormField<Niveau>(
          value: _selectedNiveau,
          decoration: InputDecoration(
            labelText: 'Niveau',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
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
        TextField(
          controller: _anneeScolaireController,
          decoration: InputDecoration(
            labelText: 'Année scolaire (ex: 2025-2026)',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            hintText: '2025-2026',
          ),
        ),
      ],
    );
  }

  Future<void> _handleRegister() async {
    if (_selectedRole == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Veuillez choisir un rôle')));
      return;
    }
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

    final notifier = ref.read(authControllerProvider.notifier);

    if (_selectedRole!.nomRole.toUpperCase() == 'ELEVE') {
      await notifier.registerEleve(
        nom: _nameController.text.trim(),
        email: _emailController.text.trim(),
        password: _passwordController.text,
        roleId: _selectedRole!.id,
        ecoleId: _selectedEcole?.id,
        niveauId: _selectedNiveau?.id,
        anneeSco: _anneeScolaireController.text.trim().isNotEmpty
            ? _anneeScolaireController.text.trim()
            : null,
      );
    } else {
      await notifier.registerStaff(
        nom: _nameController.text.trim(),
        email: _emailController.text.trim(),
        password: _passwordController.text,
        roleId: _selectedRole!.id,
        ecoleIds: _selectedEcoles.map((e) => e.id).toList(),
      );
    }

    setState(() => _isLoading = false);
  }
}
