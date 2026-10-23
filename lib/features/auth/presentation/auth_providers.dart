import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../common/services/databases/database_provider.dart';
import '../application/auth_use_cases.dart';
import '../data/drift_auth_repository.dart';
import '../data/sha256_password_hasher.dart';
import '../domain/auth_repository.dart';
import '../domain/password_hasher.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return DriftAuthRepository(
    ref.watch(databaseProvider),
    const FlutterSecureStorage(),
  );
});

final passwordHasherProvider = Provider<PasswordHasher>((ref) {
  return Sha256PasswordHasher();
});

final restoreAuthSessionProvider = Provider<RestoreAuthSession>((ref) {
  return RestoreAuthSession(ref.watch(authRepositoryProvider));
});

final loginProvider = Provider<Login>((ref) {
  return Login(
    ref.watch(authRepositoryProvider),
    ref.watch(passwordHasherProvider),
  );
});

final registerStudentProvider = Provider<RegisterStudent>((ref) {
  return RegisterStudent(
    ref.watch(authRepositoryProvider),
    ref.watch(passwordHasherProvider),
  );
});

final registerStaffProvider = Provider<RegisterStaff>((ref) {
  return RegisterStaff(
    ref.watch(authRepositoryProvider),
    ref.watch(passwordHasherProvider),
  );
});

final logoutProvider = Provider<Logout>((ref) {
  return Logout(ref.watch(authRepositoryProvider));
});
