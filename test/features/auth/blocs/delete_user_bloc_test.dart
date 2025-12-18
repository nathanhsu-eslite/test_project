import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test_3_35_7/features/auth/blocs/delete_user_bloc/delete_user_bloc.dart';
import 'package:domain/domain.dart';
import 'package:test_3_35_7/features/auth/exception/auth_bloc_exception.dart';

class MockDeleteUserUseCase extends Mock implements DeleteUserUseCase {}

void main() {
  group('DeleteUserBloc', () {
    late DeleteUserUseCase deleteUserUseCase;

    setUp(() {
      deleteUserUseCase = MockDeleteUserUseCase();
    });

    DeleteUserBloc buildBloc() {
      return DeleteUserBloc(deleteUserUseCase: deleteUserUseCase);
    }

    group('constructor', () {
      test('works properly', () => expect(buildBloc, returnsNormally));

      test('has correct initial state', () {
        expect(buildBloc().state, equals(DeleteUserInitial()));
      });
    });

    group('DeleteUserSubmitted', () {
      blocTest<DeleteUserBloc, DeleteUserState>(
        'emits [DeleteUserInProgress, DeleteUserSuccess] when deletion succeeds',
        setUp: () {
          when(() => deleteUserUseCase.call(id: 1)).thenAnswer((_) async => {});
        },
        build: buildBloc,
        act: (bloc) => bloc.add(const DeleteUserSubmitted(id: 1)),
        expect: () => <DeleteUserState>[
          DeleteUserInProgress(),
          DeleteUserSuccess(),
        ],
      );

      blocTest<DeleteUserBloc, DeleteUserState>(
        'emits [DeleteUserInProgress, DeleteUserFailure] when deletion throws',
        setUp: () {
          when(
            () => deleteUserUseCase.call(id: 1),
          ).thenAnswer(((_) async => throw DeleteUserFailAuthBlocException()));
        },
        build: buildBloc,
        act: (bloc) => bloc.add(const DeleteUserSubmitted(id: 1)),
        expect: () => [
          DeleteUserInProgress(),
          isA<DeleteUserFailure>().having(
            (p0) => p0.error,
            'error',
            isA<DeleteUserFailAuthBlocException>(),
          ),
        ],
      );
    });
  });
}
