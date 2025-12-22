import 'package:cats_repository/src/auth/methods/register.dart';

import 'package:data/data.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthDB extends Mock implements AuthDB {}

void main() {
  group('RegisterRepo', () {
    late AuthDB authDB;
    late RegisterRepo registerRepo;

    setUp(() {
      authDB = MockAuthDB();
      registerRepo = RegisterRepo(db: authDB);
    });

    test(
      'handle calls db.register with correct userName and password',
      () async {
        const userName = 'test';
        const password = 'password';

        when(() => authDB.register(userName, password)).thenAnswer(
          (_) async => UserEntity(
            encryptedPassword: password.encrypt(),
            username: userName,
          ),
        );

        final result = await registerRepo.handle(
          userName: userName,
          password: password,
        );

        expect(result.username, userName);
        expect(result.encryptedPassword, password.encrypt());
      },
    );

    test('handle throws exception when db.register throws exception', () async {
      const userName = 'test@example.com';
      const password = 'password';
      final exception = Exception('Registration failed');

      when(() => authDB.register(userName, password)).thenThrow(exception);

      expect(
        () => registerRepo.handle(userName: userName, password: password),
        throwsA(exception),
      );
    });
  });
}
