import 'dart:async';

class AuthService {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  final StreamController<bool> _authController = StreamController<bool>.broadcast();

  bool _isLoggedIn = false;

  Stream<bool> get authStream => _authController.stream;
  bool get isLoggedIn => _isLoggedIn;

  void login() {
    _isLoggedIn = true;
    _authController.add(_isLoggedIn);
  }

  void logout() {
    _isLoggedIn = false;
    _authController.add(_isLoggedIn);
  }

  void dispose() {
    _authController.close();
  }
}
