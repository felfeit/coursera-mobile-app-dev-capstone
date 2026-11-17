import 'dart:convert';

import 'package:crypto/crypto.dart';

class PasswordHasher {
  PasswordHasher._();

  static String hashPassword(String password) {
    final bytes = utf8.encode(password);
    return sha256.convert(bytes).toString();
  }

  static bool verifyPassword(String password, String hash) {
    return hashPassword(password) == hash;
  }
}
