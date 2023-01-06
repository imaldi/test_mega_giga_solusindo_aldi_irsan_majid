import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:test_giga_mega_solusindo_aldi_irsan_majid/data/model/auth/auth_success_response.dart';

import '../../../core/error/failures.dart';
import '../../../data/repository/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthRepository authRepository;
  AuthBloc(this.authRepository) : super(AuthInitial()) {
    on<RegisterEvent>((event, emit) async {
      emit(AuthLoading());
      var response = await authRepository.userRegister(event.userName, event.profileName, event.password);
      var newState = response.fold((l) => AuthFailed(l), (r) => AuthSuccess(r.data ?? const UserData()));
      emit(newState);
    });
    on<LoginEvent>((event, emit) async {
      emit(AuthLoading());
      var response = await authRepository.userLogin(event.userName, event.password);
      var newState = response.fold((l) => AuthFailed(l), (r) => AuthSuccess(r.data ?? const UserData()));
      emit(newState);
    });
    on<RegisterEvent>((event, emit) async {
      emit(AuthLoading());
      var response = await authRepository.checkLoginStatusCache();
      var newState = response.fold((l) => AuthFailed(l), (r) => AuthSuccess(r.data ?? const UserData()));
      emit(newState);
    });
  }
}