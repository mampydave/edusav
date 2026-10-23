import 'auth_user.dart';

abstract interface class AuthRepository {
  Future<AuthAccount?> findAccountByEmail(String email);

  Future<AuthUser?> findActiveUserById(String userId);

  Future<String?> findRoleIdByName(String roleName);

  Future<bool> hasActiveAssignment(String userId);

  Future<String?> readSessionUserId();

  Future<void> saveSession(String userId);

  Future<void> clearSession();

  Future<AuthUser> createStudent({
    required String name,
    required String email,
    required String passwordHash,
    required String roleId,
    String? schoolId,
    String? levelId,
    String? schoolYear,
  });

  Future<void> createStaff({
    required String name,
    required String email,
    required String passwordHash,
    required String roleId,
    required List<String> schoolIds,
  });
}

class AuthAccount {
  final AuthUser user;
  final String passwordHash;

  const AuthAccount({required this.user, required this.passwordHash});
}

class AuthException implements Exception {
  final String message;

  const AuthException(this.message);

  @override
  String toString() => message;
}
