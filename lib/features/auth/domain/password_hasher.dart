abstract interface class PasswordHasher {
  String hash(String password);

  bool verify(String password, String passwordHash);
}
