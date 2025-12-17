sealed class AuthException implements Exception {}

sealed class UserNotFindAuthException implements AuthException {}

sealed class UsernameAlreadyExistsAuthException implements AuthException {}
