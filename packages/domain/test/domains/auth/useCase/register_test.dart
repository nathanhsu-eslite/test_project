import 'dart:io';
import 'package:cats_repository/cats_repository.dart';
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
  group('RegisterUC', () {
    late RegisterUseCase registerUC;

    setUp(() {
      registerUC = RegisterUC(repo: RegisterRepo(db: authDB));
    });

    test('should call handle on RegisterRepo', () async {
      // Arrange
      const userName = 'newUser';
      const password = 'newPassword';

      await registerUC(userName: userName, password: password);
      final result = box
          .query(UserEntity_.username.equals(userName))
          .build()
          .find();

      expect(result.first.username, userName);
    });
    test(
      'throw UsernameAlreadyExistsAuthException when username already exists',
      () async {
        // Arrange
        const userName = 'testUser';
        const password = 'password';
        box.put(
          UserEntity(encryptedPassword: password.encrypt(), username: userName),
        );

        expect(
          () async => await registerUC(userName: userName, password: password),
          throwsA(isA<UsernameAlreadyExistsAuthException>()),
        );
      },
    );
  });
}
