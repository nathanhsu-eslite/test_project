import 'dart:async';
import 'package:data/data.dart'; // Import UserEntity

class AuthService {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  final StreamController<UserEntity?> _authController = StreamController<UserEntity?>.broadcast();

  UserEntity? _user;

  Stream<UserEntity?> get authStream => _authController.stream;
  bool get isLoggedIn => _user != null;
  UserEntity? get user => _user;

  void login(UserEntity user) {
    _user = user;
    _authController.add(_user);
  }

  void logout() {
    _user = null;
    _authController.add(_user);
  }

  void dispose() {
    _authController.close();
  }
}
