import 'package:edusav/features/auth/domain/auth_user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'auth_providers.dart';

sealed class AuthState {
  const AuthState();
}

class AuthAuthenticated extends AuthState {
  final AuthUser user;

  const AuthAuthenticated(this.user);
}

class AuthUnauthenticated extends AuthState {
  const AuthUnauthenticated();
}

class AuthController extends AsyncNotifier<AuthState> {
  @override
  Future<AuthState> build() async => const AuthUnauthenticated();

  Future<void> checkCurrentUser() async {
    state = const AsyncLoading();
    try {
      final user = await ref.read(restoreAuthSessionProvider).call();
      state = AsyncData(
        user == null ? const AuthUnauthenticated() : AuthAuthenticated(user),
      );
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    }
  }

  Future<void> login(String email, String password) async {
    state = const AsyncLoading();
    try {
      final user = await ref
          .read(loginProvider)
          .call(email: email, password: password);
      state = AsyncData(AuthAuthenticated(user));
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
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
      final user = await ref
          .read(registerStudentProvider)
          .call(
            name: nom,
            email: email,
            password: password,
            roleId: roleId,
            schoolId: ecoleId,
            levelId: niveauId,
            schoolYear: anneeSco,
          );
      state = AsyncData(AuthAuthenticated(user));
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
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
      await ref
          .read(registerStaffProvider)
          .call(
            name: nom,
            email: email,
            password: password,
            roleId: roleId,
            schoolIds: ecoleIds,
          );
      state = const AsyncData(AuthUnauthenticated());
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    }
  }

  Future<void> logout() async {
    state = const AsyncLoading();
    try {
      await ref.read(logoutProvider).call();
      state = const AsyncData(AuthUnauthenticated());
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    }
  }
}

final authControllerProvider = AsyncNotifierProvider<AuthController, AuthState>(
  AuthController.new,
);
