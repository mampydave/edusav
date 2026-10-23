import 'package:drift/native.dart';
import 'package:edusav/common/services/databases/database.dart';
import 'package:edusav/common/services/databases/database_provider.dart';
import 'package:edusav/core/di/current_user_provider.dart';
import 'package:edusav/features/auth/domain/auth_user.dart';
import 'package:edusav/features/profile/profile_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase database;

  setUp(() async {
    database = AppDatabase(NativeDatabase.memory());
    await database.roleDao.insert(
      RolesCompanion.insert(id: 'student-role-id', nomRole: 'ELEVE'),
    );
  });

  tearDown(() async {
    await database.close();
  });

  test('profile resolves role by its database id', () async {
    final container = ProviderContainer(
      overrides: [
        databaseProvider.overrideWithValue(database),
        currentUserProvider.overrideWithValue(
          const AuthUser(
            id: 'user-1',
            name: 'Student',
            email: 'student@example.com',
            roleId: 'student-role-id',
          ),
        ),
      ],
    );
    addTearDown(container.dispose);

    expect(await container.read(profileRoleNameProvider.future), 'ELEVE');
  });

  test('profile resolves legacy role code stored in roleId', () async {
    final container = ProviderContainer(
      overrides: [
        databaseProvider.overrideWithValue(database),
        currentUserProvider.overrideWithValue(
          const AuthUser(
            id: 'user-1',
            name: 'Student',
            email: 'student@example.com',
            roleId: 'ELEVE',
          ),
        ),
      ],
    );
    addTearDown(container.dispose);

    expect(await container.read(profileRoleNameProvider.future), 'ELEVE');
  });
}
