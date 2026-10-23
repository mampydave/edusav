import 'dart:convert';

import 'package:crypto/crypto.dart';

import '../domain/password_hasher.dart';

class Sha256PasswordHasher implements PasswordHasher {
  @override
  String hash(String password) =>
      sha256.convert(utf8.encode(password)).toString();

  @override
  bool verify(String password, String passwordHash) =>
      hash(password) == passwordHash;
}
