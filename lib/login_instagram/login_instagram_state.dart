
import '../model/user_instagram_model.dart';

class LoginInstagramState {}

class LoginCheckIsEmptyEmail extends LoginInstagramState {}

class LoginCheckIsEmptyPassword extends LoginInstagramState {}

class ValidateEmailState extends LoginInstagramState {}

class ValidatePasswordState extends LoginInstagramState {}

class LoginSuccessState extends LoginInstagramState {
  final UserInstagramModel user;

  LoginSuccessState({required this.user});
}

class LoginFacebook extends LoginInstagramState{
}
class LoadingLoginFacebook extends LoginInstagramState{
}

class ErrorFacebook extends LoginInstagramState {}

class LoginErrorState extends LoginInstagramState {}

