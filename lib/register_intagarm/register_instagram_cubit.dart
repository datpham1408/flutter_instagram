import 'package:email_validator/email_validator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_instagram/register_intagarm/register_instagram_state.dart';
import 'package:hive/hive.dart';

import '../entity/user_instagram_entity.dart';
import '../resources/hive_key.dart';

class RegisterInstagramCubit extends Cubit<RegisterInstagramState> {
  RegisterInstagramCubit() : super(RegisterInstagramState());

  void checkEmpty(
      {String email = '',
      String yourName = '',
      String password = '',
      String confirmPassword = '',
      String phone = '',
      String age = ''}) {
    if (email.isEmpty) {
      emit(RegisterCheckIsEmptyEmail());
      return;
    }
    if (yourName.isEmpty) {
      emit(RegisterCheckIsEmptyYourName());
      return;
    }
    if (age.isEmpty) {
      emit(RegisterCheckIsEmptyAge());
      return;
    }
    if (phone.isEmpty) {
      emit(RegisterCheckIsEmptyPhone());
      return;
    }
    if (password.isEmpty) {
      emit(RegisterCheckIsEmptyPassword());
      return;
    }
    if (confirmPassword.isEmpty) {
      emit(RegisterCheckIsEmptyConfirmPassword());
      return;
    }
  }

  void checkedAllTextFlied(
      {String email = '',
      String password = '',
      String confirmPassword = '',
      String yourName = '',
      String phone = '',
      String age = ''}) {
    final bool isEmail = EmailValidator.validate(email);
    final bool isPassword = password.length > 6 && password.length < 12;
    final bool isConfirmPassword =
        confirmPassword.length > 6 && confirmPassword.length < 12;
    final bool isYourName = yourName.length >= 8;
    final bool isPhone = phone.length >= 10 && phone.length < 11;

    if (!isEmail) {
      emit(ValidateEmailState());
      return;
    }
    if (!isYourName) {
      emit(ValidateYourNameState());
      return;
    }
    if (!isPhone) {
      emit(ValidatePhoneState());
      return;
    }

    if (!isPassword) {
      emit(ValidatePasswordState());
      return;
    }
    if (!isConfirmPassword) {
      emit(ValidateConfirmPasswordState());
      return;
    }

    if (password != confirmPassword) {
      emit(CheckValidateConfirmPasswordStateIsTheSamePassword());
      return;
    }

    emit(ValidateSuccessState(
        email: email,
        pass: password,
        confirmPassword: confirmPassword,
        yourName: yourName,
        phone: phone,
        age: age));
  }

  Future<void> saveLoginInfo(
      {String email = '',
      String password = '',
      String age = '',
      String phone = '',
      String fullName = ''}) async {
    final box = await Hive.openBox<UserInstagramEntity>(HiveKey.userInstagram);

    final user = UserInstagramEntity()
      ..email = email
      ..phone = phone
      ..password = password
      ..age = age
      ..fullName = fullName;

    await box.add(user);
  }

}
