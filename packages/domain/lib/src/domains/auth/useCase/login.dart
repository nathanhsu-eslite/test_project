import 'package:cats_repository/cats_repository.dart';
import 'package:data/data.dart';
import 'package:domain/src/domains/auth/domain.dart';

class LoginUC implements LoginUseCase {
  final LoginRepo repo;

  LoginUC({required this.repo});
  factory LoginUC.create({required AuthDBInterface db}) {
    final repo = LoginRepo(db: db);
    return LoginUC(repo: repo);
  }

  @override
  Future<UserEntity?> call({
    required String userName,
    required String password,
  }) => repo.handle(userName: userName, password: password);
}
