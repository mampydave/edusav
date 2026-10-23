class AuthUser {
  final String id;
  final String name;
  final String email;
  final String? roleId;

  const AuthUser({
    required this.id,
    required this.name,
    required this.email,
    required this.roleId,
  });
}
