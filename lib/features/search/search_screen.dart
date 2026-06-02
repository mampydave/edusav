// lib/features/search/search_screen.dart
import 'package:edusav/common/services/databases/database.dart';
import 'package:edusav/core/di/search_provider.dart';
import 'package:edusav/features/subjects/lesson_cahier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:edusav/core/constants/app_colors.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  String? _selectedNiveauId;
  String? _selectedEcoleId;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() => _searchQuery = _searchController.text.trim());
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _selectNiveau(String niveauId, String ecoleId) {
    setState(() {
      _selectedNiveauId = niveauId;
      _selectedEcoleId = ecoleId;
      _searchController.clear();
      _searchQuery = '';
    });
  }

  void _selectMatiere(String matiereId, String matiereName) {
    if (_selectedNiveauId == null || _selectedEcoleId == null) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => LessonCahierScreen(
          matiereId: matiereId,
          matiereName: matiereName,
          ecoleId: _selectedEcoleId!,
          ecoleName: "",
          niveauId: _selectedNiveauId!,
          niveauName: "",
        ),
      ),
    );
  }

  void _clearFilters() {
    setState(() {
      _selectedNiveauId = null;
      _selectedEcoleId = null;
      _searchQuery = '';
      _searchController.clear();
    });
  }

  static const List<Color> _niveauColors = [
    Color(0xFF4A90D9),
    Color(0xFF5B8DEF),
    Color(0xFF7C6FCD),
    Color(0xFF4BAE8A),
    Color(0xFFE8834E),
    Color(0xFFD95F6E),
    Color(0xFF49AABF),
    Color(0xFF8B6FBF),
  ];

  static const List<IconData> _niveauIcons = [
    Icons.school,
    Icons.menu_book,
    Icons.auto_stories,
    Icons.science,
    Icons.calculate,
    Icons.psychology,
    Icons.history_edu,
    Icons.biotech,
  ];

  Color _getColor(int index) => _niveauColors[index % _niveauColors.length];
  IconData _getIcon(int index) => _niveauIcons[index % _niveauIcons.length];

  @override
  Widget build(BuildContext context) {
    final niveauxAsync = ref.watch(userNiveauxWithContextProvider);

    // ✅ ref.watch() dans build() avec NiveauEcoleParams
    final matieresAsync =
        (_selectedNiveauId != null && _selectedEcoleId != null)
        ? ref.watch(
            matieresByNiveauAndEcoleProvider(
              NiveauEcoleParams(
                niveauId: _selectedNiveauId!,
                ecoleId: _selectedEcoleId!,
              ),
            ),
          )
        : null;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: RefreshIndicator(
        onRefresh: () async {
          ref.refresh(userNiveauxWithContextProvider);
        },
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            // ==================== HEADER ====================
            SliverToBoxAdapter(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(24, 56, 24, 32),
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(32),
                    bottomRight: Radius.circular(32),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Bibliothèque",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      "Trouvez vos leçons rapidement",
                      style: TextStyle(color: Colors.white70, fontSize: 15),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: _searchController,
                      style: const TextStyle(color: Colors.black87),
                      decoration: InputDecoration(
                        hintText: _selectedNiveauId == null
                            ? "Rechercher leçons, sujets..."
                            : "Rechercher dans ce niveau...",
                        hintStyle: const TextStyle(color: Colors.grey),
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.grey,
                        ),
                        suffixIcon: _searchQuery.isNotEmpty
                            ? IconButton(
                                icon: const Icon(
                                  Icons.clear,
                                  color: Colors.grey,
                                ),
                                onPressed: _searchController.clear,
                              )
                            : null,
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // ==================== CONTENU ====================
            SliverToBoxAdapter(
              child: _buildDynamicContent(niveauxAsync, matieresAsync),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDynamicContent(
    AsyncValue<List<UserNiveauContext>> niveauxAsync,
    AsyncValue<List<Matiere>>? matieresAsync,
  ) {
    if (_searchQuery.isNotEmpty) return _buildSearchResults();

    if (_selectedNiveauId != null && matieresAsync != null) {
      return _buildMatieresOfNiveau(matieresAsync);
    }

    return _buildNiveauxGrid(niveauxAsync);
  }

  // ==================== GRILLE NIVEAUX (nouveau style) ====================
  Widget _buildNiveauxGrid(AsyncValue<List<UserNiveauContext>> niveauxAsync) {
    return niveauxAsync.when(
      data: (niveaux) {
        if (niveaux.isEmpty) {
          return const Padding(
            padding: EdgeInsets.all(60),
            child: Center(
              child: Column(
                children: [
                  Icon(Icons.school_outlined, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    "Aucun niveau trouvé",
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                ],
              ),
            ),
          );
        }

        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 28, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Sélectionnez votre niveau",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 16),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1.0,
                ),
                itemCount: niveaux.length,
                itemBuilder: (context, index) {
                  return _buildNiveauCard(niveaux[index], index);
                },
              ),
            ],
          ),
        );
      },
      loading: () => const Padding(
        padding: EdgeInsets.all(60),
        child: Center(child: CircularProgressIndicator()),
      ),
      error: (_, __) => const Padding(
        padding: EdgeInsets.all(40),
        child: Center(child: Text("Erreur de chargement des niveaux")),
      ),
    );
  }

  // ==================== CARTE NIVEAU ====================
  Widget _buildNiveauCard(UserNiveauContext ctx, int index) {
    final color = _getColor(index);
    final icon = _getIcon(index);

    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      elevation: 2,
      shadowColor: Colors.black12,
      child: InkWell(
        onTap: () => _selectNiveau(ctx.niveauId, ctx.ecoleId),
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(icon, color: Colors.white, size: 28),
              ),
              const Spacer(),
              Text(
                ctx.niveauName,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                ctx.ecoleName,
                style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ==================== MATIÈRES (ancien style conservé) ====================
  Widget _buildMatieresOfNiveau(AsyncValue<List<Matiere>> matieresAsync) {
    return matieresAsync.when(
      data: (matieres) {
        if (matieres.isEmpty) {
          return Padding(
            padding: const EdgeInsets.all(40),
            child: Column(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new),
                  onPressed: _clearFilters,
                ),
                const SizedBox(height: 20),
                const Icon(Icons.inbox_outlined, size: 64, color: Colors.grey),
                const SizedBox(height: 16),
                const Text(
                  "Aucune matière pour ce niveau",
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),
              ],
            ),
          );
        }

        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: _clearFilters,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                        size: 18,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  const Text(
                    "Matières du niveau",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: matieres.length,
                itemBuilder: (context, index) {
                  return _buildMatiereCard(matieres[index]);
                },
              ),
            ],
          ),
        );
      },
      loading: () => const Padding(
        padding: EdgeInsets.all(60),
        child: Center(child: CircularProgressIndicator()),
      ),
      error: (e, _) => Padding(
        padding: const EdgeInsets.all(40),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.error_outline, color: Colors.red, size: 48),
              const SizedBox(height: 12),
              Text("Erreur : $e", textAlign: TextAlign.center),
              const SizedBox(height: 12),
              TextButton.icon(
                onPressed: _clearFilters,
                icon: const Icon(Icons.arrow_back),
                label: const Text("Retour"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ==================== CARTE MATIÈRE ====================
  Widget _buildMatiereCard(Matiere matiere) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: () => _selectMatiere(matiere.id, matiere.nom),
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
                      matiere.nom,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Progression"),
                  Text("45%", style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: const LinearProgressIndicator(
                  value: 0.45,
                  minHeight: 10,
                  backgroundColor: Color.fromARGB(255, 237, 236, 236),
                  valueColor: AlwaysStoppedAnimation(AppColors.primary),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ==================== RECHERCHE ====================
  Widget _buildSearchResults() {
    return const Padding(
      padding: EdgeInsets.all(60),
      child: Center(
        child: Text(
          "Recherche en cours...\n(à implémenter)",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey),
        ),
      ),
    );
  }
}
