import 'package:edusav/features/auth/application/auth_use_cases.dart';
import 'package:edusav/features/auth/domain/auth_repository.dart';
import 'package:edusav/features/auth/domain/auth_user.dart';
import 'package:edusav/features/auth/domain/password_hasher.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const user = AuthUser(
    id: 'user-1',
    name: 'Alex Student',
    email: 'alex@example.com',
    roleId: 'student-role',
  );

  test('restore session returns the user for the stored session id', () async {
    final repository = FakeAuthRepository()
      ..sessionUserId = user.id
      ..activeUser = user;

    final restored = await RestoreAuthSession(repository).call();

    expect(restored, user);
    expect(repository.lookedUpUserId, user.id);
  });

  test('restore session clears a stale session', () async {
    final repository = FakeAuthRepository()..sessionUserId = 'deleted-user';

    final restored = await RestoreAuthSession(repository).call();

    expect(restored, isNull);
    expect(repository.clearSessionCalls, 1);
  });

  test(
    'login normalizes email, verifies password, and saves session',
    () async {
      final repository = FakeAuthRepository()
        ..account = const AuthAccount(
          user: user,
          passwordHash: 'hashed:secret',
        );

      final authenticated = await Login(
        repository,
        const FakePasswordHasher(),
      ).call(email: '  ALEX@EXAMPLE.COM ', password: 'secret');

      expect(authenticated, user);
      expect(repository.lookedUpEmail, 'alex@example.com');
      expect(repository.savedSessionUserId, user.id);
    },
  );

  test('login rejects invalid credentials without saving session', () async {
    final repository = FakeAuthRepository()
      ..account = const AuthAccount(user: user, passwordHash: 'hashed:secret');

    await expectLater(
      Login(
        repository,
        const FakePasswordHasher(),
      ).call(email: user.email, password: 'wrong'),
      throwsA(isA<AuthException>()),
    );
    expect(repository.savedSessionUserId, isNull);
  });

  test('admin can log in without an active school assignment', () async {
    const admin = AuthUser(
      id: 'admin-1',
      name: 'Admin',
      email: 'admin@edusav.mg',
      roleId: 'admin-role',
    );
    final repository = FakeAuthRepository()
      ..account = const AuthAccount(
        user: admin,
        passwordHash: 'hashed:admin123',
      );

    final authenticated = await Login(
      repository,
      const FakePasswordHasher(),
    ).call(email: admin.email, password: 'admin123');

    expect(authenticated, admin);
    expect(repository.assignmentChecks, 0);
    expect(repository.savedSessionUserId, admin.id);
  });

  test('inactive staff cannot log in without an active assignment', () async {
    const staff = AuthUser(
      id: 'staff-1',
      name: 'Staff',
      email: 'staff@example.com',
      roleId: 'staff-role',
    );
    final repository = FakeAuthRepository()
      ..account = const AuthAccount(user: staff, passwordHash: 'hashed:secret');

    await expectLater(
      Login(
        repository,
        const FakePasswordHasher(),
      ).call(email: staff.email, password: 'secret'),
      throwsA(isA<AuthException>()),
    );
    expect(repository.assignmentChecks, 1);
    expect(repository.savedSessionUserId, isNull);
  });

  test('register student normalizes values and saves session', () async {
    final repository = FakeAuthRepository();

    final registered =
        await RegisterStudent(repository, const FakePasswordHasher()).call(
          name: ' Alex Student ',
          email: ' ALEX@EXAMPLE.COM ',
          password: 'secret',
          roleId: 'student-role',
          schoolId: 'school-1',
          levelId: 'level-1',
          schoolYear: '2026-2027',
        );

    expect(registered, user);
    expect(repository.createdName, user.name);
    expect(repository.createdEmail, user.email);
    expect(repository.createdPasswordHash, 'hashed:secret');
    expect(repository.createdSchoolId, 'school-1');
    expect(repository.createdLevelId, 'level-1');
    expect(repository.createdSchoolYear, '2026-2027');
    expect(repository.savedSessionUserId, user.id);
  });
}

class FakePasswordHasher implements PasswordHasher {
  const FakePasswordHasher();

  @override
  String hash(String password) => 'hashed:$password';

  @override
  bool verify(String password, String passwordHash) =>
      hash(password) == passwordHash;
}

class FakeAuthRepository implements AuthRepository {
  AuthAccount? account;
  AuthUser? activeUser;
  String? sessionUserId;
  String? lookedUpEmail;
  String? lookedUpUserId;
  String? savedSessionUserId;
  String? createdName;
  String? createdEmail;
  String? createdPasswordHash;
  String? createdSchoolId;
  String? createdLevelId;
  String? createdSchoolYear;
  int clearSessionCalls = 0;
  int assignmentChecks = 0;

  @override
  Future<AuthAccount?> findAccountByEmail(String email) async {
    lookedUpEmail = email;
    return account;
  }

  @override
  Future<AuthUser?> findActiveUserById(String userId) async {
    lookedUpUserId = userId;
    return activeUser;
  }

  @override
  Future<String?> findRoleIdByName(String roleName) async => switch (roleName) {
    'ADMIN' => 'admin-role',
    _ => 'student-role',
  };

  @override
  Future<bool> hasActiveAssignment(String userId) async {
    assignmentChecks++;
    return false;
  }

  @override
  Future<String?> readSessionUserId() async => sessionUserId;

  @override
  Future<void> saveSession(String userId) async {
    savedSessionUserId = userId;
  }

  @override
  Future<void> clearSession() async {
    clearSessionCalls++;
  }

  @override
  Future<AuthUser> createStudent({
    required String name,
    required String email,
    required String passwordHash,
    required String roleId,
    String? schoolId,
    String? levelId,
    String? schoolYear,
  }) async {
    createdName = name;
    createdEmail = email;
    createdPasswordHash = passwordHash;
    createdSchoolId = schoolId;
    createdLevelId = levelId;
    createdSchoolYear = schoolYear;
    return const AuthUser(
      id: 'user-1',
      name: 'Alex Student',
      email: 'alex@example.com',
      roleId: 'student-role',
    );
  }

  @override
  Future<void> createStaff({
    required String name,
    required String email,
    required String passwordHash,
    required String roleId,
    required List<String> schoolIds,
  }) async {}
}
