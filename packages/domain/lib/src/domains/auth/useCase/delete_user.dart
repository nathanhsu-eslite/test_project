import 'package:cats_repository/cats_repository.dart';
import 'package:data/data.dart';
import 'package:domain/src/domains/auth/domain.dart';

class DeleteUserUC implements DeleteUserUseCase {
  final DeleteUserRepo repo;

  DeleteUserUC({required this.repo});
  factory DeleteUserUC.create({required AuthDBInterface db}) {
    final repo = DeleteUserRepo(db: db);
    return DeleteUserUC(repo: repo);
  }

  @override
  Future<void> call({required int id}) => repo.handle(id: id);
}
