import 'package:edusav/common/services/database_services.dart';
import 'package:edusav/common/services/databases/database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final rolesProvider = FutureProvider<List<Role>>((ref) async {
  final db = ref.watch(databaseServiceProvider);
  return db.roles.getAllWithoutAdmin();
});

final rolesByCodeProvider = FutureProvider.family<Role?, String>((
  ref,
  code,
) async {
  final roles = await ref.watch(rolesProvider.future);
  return roles
      .where((r) => r.nomRole.toUpperCase() == code.toUpperCase())
      .firstOrNull;
});
