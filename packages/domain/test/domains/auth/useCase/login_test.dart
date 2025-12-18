import 'dart:io';

import 'package:data/data.dart';
import 'package:data/objectbox.g.dart';
import 'package:domain/src/domains/auth/auth.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late final Box<UserEntity> box;
  late final AuthDBInterface authDB;
  late final Store store;
  late Directory testDir;

  setUpAll(() async {
    testDir = await Directory.systemTemp.createTemp('objectbox_test_');
    store = await openStore(directory: testDir.path);
    box = store.box<UserEntity>();
    authDB = AuthDB(store: store);
  });
  tearDown(() {
    box.removeAll();
  });

  group('LoginUC', () {
    late LoginUseCase loginUC;
    setUp(() {
      loginUC = LoginUC.create(db: authDB);
    });

    test('should call handle on LoginRepo', () async {
      // Arrange
      const userName = 'testUser';
      const password = 'password';
      box.put(
        UserEntity(encryptedPassword: password.encrypt(), username: userName),
      );

      final result = await loginUC.call(userName: userName, password: password);

      expect(result!, isA<UserEntity>());
      expect(result.username, userName);
      expect(result.encryptedPassword, password.encrypt());
    });
    test(
      'should be throw UserNotFindAuthException when user not found',
      () async {
        // Arrange
        const userName = 'testUser';
        const password = 'password';
        box.put(
          UserEntity(encryptedPassword: password.encrypt(), username: ''),
        );

        expect(
          () async =>
              await loginUC.call(userName: userName, password: password),
          throwsA(UserNotFindAuthException),
        );
      },
    );
    test('should be return null when password is wrong', () async {
      // Arrange
      const userName = 'testUser';
      const password = 'password';
      box.put(
        UserEntity(
          encryptedPassword: 'password1'.encrypt(),
          username: userName,
        ),
      );
      final result = await loginUC.call(userName: userName, password: password);
      expect(result, isNull);
    });
  });
}
