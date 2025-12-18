import 'package:bloc_test/bloc_test.dart';
import 'package:data/data.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test_3_35_7/features/auth/blocs/register_bloc/register_bloc.dart';
import 'package:domain/domain.dart';
import 'package:test_3_35_7/features/auth/exception/auth_bloc_exception.dart';

class MockRegisterUseCase extends Mock implements RegisterUseCase {}

void main() {
  group('RegisterBloc', () {
    late RegisterUseCase registerUseCase;

    setUp(() {
      registerUseCase = MockRegisterUseCase();
    });

    RegisterBloc buildBloc() {
      return RegisterBloc(registerUseCase: registerUseCase);
    }

    group('constructor', () {
      test('works properly', () => expect(buildBloc, returnsNormally));

      test('has correct initial state', () {
        expect(buildBloc().state, equals(RegisterInitial()));
      });
    });

    group('RegisterSubmitted', () {
      blocTest<RegisterBloc, RegisterState>(
        'emits [RegisterInProgress, RegisterSuccess] when registration succeeds',
        setUp: () {
          when(
            () => registerUseCase(userName: 'user', password: 'password'),
          ).thenAnswer((_) async => {});
        },
        build: buildBloc,
        act: (bloc) => bloc.add(
          const RegisterSubmitted(username: 'user', password: 'password'),
        ),
        expect: () => <RegisterState>[RegisterInProgress(), RegisterSuccess()],
      );

      blocTest<RegisterBloc, RegisterState>(
        'emits [RegisterInProgress, RegisterFailure] when user already exists',
        setUp: () {
          when(
            () => registerUseCase.call(userName: 'user', password: 'password'),
          ).thenAnswer((_) async => throw UsernameAlreadyExistsAuthException());
        },
        build: buildBloc,
        act: (bloc) => bloc.add(
          const RegisterSubmitted(username: 'user', password: 'password'),
        ),
        expect: () => [
          RegisterInProgress(),
          isA<RegisterFailure>().having(
            (p0) => p0.error,
            'error',
            isA<UsernameAlreadyExistsAuthException>(),
          ),
        ],
      );

      blocTest<RegisterBloc, RegisterState>(
        'emits [RegisterFailure] when username is empty',
        build: buildBloc,
        act: (bloc) => bloc.add(
          const RegisterSubmitted(username: '', password: 'password'),
        ),
        expect: () => [
          isA<RegisterFailure>().having(
            (p0) => p0.error,
            'error',
            isA<InvalidRegisterInputAuthBlocException>(),
          ),
        ],
      );

      blocTest<RegisterBloc, RegisterState>(
        'emits [RegisterFailure] when password is empty',
        build: buildBloc,
        act: (bloc) => bloc.add(
          const RegisterSubmitted(username: 'user', password: ''),
        ),
        expect: () => [
          isA<RegisterFailure>().having(
            (p0) => p0.error,
            'error',
            isA<InvalidRegisterInputAuthBlocException>(),
          ),
        ],
      );
    });
  });
}
