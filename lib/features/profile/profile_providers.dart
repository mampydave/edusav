import 'package:edusav/common/services/database_services.dart';
import 'package:edusav/core/di/current_user_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final profileRoleNameProvider = FutureProvider.autoDispose<String?>((
  ref,
) async {
  final user = ref.watch(currentUserProvider);
  if (user == null) return null;
  final roleKey = user.roleId?.trim();
  if (roleKey == null || roleKey.isEmpty) return user.roleName;

  final database = ref.watch(databaseServiceProvider);
  final roleById = await database.roles.getById(roleKey);
  if (roleById != null) return roleById.nomRole;

  final roleByName = await database.roles.getByName(roleKey.toUpperCase());
  return roleByName?.nomRole ?? user.roleName;
});
