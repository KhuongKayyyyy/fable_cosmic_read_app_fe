import 'package:bloc/bloc.dart';
import 'package:fable_cosmic_read_app_fe/core/constant/app_settings.dart';
import 'package:fable_cosmic_read_app_fe/data/model/user.dart';
import 'package:fable_cosmic_read_app_fe/data/res/user_repo.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/foundation.dart';
part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final storage = const FlutterSecureStorage();
  AuthenticationBloc() : super(AuthenticationInitial()) {
    on<AuthenticationEvent>((event, emit) {});
    on<AuthenticationRequested>(_onAuthenticationRequested);
    on<AuthenticationLogoutRequested>(_onAuthenticationLogoutRequested);
    on<SignUpRequested>(_onSignUpRequested);
    on<AuthenticatioGetUserRequested>(_onGetUserRequested);
  }

  Future<void> _onGetUserRequested(AuthenticatioGetUserRequested event,
      Emitter<AuthenticationState> emit) async {
    emit(AuthenticationLoading());
    try {
      final id = await storage.read(key: AppSettings.currentUser);
      final token = await storage.read(key: AppSettings.token);
      if (id != null && token != null) {
        final user = await UserRepo().getUserById(id: id, token: token);
        emit(AuthenticationGetUserSuccess(user));
      } else {
        emit(AuthenticationGetUserFailure('User ID not found'));
      }
    } catch (e) {
      emit(AuthenticationGetUserFailure(e.toString()));
    }
  }

  Future<void> _onAuthenticationRequested(
      AuthenticationRequested event, Emitter<AuthenticationState> emit) async {
    emit(AuthenticationLoading());
    try {
      final user = await UserRepo()
          .authenticate(email: event.email, password: event.password);
      await storage.write(key: AppSettings.currentUser, value: user.id);
      await storage.write(key: AppSettings.token, value: user.token);
      emit(AuthenticationSuccess(user));
    } catch (e) {
      emit(AuthenticationFailure(e.toString())); // Show actual error message
    }
  }

  Future<void> _onAuthenticationLogoutRequested(
      AuthenticationLogoutRequested event,
      Emitter<AuthenticationState> emit) async {
    emit(AuthenticationLoading());
    await storage.delete(key: AppSettings.currentUser);
    emit(AuthenticationLogoutSuccess());
  }

  Future<void> _onSignUpRequested(
      SignUpRequested event, Emitter<AuthenticationState> emit) async {
    emit(AuthenticationLoading());
    try {
      final user = await UserRepo().signUp(
          email: event.email, password: event.password, name: event.name);
      emit(AuthenticationSuccess(user));
    } catch (e) {
      emit(AuthenticationFailure(e.toString())); // Show actual error
    }
  }
}
