import 'package:untitled1/model/loginmodel.dart';

abstract class LoginStates{}

class LoginInitialState extends LoginStates{}

class LoginLoadingState extends LoginStates{}

class LoginSuccessState extends LoginStates{
  final LoginModel loginModel;

  LoginSuccessState(this.loginModel);
}

class LoginErrorState extends LoginStates{}

class RegisterLoadingState extends LoginStates{}

class RegisterSuccessState extends LoginStates{
  final LoginModel registerModel;

  RegisterSuccessState(this.registerModel);
}

class RegisterErrorState extends LoginStates{}