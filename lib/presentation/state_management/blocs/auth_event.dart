part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class LoginEvent extends AuthEvent {
  final String userName;
  final String password;
  const LoginEvent(this.userName,this.password);
  @override
  List<Object?> get props => [
    userName,
    password
  ];
}

class RegisterEvent extends AuthEvent {
  final String userName;
  final String password;
  final String profileName;
  const RegisterEvent(this.userName,this.password,this.profileName);
  @override
  List<Object?> get props => [
    userName,
    password,
    profileName
  ];
}

class CheckLoginStatusEvent extends AuthEvent {
  @override
  List<Object?> get props => [];
}

class LogoutEvent extends AuthEvent {
  @override
  List<Object?> get props => [];

}