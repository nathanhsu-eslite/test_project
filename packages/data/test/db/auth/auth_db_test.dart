import 'dart:io';

import 'package:data/objectbox.g.dart';
import 'package:data/src/db/auth/auth_src.dart';
import 'package:data/src/db/auth/schema/schema.dart';
import 'package:data/src/db/exception/auth_exception.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late final Store store;
  late final AuthDB authDB;
  late final Box<UserEntity> box;
  late Directory testDir;

  setUpAll(() async {
    testDir = await Directory.systemTemp.createTemp('objectbox_test_');

    store = await openStore(directory: testDir.path);
    box = store.box<UserEntity>();
    authDB = AuthDB(store: store);
  });

  tearDownAll(() {
    box.removeAll();
    store.close();
  });

  group('AuthDB', () {
    test('register and login', () async {
      // Register a user
      await authDB.register('testUser', 'password');

      // Try to login with correct password
      final user = await authDB.login('testUser', 'password');
      expect(user, isNotNull);
      expect(user?.username, 'testUser');

      // Try to login with incorrect password
      final user2 = await authDB.login('testUser', 'wrongPassword');
      expect(user2, isNull);
    });

    test('login with non-existent user throws UserNotFindAuthException', () {
      expect(
        () async => await authDB.login('nonexistent', 'password'),
        throwsA(UserNotFindAuthException),
      );
    });
    test('register with existing username throws exception', () async {
      await authDB.register('testUser', 'password');
      expect(
        () async => await authDB.register('testUser', 'password'),
        throwsA(UsernameAlreadyExistsAuthException),
      );
    });

    test('delete user', () async {
      // Register a user
      await authDB.register('testUser2', 'password');

      // Get the user to have the id
      final user = await authDB.login('testUser2', 'password');
      expect(user, isNotNull);

      // Delete the user
      await authDB.deleteUser(user!.id);

      // Try to login again
      expect(
        () async => await authDB.login('testUser2', 'password'),
        throwsA(UserNotFindAuthException),
      );
    });
  });
}
