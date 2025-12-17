import 'package:cats_repository/src/auth/methods/login.dart';
import 'package:data/data.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthDB extends Mock implements AuthDB {}

void main() {
  group('LoginRepo', () {
    late AuthDB authDB;
    late LoginRepo loginRepo;

    setUp(() {
      authDB = MockAuthDB();
      loginRepo = LoginRepo(db: authDB);
    });

    test('handle calls db.login with correct userName and password', () async {
      const userName = 'test';
      const password = 'password';

      when(() => authDB.login(userName, password)).thenAnswer((_) async {
        return UserEntity(encryptedPassword: password, username: userName);
      });

      await loginRepo.handle(userName: userName, password: password);

      verify(() => authDB.login(userName, password)).called(1);
    });

    test('handle throws exception when db.login throws exception', () async {
      const userName = 'test';
      const password = 'password';
      final exception = Exception('Login failed');

      when(() => authDB.login(userName, password)).thenThrow(exception);

      expect(
        () => loginRepo.handle(userName: userName, password: password),
        throwsA(exception),
      );
    });
  });
}
