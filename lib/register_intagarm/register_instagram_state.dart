class RegisterInstagramState {}

class RegisterCheckIsEmptyYourName extends RegisterInstagramState {}

class RegisterCheckIsEmptyEmail extends RegisterInstagramState {}

class RegisterCheckIsEmptyPhone extends RegisterInstagramState {}

class RegisterCheckIsEmptyAge extends RegisterInstagramState {}

class RegisterCheckIsEmptyPassword extends RegisterInstagramState {}

class RegisterCheckIsEmptyConfirmPassword extends RegisterInstagramState {}

class ValidateEmailState extends RegisterInstagramState {}

class ValidateYourNameState extends RegisterInstagramState {}

class ValidatePhoneState extends RegisterInstagramState {}

class ValidateConfirmPasswordState extends RegisterInstagramState {}

class CheckValidateConfirmPasswordStateIsTheSamePassword
    extends RegisterInstagramState {}

class ValidatePasswordState extends RegisterInstagramState {}

class ValidateSuccessState extends RegisterInstagramState {
  final String email;
  final String yourName;
  final String phone;
  final String confirmPassword;
  final String pass;
  final String age;

  ValidateSuccessState(
      {required this.email,
      required this.pass,
      required this.confirmPassword,
      required this.yourName,
      required this.phone,
      required this.age,});
}

