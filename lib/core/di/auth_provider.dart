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

  Future<void> register({
    required String nom,
    required String email,
    required String password,
    String? ecoleId,
    String? niveauId,
    String? anneeSco,
  }) async {
    state = const AsyncLoading();

    try {
      final db = ref.read(databaseServiceProvider);
      final uuid = const Uuid();

      // 1. Vérifier si l'email existe déjà
      final existingUser = await db.utilisateurs.getByEmail(email);
      if (existingUser != null) {
        state = AsyncError('Cet email est déjà utilisé', StackTrace.current);
        return;
      }

      // 2. Créer l'utilisateur
      final userId = uuid.v4();
      final passwordHash = sha256.convert(utf8.encode(password)).toString();

      await db.utilisateurs.insert(
        UtilisateursCompanion.insert(
          id: userId,
          nom: nom.trim(),
          email: email.trim().toLowerCase(),
          mdp: passwordHash,
          dateCrea: DateTime.now().millisecondsSinceEpoch,
        ),
      );

      // 3. Créer l'appartenance si l'utilisateur a choisi une école
      if (ecoleId != null && anneeSco != null && anneeSco.isNotEmpty) {
        await db.appartenances.insert(
          AppartenancesCompanion.insert(
            id: uuid.v4(),
            userId: userId,
            ecoleId: ecoleId,
            niveauId: Value(niveauId),
            anneeSco: anneeSco.trim(),
            estActif: Value(true),
            dateMiseAJour: DateTime.now().millisecondsSinceEpoch,
          ),
        );
      }

      // 4. Connexion automatique après inscription
      await _storage.write(key: _currentUserKey, value: userId);
      await _storage.write(
        key: _authTokenKey,
        value: 'offline_session_$userId',
      );

      // Récupérer l'utilisateur complet pour l'état
      final newUser = await db.utilisateurs.getById(userId);

      if (newUser != null) {
        state = AsyncData(AuthAuthenticated(newUser));
      } else {
        state = AsyncError(
          'Erreur lors de la récupération du profil',
          StackTrace.current,
        );
      }
    } catch (e, st) {
      // state = AsyncData(AuthError('Erreur lors de l\'inscription : ${e.toString()}'));
      state = AsyncError('Erreur lors de l\'inscription : ${e.toString()}', st);
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
