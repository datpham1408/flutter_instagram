
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_instagram/entity/user_instagram_adapter.dart';
import 'package:flutter_instagram/register_intagarm/register_instagram_cubit.dart';
import 'package:flutter_instagram/router/my_application.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login_instagram/login_instagram_cubit.dart';


final GetIt getIt = GetIt.instance;
SharedPreferences? preferences;
late final FirebaseApp app;
const FirebaseOptions android = FirebaseOptions(
  apiKey: 'AIzaSyAOkHg7z5n1PvZeQBVyH_F57074z6nUX54',
  appId: '1:391240880443:android:5269d3229cb5c0bc78a71e',
  messagingSenderId: '391240880443',
  projectId: 'flutter-sale-application',
  databaseURL: '',
  storageBucket: 'flutter-sale-application.appspot.com',
);


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  app = await Firebase.initializeApp(options: android);
  await initGetIt();
  await initCubit();
  await initHive();
  await initSharedPreferences();
  runApp(const Application());
}

Future<void> initGetIt() async {}

Future<void> initCubit() async {
  getIt.registerFactory<LoginInstagramCubit>(() => LoginInstagramCubit());
  getIt.registerFactory<RegisterInstagramCubit>(() => RegisterInstagramCubit());

}

Future<void> initHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter(UserInstagramAdapter());

}

Future<void> initSharedPreferences() async {}

class Application extends StatelessWidget {
  const Application({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      home: const MyApplication(),
      builder: EasyLoading.init(),
    );
  }
}
