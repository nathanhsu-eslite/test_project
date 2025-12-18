import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test_3_35_7/features/auth/blocs/login_bloc/login_bloc.dart';
import 'package:domain/domain.dart';
import 'package:data/data.dart';
import 'package:test_3_35_7/features/auth/exception/auth_bloc_exception.dart';

class MockLoginUseCase extends Mock implements LoginUseCase {}

void main() {
  group('LoginBloc', () {
    late LoginUseCase loginUseCase;

    setUp(() {
      loginUseCase = MockLoginUseCase();
    });

    LoginBloc buildBloc() {
      return LoginBloc(loginUseCase: loginUseCase);
    }

    group('constructor', () {
      test('works properly', () => expect(buildBloc, returnsNormally));

      test('has correct initial state', () {
        expect(buildBloc().state, equals(LoginInitial()));
      });
    });

    group('LoginSubmitted', () {
      blocTest<LoginBloc, LoginState>(
        'emits [LoginInProgress, LoginSuccess] when login succeeds',
        setUp: () {
          when(
            () => loginUseCase(userName: 'user', password: 'password'),
          ).thenAnswer((_) async => Data.userEntity);
        },
        build: buildBloc,
        act: (bloc) => bloc.add(
          const LoginSubmitted(username: 'user', password: 'password'),
        ),
        expect: () => <LoginState>[
          LoginInProgress(),
          LoginSuccess(user: Data.userEntity),
        ],
      );

      blocTest<LoginBloc, LoginState>(
        'emits [LoginInProgress, LoginFailure] when password is wrong',

        setUp: () {
          when(
            () =>
                loginUseCase.call(userName: 'user', password: 'wrongPassword'),
          ).thenAnswer((_) async => await null);
        },
        build: buildBloc,
        act: (bloc) => bloc.add(
          const LoginSubmitted(username: 'user', password: 'wrongPassword'),
        ),
        expect: () => <Object>[
          LoginInProgress(),
          isA<LoginFailure>().having(
            (p0) => p0.error,
            'error',
            isA<WrongPasswordAuthBlocException>(),
          ),
        ],
      );

      blocTest<LoginBloc, LoginState>(
        'emits [LoginInProgress, LoginFailure] when user not find',
        setUp: () {
          when(
            () => loginUseCase.call(userName: 'user', password: 'password'),
          ).thenAnswer((_) async => throw UserNotFindAuthException());
        },
        build: buildBloc,
        act: (bloc) => bloc.add(
          const LoginSubmitted(username: 'user', password: 'password'),
        ),
        expect: () => <Object>[
          LoginInProgress(),
          isA<LoginFailure>().having(
            (p0) => p0.error,
            'error',
            isA<UserNotFindAuthException>(),
          ),
        ],
      );

      blocTest<LoginBloc, LoginState>(
        'emits [LoginFailure] when username is empty',
        build: buildBloc,
        act: (bloc) =>
            bloc.add(const LoginSubmitted(username: '', password: 'password')),
        expect: () => [
          isA<LoginFailure>().having(
            (p0) => p0.error,
            'error',
            isA<InvalidLoginInputAuthBlocException>(),
          ),
        ],
      );

      blocTest<LoginBloc, LoginState>(
        'emits [LoginFailure] when password is empty',
        build: buildBloc,
        act: (bloc) =>
            bloc.add(const LoginSubmitted(username: 'user', password: '')),
        expect: () => [
          isA<LoginFailure>().having(
            (p0) => p0.error,
            'error',
            isA<InvalidLoginInputAuthBlocException>(),
          ),
        ],
      );
    });
  });
}

class Data {
  static UserEntity userEntity = UserEntity(
    encryptedPassword: 'password',
    username: 'user',
  );
}
