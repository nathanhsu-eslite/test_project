import 'package:data/data.dart';

abstract interface class LoginInterface {
  Future<UserEntity?> handle({
    required String userName,
    required String password,
  });
}
