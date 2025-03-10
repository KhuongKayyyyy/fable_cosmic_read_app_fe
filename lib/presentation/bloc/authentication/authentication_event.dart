part of 'authentication_bloc.dart';

@immutable
sealed class AuthenticationEvent {}

class AuthenticationRequested extends AuthenticationEvent {
  final String email;
  final String password;

  AuthenticationRequested({
    required this.email,
    required this.password,
  });
}

class AuthenticationLogoutRequested extends AuthenticationEvent {}

class SignUpRequested extends AuthenticationEvent {
  final String email;
  final String password;
  final String name = "Khuong";

  SignUpRequested({
    required this.email,
    required this.password,
  });
}

class AuthenticatioGetUserRequested extends AuthenticationEvent {}
