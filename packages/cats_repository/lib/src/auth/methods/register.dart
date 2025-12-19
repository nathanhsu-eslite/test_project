import 'package:cats_repository/src/auth/methods/interface/register_interface.dart';
import 'package:data/data.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: RegisterInterface)
class RegisterRepo implements RegisterInterface {
  final AuthDBInterface db;

  RegisterRepo({required this.db});
  @override
  Future<UserEntity> handle({
    required String userName,
    required String password,
  }) => db.register(userName, password);
}
