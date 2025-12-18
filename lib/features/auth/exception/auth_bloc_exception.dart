class InvalidLoginInputAuthBlocException implements AuthBlocException {}

class InvalidRegisterInputAuthBlocException implements AuthBlocException {}

abstract class AuthBlocException implements Exception {}

class WrongPasswordAuthBlocException implements AuthBlocException {}

class DeleteUserFailAuthBlocException implements AuthBlocException {}
