import 'package:data/data.dart';

import 'interface/login_interface.dart';

class LoginRepo implements LoginInterface {
  final AuthDBInterface db;

  LoginRepo({required this.db});
  @override
  Future<UserEntity?> handle({
    required String userName,
    required String password,
  }) => db.login(userName, password);
}
