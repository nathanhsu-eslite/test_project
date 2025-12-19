import 'package:cats_repository/cats_repository.dart';
import 'package:data/data.dart';
import 'package:domain/src/domains/auth/auth.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: RegisterUseCase)
class RegisterUC implements RegisterUseCase {
  final RegisterInterface repo;

  RegisterUC({required this.repo});

  @override
  Future<UserEntity> call({
    required String userName,
    required String password,
  }) => repo.handle(userName: userName, password: password);
}
