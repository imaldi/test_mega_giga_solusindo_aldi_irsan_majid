part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();
}

class AuthInitial extends AuthState {
  @override
  List<Object> get props => [];
}
class AuthLoading extends AuthState {
  @override
  List<Object> get props => [];
}
class AuthSuccess extends AuthState {
  UserData userData;
  AuthSuccess(this.userData);
  @override
  List<Object> get props => [userData];
}
class AuthFailed extends AuthState {
  Failure failure;
  AuthFailed(this.failure);
  @override
  List<Object> get props => [failure];
}
