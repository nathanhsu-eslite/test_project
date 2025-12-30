part of 'auth_bloc.dart';

enum AuthStatus { unknown, authenticated, unauthenticated }

class AuthState extends Equatable {
  const AuthState({this.status = AuthStatus.unauthenticated});

  final AuthStatus status;

  @override
  List<Object> get props => [status];
}
