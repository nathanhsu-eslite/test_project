import 'package:cats_repository/cats_repository.dart';
import 'package:data/data.dart';
import 'package:domain/src/domains/auth/domain.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: LoginUseCase)
class LoginUC implements LoginUseCase {
  final LoginInterface repo;

  LoginUC({required this.repo});

  @override
  Future<UserEntity?> call({
    required String userName,
    required String password,
  }) => repo.handle(userName: userName, password: password);
}
