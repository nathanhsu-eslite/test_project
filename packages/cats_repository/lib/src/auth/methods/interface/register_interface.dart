import 'package:data/data.dart';

abstract interface class RegisterInterface {
  Future<UserEntity> handle({
    required String userName,
    required String password,
  });
}
