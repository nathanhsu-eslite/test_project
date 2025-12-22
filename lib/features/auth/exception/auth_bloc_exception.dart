class InvalidLoginInputAuthBlocException implements AuthBlocException {}

class InvalidRegisterInputAuthBlocException implements AuthBlocException {}

class PasswordMismatchAuthBlocException implements AuthBlocException {}

abstract class AuthBlocException implements Exception {}

class WrongPasswordAuthBlocException implements AuthBlocException {}

class DeleteUserFailAuthBlocException implements AuthBlocException {}
