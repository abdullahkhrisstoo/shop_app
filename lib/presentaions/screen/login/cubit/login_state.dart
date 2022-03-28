part of 'login_cubit.dart';

@immutable
abstract class LoginState {
  get userLoginModel => null;
}

//todo : login
class LoginInitial extends LoginState {}

class LoginLoad extends LoginState {}

class LoginSucess extends LoginState {
  @override
  final UserLoginModel userLoginModel;
  LoginSucess(this.userLoginModel);
}

class LoginError extends LoginState {
  final String error;

  LoginError(this.error);
}

//todo : Register
class RegisterLoad extends LoginState {}

class RegisterSucess extends LoginState {
  @override
  final UserLoginModel userLoginModel;
  RegisterSucess(this.userLoginModel);
}

class RegisterError extends LoginState {
  final String error;

  RegisterError(this.error);
}

//todo : update
class UpdateProfileLoad extends LoginState {}

class UpdateProfileSucess extends LoginState {
  @override
  final UserLoginModel userLoginModel;
  UpdateProfileSucess(this.userLoginModel);
}

class UpdateProfileError extends LoginState {
  final String error;

  UpdateProfileError(this.error);
}

class ShowPassword extends LoginState {}
