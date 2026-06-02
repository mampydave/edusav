import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:drift/drift.dart' hide Column;
import 'package:edusav/common/services/databases/database.dart';
import 'package:edusav/core/di/current_user_provider.dart';
import 'package:edusav/core/di/matiere_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:edusav/common/services/database_services.dart';

class DebugDbScreen extends ConsumerWidget {
  const DebugDbScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dbService = ref.watch(databaseServiceProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Debug DB')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                final uuid = const Uuid().v4();
                await dbService.lecons.insert(
                  LeconsCompanion.insert(
                    id: uuid,
                    titre: 'Leçon test ${DateTime.now()}',
                    auteurId: Value('user-test-001'),
                    matiereId: Value(null),
                    visibilite: Value('PRIVE'),
                    dateUpd: DateTime.now().millisecondsSinceEpoch,
                  ),
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Leçon insérée : $uuid')),
                );
              },
              child: const Text('Insérer une leçon test'),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () async {
                final lecons = await dbService.lecons.getAll();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Leçons trouvées : ${lecons.length}')),
                );
                print(lecons);
              },
              child: const Text('Lire toutes les leçons'),
            ),
            ElevatedButton(
              onPressed: () async {
                final dbService = ref.read(databaseServiceProvider);

                final existing = await dbService.utilisateurs.getByEmail(
                  'test@edusav.mg',
                );
                if (existing != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Utilisateur test existe déjà'),
                    ),
                  );
                  return;
                }

                final id = const Uuid().v4();
                final hash = sha256
                    .convert(utf8.encode('password123'))
                    .toString(); // mot de passe simple pour test

                await dbService.utilisateurs.insert(
                  UtilisateursCompanion.insert(
                    id: id,
                    nom: 'Test',
                    prenom: Value('Étudiant'),
                    email: 'test@edusav.mg',
                    mdp: hash,
                    dateCrea: DateTime.now().millisecondsSinceEpoch,
                  ),
                );

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Utilisateur test créé !\nEmail: test@edusav.mg\nMDP: password123',
                    ),
                  ),
                );
              },
              child: const Text('Créer utilisateur TEST'),
            ),
            ElevatedButton(
              onPressed: () async {
                final dbService = ref.read(databaseServiceProvider);
                final users = await dbService.utilisateurs.getAll();

                print('Utilisateurs trouvés : ${users.length}');
                for (var u in users) {
                  print(' - ${u.nom} (${u.email})');
                }

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${users.length} utilisateur(s) trouvé(s)'),
                  ),
                );
              },
              child: const Text('Lister utilisateurs'),
            ),

            // Bouton pour creer 3 ecoles + niveaux
            ElevatedButton(
              onPressed: () async {
                final dbService = ref.read(databaseServiceProvider);

                // Créer 3 écoles
                for (int i = 1; i <= 3; i++) {
                  final ecoleId = const Uuid().v4();
                  await dbService.ecoles.insert(
                    EcolesCompanion.insert(
                      id: ecoleId,
                      nom: 'École $i',
                      ville: Value('Ville $i'),
                      dateCrea: DateTime.now().millisecondsSinceEpoch,
                    ),
                  );

                  // Créer 2 niveaux pour chaque école
                  for (int j = 1; j <= 2; j++) {
                    await dbService.niveaux.insert(
                      NiveauxCompanion.insert(
                        id: const Uuid().v4(),
                        nomNiveau: 'Niveau $j',
                        ecoleId: ecoleId,
                      ),
                    );
                  }
                }

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('3 écoles et leurs niveaux créés'),
                  ),
                );
              },
              child: const Text('Créer 3 écoles + niveaux'),
            ),

            const SizedBox(height: 24),
            // bouton pour creer matiere (physique, chimie, maths, philosophie, etc)
            ElevatedButton(
              onPressed: () async {
                final dbService = ref.read(databaseServiceProvider);

                final matieres = [
                  'Mathématiques',
                  'Physique',
                  'Chimie',
                  'Biologie',
                  'Histoire',
                  'Géographie',
                  'Philosophie',
                ];

                for (var nom in matieres) {
                  await dbService.matieres.insert(
                    MatieresCompanion.insert(id: const Uuid().v4(), nom: nom),
                  );
                }

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Matières créées')),
                );
              },
              child: const Text('Créer matières de base'),
            ),

            // Bouton pour créer des curriculums (liens entre écoles avec id = a006b64c-6fad-4b63-a870-229498e9ea0f, niveaux avec id = 6bbf481b-7d1c-46e4-8199-e532ab41a7a4 et matières id [31ad1e97-1dfd-4c98-b5b9-86389f9d420f, 679be5f5-bac7-41c7-a7cc-afd73812c3e7, 160dd531-05d3-4f27-b83a-32eb622ecfbf])
            ElevatedButton(
              onPressed: () async {
                final dbService = ref.read(databaseServiceProvider);
                final matiere = dbService.matieres.getAll();
                for (var m in await matiere) {
                  print('Matière : ${m.nom} (${m.id})');
                }

                final ecoleId = '0446f278-9655-4ef5-a810-998524c77ecf';
                final niveauId = '14e0589d-e453-4bf8-b71f-696f89130f2d';
                final matiereIds = [
                  '99164c84-6b36-49f7-8bd2-04d9ea6a066a',
                  'f776008b-3f5a-4e90-9466-008f4034ef66',
                  '873aca6d-459a-4dd2-b48a-3166aee030dd',
                ];

                for (var matiereId in matiereIds) {
                  await dbService.curriculums.insert(
                    CurriculumsCompanion.insert(
                      id: const Uuid().v4(),
                      ecoleId: ecoleId,
                      niveauId: niveauId,
                      matiereId: matiereId,
                    ),
                  );
                }

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Curriculums créés')),
                );
              },
              child: const Text('Créer curriculums pour une école/niveau'),
            ),

            // boutton pour tester le provider userCurrentSubjectsProvider
            ElevatedButton(
              onPressed: () async {
                final subjects = await ref.read(
                  userCurrentSubjectsProvider.future,
                );
                print(
                  'Matières de l\'utilisateur : ${subjects.map((s) => s.nom).join(', ')}',
                );

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Matières de l\'utilisateur : ${subjects.map((s) => s.nom).join(', ')}',
                    ),
                  ),
                );
              },
              child: const Text('Tester provider userCurrentSubjectsProvider'),
            ),

            const SizedBox(height: 24),

            // Boutton pour  creer curriculums en recuperant ecoleId et niveauId de l'utilisateur connecté (dans appartenance active) et matiere toute matiere de la base avec getAll
            ElevatedButton(
              onPressed: () async {
                final dbService = ref.read(databaseServiceProvider);
                final user = ref.read(currentUserProvider);
                if (user == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Aucun utilisateur connecté')),
                  );
                  return;
                }

                final appartenances = await dbService.appartenances.getByUser(
                  user.id,
                );

                if (appartenances.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Aucune appartenance trouvée'),
                    ),
                  );
                  return;
                }

                final appartenance = appartenances.first;
                final ecoleId = appartenance.ecoleId;
                final niveauId = appartenance.niveauId;

                final matieres = await dbService.matieres.getAll();

                for (var matiere in matieres) {
                  await dbService.curriculums.insert(
                    CurriculumsCompanion.insert(
                      id: const Uuid().v4(),
                      ecoleId: ecoleId,
                      niveauId: niveauId ?? '',
                      matiereId: matiere.id,
                    ),
                  );
                }

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Curriculums créés pour user')),
                );
              },
              child: const Text('Créer curriculums pour user connecté'),
            ),
            // liste ecole et niveau dans la base pour vérifier les données
            ElevatedButton(
              onPressed: () async {
                final dbService = ref.read(databaseServiceProvider);
                final ecoles = await dbService.ecoles.getAll();
                print('Écoles trouvées : ${ecoles.length}');
                for (var e in ecoles) {
                  print(' - ${e.nom} (${e.ville})');
                  final niveaux = await dbService.niveaux.getByEcole(e.id);
                  print('   Niveaux : ${niveaux.length}');
                  for (var n in niveaux) {
                    print('     - ${n.nomNiveau}');
                  }
                }

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${ecoles.length} école(s) trouvée(s)'),
                  ),
                );
              },
              child: const Text('Lister écoles + niveaux'),
            ),
          ],
        ),
      ),
    );
  }
}
