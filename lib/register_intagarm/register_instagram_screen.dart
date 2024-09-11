import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_instagram/register_intagarm/register_instagram_cubit.dart';
import 'package:flutter_instagram/register_intagarm/register_instagram_state.dart';
import 'package:go_router/go_router.dart';

import '../main.dart';
import '../resources/string.dart';
import '../resources/utils.dart';
import '../router/route_constant.dart';

class RegisterInstagramScreen extends StatefulWidget {
  const RegisterInstagramScreen({Key? key}) : super(key: key);

  @override
  State<RegisterInstagramScreen> createState() => _RegisterInstagramScreenState();
}

class _RegisterInstagramScreenState extends State<RegisterInstagramScreen> {
  final TextEditingController _textEditingControllerEmail =
  TextEditingController();
  final TextEditingController _textEditingControllerName =
  TextEditingController();
  final TextEditingController _textEditingControllerAge =
  TextEditingController();
  final TextEditingController _textEditingControllerPass =
  TextEditingController();
  final TextEditingController _textEditingControllerConfirmPass =
  TextEditingController();
  final TextEditingController _textEditingControllerPhone =
  TextEditingController();
  final RegisterInstagramCubit _registerCubit = getIt.get<RegisterInstagramCubit>();

  @override
  Widget build(BuildContext context) {
    return FlutterEasyLoading(
      child: Scaffold(
          body: SafeArea(
            child: BlocProvider<RegisterInstagramCubit>(
              create: (_) => _registerCubit,
              child: BlocConsumer<RegisterInstagramCubit, RegisterInstagramState>(
                listener: (_, RegisterInstagramState state) {
                  _handleListener(state);
                },
                builder: (_, RegisterInstagramState state) {
                  return SingleChildScrollView(child: itemBody());
                },
              ),
            ),
          )),
    );
  }

  Widget itemBody() {
    return Container(
      color: Colors.blueGrey,
      child: Column(
        children: [
          const Text(
            dangKi,
            style: TextStyle(fontSize: 30, color: Colors.white),
          ),
          itemTextFlied(
              text: email, textEditingController: _textEditingControllerEmail),
          itemTextFlied(
              text: fullName,
              textEditingController: _textEditingControllerName),
          itemTextFlied(
              text: age, textEditingController: _textEditingControllerAge),
          itemTextFlied(
              text: phone, textEditingController: _textEditingControllerPhone),
          itemTextFlied(
              text: pass,
              textEditingController: _textEditingControllerPass,
              obscureText: true),
          itemTextFlied(
              text: confirmPass,
              textEditingController: _textEditingControllerConfirmPass,
              obscureText: true),
          GestureDetector(
              onTap: () {
                handleItemClickLogin();
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(alreadyAccount),
              )),
          itemButton(),
        ],
      ),
    );
  }

  void handleItemClickLogin() {
    GoRouter.of(context).pushNamed(
      routerNameLoginInstagram,
    );
  }

  Widget itemButton() {
    return ElevatedButton(
      onPressed: () {
        addUser(emailText: _textEditingControllerEmail.text,
            fullName: _textEditingControllerName.text,
            password: _textEditingControllerPass.text,
            age: _textEditingControllerAge.text,
            phone: _textEditingControllerPhone.text,
            );
      },
      child: const Text(
        registerAccount,
        style: TextStyle(color: Colors.black),
      ),
    );
  }

  void addUser(
      {String? emailText, String? fullName, String? password, String? age,
        String? phone}) {
    Map<String, dynamic> emailData = {
      'user_name': fullName,
      'password': password,
      'age': age,
      'phone': phone,
    };

    FirebaseFirestore.instance
        .collection('instagram')
        .doc(emailText)
        .set(emailData)
        .then((value) {
      print('Thêm user thành công');
      handleItemClickLogin();
    }).catchError((error) {
      print('Lỗi khi thêm user: $error');
    });
  }

  Widget itemTextFlied({String text = '',
    TextEditingController? textEditingController,
    bool? obscureText}) {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Utils.instance.sizeBoxHeight(4),
          Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(36)),
            child: TextField(
              obscureText: obscureText ?? false,
              controller: textEditingController,
              decoration: const InputDecoration(border: InputBorder.none),
            ),
          )
        ],
      ),
    );
  }

  void _handleListener(RegisterInstagramState state) {
    if (state is RegisterCheckIsEmptyEmail) {
      Utils.instance.showToast(emailEmpty);
      return;
    }
    if (state is RegisterCheckIsEmptyYourName) {
      Utils.instance.showToast(fullNameEmpty);
      return;
    }
    if (state is RegisterCheckIsEmptyPassword) {
      Utils.instance.showToast(passwordEmpty);
      return;
    }
    if (state is RegisterCheckIsEmptyConfirmPassword) {
      Utils.instance.showToast(confirmEmpty);
      return;
    }
    if (state is RegisterCheckIsEmptyPhone) {
      Utils.instance.showToast(phoneEmpty);
      return;
    }
    if (state is RegisterCheckIsEmptyAge) {
      Utils.instance.showToast(ageEmpty);
      return;
    }
    if (state is ValidateEmailState) {
      Utils.instance.showToast(emailValidate);
      return;
    }
    if (state is ValidatePasswordState) {
      Utils.instance.showToast(passValidate);
      return;
    }
    if (state is ValidateConfirmPasswordState) {
      Utils.instance.showToast(confirmValidate);
      return;
    }
    if (state is ValidatePhoneState) {
      Utils.instance.showToast(phoneValidate);
      return;
    }
    if (state is ValidateYourNameState) {
      Utils.instance.showToast(fullNameValidate);
      return;
    }
    if (state is CheckValidateConfirmPasswordStateIsTheSamePassword) {
      Utils.instance.showToast(passSameConfirm);
      return;
    }
    if (state is ValidateSuccessState) {
      final String email = state.email;
      final String pass = state.pass;
      final String phone = state.phone;
      final String age = state.age;
      final String fullName = state.yourName;
      _registerCubit.saveLoginInfo(
          email: email,
          password: pass,
          phone: phone,
          age: age,
          fullName: fullName,);
      Utils.instance.showToast('Dang ki thanh cong');
      handleItemClickLogin();
    }
  }
}
