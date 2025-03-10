part of 'authentication_bloc.dart';

@immutable
sealed class AuthenticationState {}

final class AuthenticationInitial extends AuthenticationState {}

final class AuthenticationLoading extends AuthenticationState {}

final class AuthenticationSuccess extends AuthenticationState {
  final User user;

  AuthenticationSuccess(this.user);
}

final class AuthenticationFailure extends AuthenticationState {
  final String message;

  AuthenticationFailure(this.message);
}

final class AuthenticationLogout extends AuthenticationState {}

final class AuthenticationLogoutFailure extends AuthenticationState {
  final String message;

  AuthenticationLogoutFailure(this.message);
}

final class AuthenticationLogoutSuccess extends AuthenticationState {}

final class AuthenticationGetUserSuccess extends AuthenticationState {
  final User user;

  AuthenticationGetUserSuccess(this.user);
}

final class AuthenticationGetUserFailure extends AuthenticationState {
  final String message;

  AuthenticationGetUserFailure(this.message);
}
