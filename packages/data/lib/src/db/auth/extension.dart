import 'dart:convert';

extension User on String {
  String encrypt() {
    final bytes = utf8.encode(this);
    return base64.encode(bytes);
  }

  String decrypt() {
    // base64 字串 -> 轉回 bytes -> 轉回原始字串
    final bytes = base64.decode(this);
    return utf8.decode(bytes);
  }
}
