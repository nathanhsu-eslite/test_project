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
  group('DeleteUserUC', () {
    late DeleteUserUseCase deleteUserUC;

    setUp(() {
      deleteUserUC = DeleteUserUC.create(db: authDB);
    });

    test('should call handle on DeleteUserRepo', () async {
      const userName = 'testUser';
      const password = 'password';
      final id = box.put(
        UserEntity(encryptedPassword: password.encrypt(), username: userName),
      );
      await deleteUserUC(id: id);
      final result = box
          .query(UserEntity_.username.equals(userName))
          .build()
          .find();
      expect(result, isEmpty);
    });
  });
}
