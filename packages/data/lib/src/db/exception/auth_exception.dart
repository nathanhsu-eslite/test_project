sealed class AuthException implements Exception {}

class UserNotFindAuthException implements AuthException {}

class UsernameAlreadyExistsAuthException implements AuthException {}
