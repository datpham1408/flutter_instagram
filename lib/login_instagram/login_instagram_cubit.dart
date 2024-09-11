import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import '../model/user_instagram_model.dart';
import 'login_instagram_state.dart';

class LoginInstagramCubit extends Cubit<LoginInstagramState> {
  LoginInstagramCubit() : super(LoginInstagramState());
  final FirebaseAuth _auth = FirebaseAuth.instance;
  void checkEmpty({
    String email = '',
    String password = '',
  }) {
    if (email.isEmpty) {
      emit(LoginCheckIsEmptyEmail());
      return;
    }
    if (password.isEmpty) {
      emit(LoginCheckIsEmptyPassword());

      return;
    }
  }


  void checkedAllTextFlied({
    String email = '',
    String password = '',
  }) {
    final bool isEmail = EmailValidator.validate(email);
    final bool isPassword = password.length > 6 && password.length < 12;

    if (!isEmail) {
      emit(ValidateEmailState());
      return;
    }
    if (!isPassword) {
      emit(ValidatePasswordState());
      return;
    }
  }

  Future<void> checkedLogin({
    required String email,
    required String password,
    bool? rememberMe = false,
  }) async {
    var querySnapshot =
        await FirebaseFirestore.instance.collection('instagram').get();
    for (var doc in querySnapshot.docs) {
      Map<String, dynamic> data = doc.data();
      String documentId = doc.id;

      String password = data['password'];
      String age = data['age'];
      String userName = data['user_name'];
      String phone = data['phone'];
      String idUser = data['id'];

      var user = UserInstagramModel(
          userName: userName,
          phone: phone,
          password: password,
          age: age,
          id: documentId,
          idUser: idUser);

      if (documentId.isNotEmpty && password.isNotEmpty) {
        if (documentId == email && password == password) {
          emit(LoginSuccessState(user: user));
        }
      } else {
        emit(LoginErrorState());
      }
    }
  }

  Future<void> signInWithFacebook() async {
    emit(LoadingLoginFacebook());

    try {
      final LoginResult loginResult = await FacebookAuth.instance.login();

      if (loginResult.status == LoginStatus.success) {
        final AuthCredential credential = FacebookAuthProvider.credential(loginResult.accessToken!.tokenString);

        final UserCredential userCredential = await _auth.signInWithCredential(credential);

        if (userCredential.user != null) {
          emit(LoginFacebook());
        } else {
          emit(ErrorFacebook());
        }
      } else {
        emit(ErrorFacebook());
      }
    } catch (e) {
      emit(ErrorFacebook());
    }
  }

}
