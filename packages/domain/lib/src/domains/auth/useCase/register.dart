import 'package:cats_repository/cats_repository.dart';
import 'package:data/data.dart';
import 'package:domain/src/domains/auth/auth.dart';

class RegisterUC implements RegisterUseCase {
  final RegisterInterface repo;

  RegisterUC({required this.repo});
  factory RegisterUC.create({required AuthDBInterface db}) {
    final repo = RegisterRepo(db: db);
    return RegisterUC(repo: repo);
  }

  @override
  Future<UserEntity> call({
    required String userName,
    required String password,
  }) => repo.handle(userName: userName, password: password);
}
