import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:test_giga_mega_solusindo_aldi_irsan_majid/data/model/auth/auth_success_response.dart';

import '../../../core/error/failures.dart';
import '../../../data/repository/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthRepository _authRepository;
  AuthBloc(this._authRepository) : super(AuthInitial()) {
    on<RegisterEvent>((event, emit) async {
      emit(AuthLoading());
      var response = await _authRepository.userRegister(event.userName, event.profileName, event.password);
      var newState = response.fold((l) => AuthFailed(l), (r) => AuthSuccess(r.data ?? const UserData()));
      emit(newState);
    });
    on<LoginEvent>((event, emit) async {
      emit(AuthLoading());
      var response = await _authRepository.userLogin(event.userName, event.password);
      var newState = response.fold((l) => AuthFailed(l), (r) => AuthSuccess(r.data ?? const UserData()));
      emit(newState);
    });
    on<CheckLoginStatusEvent>((event, emit) async {
      emit(AuthLoading());
      var response = await _authRepository.checkLoginStatusCache();
      var newState = response.fold((l) => AuthCacheNotFound(l), (r) => AuthSuccess(r.data ?? const UserData()));
      emit(newState);
    });
    on<LogoutEvent>((event, emit) async {
      emit(AuthLoading());
      var response = await _authRepository.userLogout();
      var newState = response.fold((l) => AuthCacheNotFound(l), (r) => AuthInitial());
      emit(newState);
    });
  }
}
