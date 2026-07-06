import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:drift/drift.dart';
import 'package:edusav/common/services/database_services.dart';
import 'package:edusav/common/services/databases/database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

class SeedService {
  final DatabaseService _db;

  SeedService(this._db);

  Future<void> initializeRoles() async {
    final existingRoles = await _db.roles.getAll();

    if (existingRoles.isNotEmpty) {
      return; // Les rôles existent déjà
    }

    final uuid = const Uuid();

    final defaultRoles = [
      {'id': uuid.v4(), 'nom_role': 'ELEVE', 'description': 'Élève'},
      {'id': uuid.v4(), 'nom_role': 'PROFESSEUR', 'description': 'Professeur'},
      {
        'id': uuid.v4(),
        'nom_role': 'DIRECTEUR',
        'description': 'Directeur d\'école',
      },
      {
        'id': uuid.v4(),
        'nom_role': 'ADMIN',
        'description': 'Administrateur système',
      },
    ];

    for (final role in defaultRoles) {
      await _db.roles.insert(
        RolesCompanion.insert(
          id: role['id'] as String,
          nomRole: role['nom_role'] as String,
          description: Value(role['description'] as String),
        ),
      );
    }
  }

  Future<void> initializeAdminUser() async {
    final List<Utilisateur> existingAdmins = await _db.utilisateurs
        .getByRoleName('ADMIN');

    if (existingAdmins.isNotEmpty) {
      return; // L'utilisateur admin existe déjà
    }

    final uuid = const Uuid();

    await _db.utilisateurs.insert(
      UtilisateursCompanion.insert(
        id: uuid.v4(),
        nom: 'Admin',
        prenom: Value('System'),
        email: 'admin@edusav.mg',
        mdp: sha256.convert(utf8.encode('admin123')).toString(),
        roleId: Value(await _db.roles.getRoleIdByName('ADMIN')),
        dateCrea: DateTime.now().millisecondsSinceEpoch,
      ),
    );
  }
}

// Provider
final seedServiceProvider = Provider<SeedService>((ref) {
  final db = ref.watch(databaseServiceProvider);
  return SeedService(db);
});
