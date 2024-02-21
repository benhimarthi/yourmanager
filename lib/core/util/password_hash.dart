import 'dart:convert';

import 'package:crypto/crypto.dart';

String hashPassword(String password) {
  const salt = "carma_sphere";
  final key = utf8.encode('$password$salt');
  final bytes = sha256.convert(key).bytes;
  return base64Encode(bytes);
}
