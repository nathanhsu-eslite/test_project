import 'package:data/objectbox.g.dart';
import 'package:data/src/db/auth/extension.dart';
import 'package:data/src/db/auth/schema/schema.dart';
import 'package:data/src/db/exception/auth_exception.dart';

abstract interface class AuthDBInterface {
  Future<UserEntity?> login(String username, String password);
  Future<UserEntity> register(String username, String password);
  Future<void> deleteUser(int id);
}

class AuthDB implements AuthDBInterface {
  final Box<UserEntity> _box;

  AuthDB({required Store store}) : _box = store.box<UserEntity>();

  @override
  Future<UserEntity?> login(String username, String password) async {
    try {
      final Query<UserEntity> query = _box
          .query(UserEntity_.username.equals(username))
          .build();
      UserEntity? userEntity = query.findUnique();
      query.close();
      if (userEntity == null) throw UserNotFindAuthException();
      if (password.encrypt() == userEntity.encryptedPassword) return userEntity;

      return null;
    } on AuthException catch (_) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserEntity> register(String username, String password) async {
    try {
      final Query<UserEntity> query = _box
          .query(UserEntity_.username.equals(username))
          .build();
      UserEntity? userEntity = query.findUnique();
      query.close();
      if (userEntity != null) throw UsernameAlreadyExistsAuthException();
      _box.put(
        UserEntity(username: username, encryptedPassword: password.encrypt()),
      );
      return UserEntity(
        username: username,
        encryptedPassword: password.encrypt(),
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteUser(int id) async {
    try {
      _box.remove(id);
    } catch (e) {
      rethrow;
    }
  }
}
