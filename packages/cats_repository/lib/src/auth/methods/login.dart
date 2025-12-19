import 'package:data/data.dart';
import 'package:injectable/injectable.dart';

import 'interface/login_interface.dart';

@Injectable(as: LoginInterface)
class LoginRepo implements LoginInterface {
  final AuthDBInterface db;

  LoginRepo({required this.db});
  @override
  Future<UserEntity?> handle({
    required String userName,
    required String password,
  }) => db.login(userName, password);
}
