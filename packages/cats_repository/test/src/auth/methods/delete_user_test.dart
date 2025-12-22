import 'package:cats_repository/src/auth/methods/delete_user.dart';
import 'package:data/data.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthDB extends Mock implements AuthDB {}

void main() {
  group('DeleteUserRepo', () {
    late AuthDB authDB;
    late DeleteUserRepo deleteUserRepo;

    setUp(() {
      authDB = MockAuthDB();
      deleteUserRepo = DeleteUserRepo(db: authDB);
    });

    test('handle calls db.deleteUser with correct id', () async {
      const id = 1;

      when(() => authDB.deleteUser(id)).thenAnswer((_) async {});

      await deleteUserRepo.handle(id: id);

      verify(() => authDB.deleteUser(id)).called(1);
    });

    test('handle throws exception when db.deleteUser throws exception', () async {
      const id = 1;
      final exception = Exception('Deletion failed');

      when(() => authDB.deleteUser(id)).thenThrow(exception);

      expect(
        () => deleteUserRepo.handle(id: id),
        throwsA(exception),
      );
    });
  });
}
