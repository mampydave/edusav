import 'package:drift/drift.dart';
import 'package:edusav/common/services/database_services.dart';
import 'package:edusav/common/services/databases/database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

import 'package:uuid/uuid.dart';

const _storage = FlutterSecureStorage();
const _currentUserKey = 'edusav_current_user_id';
const _authTokenKey = 'edusav_auth_token'; // pour "rester connecté"

// État auth
sealed class AuthState {
  const AuthState();
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

class AuthLoading extends AuthState {
  const AuthLoading();
}

class AuthAuthenticated extends AuthState {
  final Utilisateur user;
  const AuthAuthenticated(this.user);
}

class AuthUnauthenticated extends AuthState {
  const AuthUnauthenticated();
}

class AuthError extends AuthState {
  final String message;
  const AuthError(this.message);
}

// Notifier
class AuthNotifier extends AsyncNotifier<AuthState> {
  @override
  Future<AuthState> build() async {
    return const AuthLoading();
  }

  Future<void> checkCurrentUser() async {
    state = const AsyncLoading();
    try {
      final userId = await _storage.read(key: _currentUserKey);
      if (userId == null) {
        state = const AsyncData(AuthUnauthenticated());
        return;
      }

      final db = ref.read(databaseServiceProvider);
      final user = await db.utilisateurs.getById(userId);

      if (user == null || user.dateDel != null) {
        await logout();
        return;
      }

      state = AsyncData(AuthAuthenticated(user));
    } catch (e) {
      state = AsyncData(AuthError(e.toString()));
    }
  }

  Future<void> login(String email, String password) async {
    state = const AsyncLoading();
    try {
      final db = ref.read(databaseServiceProvider);
      final user = await db.utilisateurs.getByEmail(email);

      if (user == null) {
        // state = AsyncData(AuthError('Utilisateur non trouvé'));
        state = AsyncError('Utilisateur non trouvé', StackTrace.current);
        return;
      }

      final inputHash = sha256.convert(utf8.encode(password)).toString();
      if (inputHash != user.mdp) {
        // state = AsyncData(AuthError('Mot de passe incorrect'));
        state = AsyncError('Mot de passe incorrect', StackTrace.current);
        return;
      }

      // Succès : stocke session
      await _storage.write(key: _currentUserKey, value: user.id);
      // Optionnel : token factice pour "session"
      await _storage.write(
        key: _authTokenKey,
        value: 'offline_session_${user.id}',
      );

      state = AsyncData(AuthAuthenticated(user));
    } catch (e, st) {
      // state = AsyncData(AuthError('Erreur connexion : $e'));
      state = AsyncError('Erreur connexion : $e', st);
    }
  }

  Future<void> registerEleve({
    required String nom,
    required String email,
    required String password,
    required String roleId,
    String? ecoleId,
    String? niveauId,
    String? anneeSco,
  }) async {
    state = const AsyncLoading();
    try {
      final db = ref.read(databaseServiceProvider);
      final uuid = const Uuid();

      final existing = await db.utilisateurs.getByEmail(email);
      if (existing != null) {
        state = AsyncError('Cet email est déjà utilisé', StackTrace.current);
        return;
      }

      final userId = uuid.v4();
      final passwordHash = sha256.convert(utf8.encode(password)).toString();

      await db.utilisateurs.insert(
        UtilisateursCompanion.insert(
          id: userId,
          nom: nom.trim(),
          email: email.trim().toLowerCase(),
          mdp: passwordHash,
          roleId: Value(roleId),
          dateCrea: DateTime.now().millisecondsSinceEpoch,
        ),
      );

      if (ecoleId != null && anneeSco != null && anneeSco.isNotEmpty) {
        await db.appartenances.insert(
          AppartenancesCompanion.insert(
            id: uuid.v4(),
            userId: userId,
            ecoleId: ecoleId,
            niveauId: Value(niveauId),
            anneeSco: anneeSco.trim(),
            estActif: const Value(true),
            dateMiseAJour: DateTime.now().millisecondsSinceEpoch,
          ),
        );
      }

      await _storage.write(key: _currentUserKey, value: userId);
      final newUser = await db.utilisateurs.getById(userId);
      if (newUser != null) {
        state = AsyncData(AuthAuthenticated(newUser));
      }
    } catch (e, st) {
      state = AsyncError('Erreur inscription élève : $e', st);
    }
  }

  Future<void> registerStaff({
    required String nom,
    required String email,
    required String password,
    required String roleId,
    required List<String> ecoleIds,
  }) async {
    state = const AsyncLoading();
    try {
      final db = ref.read(databaseServiceProvider);
      final uuid = const Uuid();

      final existing = await db.utilisateurs.getByEmail(email);
      if (existing != null) {
        state = AsyncError('Cet email est déjà utilisé', StackTrace.current);
        return;
      }

      final userId = uuid.v4();
      final passwordHash = sha256.convert(utf8.encode(password)).toString();

      // 1. Créer l'utilisateur (inactif pour les rôles sensibles)
      await db.utilisateurs.insert(
        UtilisateursCompanion.insert(
          id: userId,
          nom: nom.trim(),
          email: email.trim().toLowerCase(),
          mdp: passwordHash,
          roleId: Value(roleId),
          dateCrea: DateTime.now().millisecondsSinceEpoch,
        ),
      );

      // 2. Créer les assignations en statut PENDING
      for (final ecoleId in ecoleIds) {
        await db.assignationsEcole.insertAssignation(
          AssignationsEcoleCompanion.insert(
            id: uuid.v4(),
            userId: userId,
            ecoleId: ecoleId,
            roleId: roleId,
            dateDebut: DateTime.now(),
            estActif: const Value(false), // Inactif jusqu'à validation
            statut: const Value('PENDING'),
          ),
        );
      }

      // 3. Ne PAS connecter automatiquement
      state = AsyncData(
        AuthUnauthenticated(),
      ); // ou un état "Compte créé en attente"

      // Message de succès
      // Tu peux afficher un message via un listener dans le screen
    } catch (e, st) {
      state = AsyncError('Erreur inscription staff : $e', st);
    }
  }

  Future<void> logout() async {
    await _storage.delete(key: _currentUserKey);
    await _storage.delete(key: _authTokenKey);
    state = const AsyncData(AuthUnauthenticated());
  }
}

final authNotifierProvider = AsyncNotifierProvider<AuthNotifier, AuthState>(
  AuthNotifier.new,
);
