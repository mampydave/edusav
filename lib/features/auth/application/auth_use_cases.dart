import '../domain/auth_repository.dart';
import '../domain/auth_user.dart';
import '../domain/password_hasher.dart';

class RestoreAuthSession {
  final AuthRepository _repository;

  const RestoreAuthSession(this._repository);

  Future<AuthUser?> call() async {
    final userId = await _repository.readSessionUserId();
    if (userId == null) return null;

    final user = await _repository.findActiveUserById(userId);
    if (user == null) await _repository.clearSession();
    return user;
  }
}

class Login {
  final AuthRepository _repository;
  final PasswordHasher _passwordHasher;

  const Login(this._repository, this._passwordHasher);

  Future<AuthUser> call({
    required String email,
    required String password,
  }) async {
    final account = await _repository.findAccountByEmail(
      email.trim().toLowerCase(),
    );
    if (account == null) throw const AuthException('Utilisateur non trouvé');
    if (!_passwordHasher.verify(password, account.passwordHash)) {
      throw const AuthException('Mot de passe incorrect');
    }

    final studentRoleId = await _repository.findRoleIdByName('ELEVE');
    final adminRoleId = await _repository.findRoleIdByName('ADMIN');
    final requiresActiveAssignment =
        account.user.roleId != studentRoleId &&
        account.user.roleId != adminRoleId;
    if (requiresActiveAssignment &&
        !await _repository.hasActiveAssignment(account.user.id)) {
      throw const AuthException(
        'Compte inactif. Veuillez contacter l\'administrateur.',
      );
    }

    await _repository.saveSession(account.user.id);
    return account.user;
  }
}

class RegisterStudent {
  final AuthRepository _repository;
  final PasswordHasher _passwordHasher;

  const RegisterStudent(this._repository, this._passwordHasher);

  Future<AuthUser> call({
    required String name,
    required String email,
    required String password,
    required String roleId,
    String? schoolId,
    String? levelId,
    String? schoolYear,
  }) async {
    final normalizedEmail = email.trim().toLowerCase();
    await _ensureEmailAvailable(normalizedEmail);

    final user = await _repository.createStudent(
      name: name.trim(),
      email: normalizedEmail,
      passwordHash: _passwordHasher.hash(password),
      roleId: roleId,
      schoolId: schoolId,
      levelId: levelId,
      schoolYear: schoolYear,
    );
    await _repository.saveSession(user.id);
    return user;
  }

  Future<void> _ensureEmailAvailable(String email) async {
    if (await _repository.findAccountByEmail(email) != null) {
      throw const AuthException('Cet email est déjà utilisé');
    }
  }
}

class RegisterStaff {
  final AuthRepository _repository;
  final PasswordHasher _passwordHasher;

  const RegisterStaff(this._repository, this._passwordHasher);

  Future<void> call({
    required String name,
    required String email,
    required String password,
    required String roleId,
    required List<String> schoolIds,
  }) async {
    final normalizedEmail = email.trim().toLowerCase();
    if (await _repository.findAccountByEmail(normalizedEmail) != null) {
      throw const AuthException('Cet email est déjà utilisé');
    }

    await _repository.createStaff(
      name: name.trim(),
      email: normalizedEmail,
      passwordHash: _passwordHasher.hash(password),
      roleId: roleId,
      schoolIds: schoolIds,
    );
  }
}

class Logout {
  final AuthRepository _repository;

  const Logout(this._repository);

  Future<void> call() => _repository.clearSession();
}
