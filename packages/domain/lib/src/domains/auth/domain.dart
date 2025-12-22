import 'package:data/data.dart';

abstract interface class LoginUseCase {
  Future<UserEntity?> call({
    required String userName,
    required String password,
  });
}

abstract interface class RegisterUseCase {
  Future<UserEntity> call({required String userName, required String password});
}

abstract interface class DeleteUserUseCase {
  Future<void> call({required int id});
}
