import 'package:data/data.dart';

abstract interface class LoginUseCase {
  Future<UserEntity?> call({
    required String userName,
    required String password,
  });
}

abstract interface class RegisterUseCase {
  Future<void> call({required String userName, required String password});
}
