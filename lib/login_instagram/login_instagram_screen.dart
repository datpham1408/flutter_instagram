import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';

import '../main.dart';
import '../model/user_instagram_model.dart';
import '../resources/images.dart';
import '../resources/string.dart';
import '../resources/utils.dart';
import '../router/route_constant.dart';
import 'login_instagram_cubit.dart';
import 'login_instagram_state.dart';

class LoginInstagramScreen extends StatefulWidget {
  const LoginInstagramScreen({Key? key}) : super(key: key);

  @override
  State<LoginInstagramScreen> createState() => _LoginInstagramScreenState();
}

class _LoginInstagramScreenState extends State<LoginInstagramScreen> {
  final TextEditingController textEditingControllerEmail =
      TextEditingController();
  final TextEditingController textEditingControllerPassword =
      TextEditingController();
  final LoginInstagramCubit _loginCubit = getIt.get<LoginInstagramCubit>();
  CollectionReference? collectionReference;
  List<String> list = [];
  UserInstagramModel? entity;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {});
  }

  @override
  Widget build(BuildContext context) {
    return FlutterEasyLoading(
      child: Scaffold(
          backgroundColor: Colors.blue.shade100,
          body: SafeArea(
            child: BlocProvider<LoginInstagramCubit>(
              create: (_) => _loginCubit,
              child: BlocConsumer<LoginInstagramCubit, LoginInstagramState>(
                listener: (_, LoginInstagramState state) {
                  _handleListener(state);
                },
                builder: (_, LoginInstagramState state) {
                  return itemBody();
                },
              ),
            ),
          )),
    );
  }

  Future<void> getUser({String? passText, String? emailText}) async {
    try {
      var querySnapshot =
          await FirebaseFirestore.instance.collection('user').get();

      List<QueryDocumentSnapshot<Map<String, dynamic>>> listData =
          querySnapshot.docs;

      for (int i = 0; i < listData.length; i++) {
        Map<String, dynamic> data = listData[i].data();
        String documentId = listData[i].id;

        String password = data['password'];
        String age = data['age'];
        String userName = data['user_name'];
        String phone = data['phone'];
        String idUser = data['id'];

        var userModel = UserInstagramModel(
            userName: userName,
            phone: phone,
            password: password,
            age: age,
            id: documentId,
            idUser: idUser);

        if (password == passText && documentId == emailText) {
          Utils.instance.showToast(thanhCong);
          handleItemClickHome1(userModel: userModel);
          break;
        } else {
          Utils.instance.showToast('That bai');
        }
      }
    } catch (error) {
      print('Lỗi khi lấy dữ liệu người dùng: $error');
    }
  }

  Widget itemBody() {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.all(32),
            child: Image.asset(
              imageInstagram,
              height: 100,
              width: 100,
            ),
          ),
          Utils.instance.sizeBoxHeight(32),
          itemDetailBody(
              text: email, textEditingController: textEditingControllerEmail),
          Utils.instance.sizeBoxHeight(16),
          itemDetailBody(
              text: pass,
              textEditingController: textEditingControllerPassword,
              obscureText: true),
          Utils.instance.sizeBoxHeight(16),
          itemButton(),
          Utils.instance.sizeBoxHeight(10),
          const Text(
            'Bạn quên mật khẩu ư?',
            style: TextStyle(color: Colors.white),
          ),
          Utils.instance.sizeBoxHeight(70),
          itemButtonRegister(),
          Utils.instance.sizeBoxHeight(16),
          GestureDetector(
              onTap: () {
                _loginCubit.signInWithFacebook();
              },
              child: Icon(Icons.facebook)),
          Utils.instance.sizeBoxHeight(16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                imageMeta,
              ),
              Utils.instance.sizeBoxWidth(4),
              const Text(
                'Meta',
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void handleItemClickRegister() {
    GoRouter.of(context).pushNamed(
      routerNameRegisterInstagram,
    );
  }

  Widget itemDetailBody(
      {String text = '',
      TextEditingController? textEditingController,
      bool? obscureText}) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 0.5),
        borderRadius: BorderRadius.circular(16),
        color: Colors.grey.shade200,
      ),
      child: Container(
        margin: EdgeInsets.all(6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              text,
              style: const TextStyle(color: Colors.grey),
            ),
            Container(
              height: 30,
              child: TextField(
                obscureText: obscureText ?? false,
                controller: textEditingController,
                decoration: const InputDecoration(border: InputBorder.none),
                style: TextStyle(fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget itemButton() {
    return GestureDetector(
      onTap: () {
        getUser(
            passText: textEditingControllerPassword.text,
            emailText: textEditingControllerEmail.text);
      },
      child: Container(
        padding: EdgeInsets.all(8),
        width: MediaQuery.of(context).size.width,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.blueAccent,
          borderRadius: BorderRadius.circular(32),
        ),
        child: const Center(
          child: Text(
            login,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget itemButtonRegister() {
    return GestureDetector(
      onTap: () {
        handleItemClickRegister();
      },
      child: Container(
        padding: EdgeInsets.all(8),
        width: MediaQuery.of(context).size.width,
        height: 40,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32),
            border: Border.all(color: Colors.blue)),
        child: const Center(
          child: Text(
            registerAccount,
            style: TextStyle(
              color: Colors.blue,
            ),
          ),
        ),
      ),
    );
  }

  void _handleListener(LoginInstagramState state) {
    if (state is LoginCheckIsEmptyEmail) {
      Utils.instance.showToast(emailEmpty);
      return;
    }
    if (state is LoginCheckIsEmptyPassword) {
      Utils.instance.showToast(passwordEmpty);
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
    if (state is LoginSuccessState) {
      entity = state.user;
      Utils.instance.showToast(thanhCong);
      handleItemClickHome1(userModel: entity);
      return;
    }
    if (state is LoginErrorState) {
      Utils.instance.showToast(userEmpty);
      return;
    }
  }

  void handleItemClickHome1({UserInstagramModel? userModel}) {
    GoRouter.of(context).goNamed(
      routerNameHomeInstagram,
      extra: {'userModel': userModel},
    );
  }

  void handleGoName() {
    GoRouter.of(context).goNamed(routerNameHome);
  }
}
