import 'package:cats_repository/src/auth/methods/interface/delete_user_interface.dart';
import 'package:data/data.dart';

class DeleteUserRepo implements DeleteUserInterface {
  final AuthDBInterface db;

  DeleteUserRepo({required this.db});
  @override
  Future<void> handle({required int id}) => db.deleteUser(id);
}
